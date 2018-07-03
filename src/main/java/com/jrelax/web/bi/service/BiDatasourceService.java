package com.jrelax.web.bi.service;

import com.jrelax.bi.DBKit;
import com.jrelax.bi.DBPool;
import com.jrelax.kit.ObjectKit;
import com.jrelax.kit.StringKit;
import com.jrelax.orm.query.Condition;
import com.jrelax.web.bi.entity.BiDatasource;
import com.jrelax.web.bi.entity.BiDatasourceMeta;
import com.jrelax.web.bi.entity.BiDatasourceParams;
import com.jrelax.web.support.BaseService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author zengchao
 * @version 1.0
 * @since 1.0
 */
@Service
public class BiDatasourceService extends BaseService<BiDatasource> {
    @Autowired
    private BiDatasourceParamsService biDatasourceParamsService;
    @Autowired
    private BiDatasourceMetaService biDatasourceMetaService;

    public void save(BiDatasource biDatasource, String[] field, String[] defaultValue) {
        super.save(biDatasource);
        //保存查询参数
        if (ObjectKit.isNotNull(field)) {
            for (int i = 0; i < field.length; i++) {
                String f = field[i];
                if (StringKit.isEmpty(f)) continue;
                String def = defaultValue[i];
                BiDatasourceParams mp = new BiDatasourceParams();
                mp.setDatasource(biDatasource);
                mp.setField(f);
                mp.setDefaultValue(def);

                biDatasourceParamsService.save(mp);
            }
        }
    }

    @Override
    public void delete(Serializable id) {
        super.executeBatch("delete from BiDatasourceParams where datasource.id=?", id);
        super.delete(id);
    }


    public List<Map<String, Object>> getData(String id, Map<String, String> params) {
        List<Map<String, Object>> data = null;
        BiDatasource ds = super.getById(id);
        if (ObjectKit.isNotNull(ds)) {
            //虚拟数据源，单独处理
            //处理逻辑说明：
            //1. 从所有子数据源中提取出结构和数据
            //2. 将子数据源中的数据转换为H2数据库表
            //3. 将配置的sql替换表名后执行
            //4. 清理H2中创建的表
            if (ds.isVirtuald()) {
                DBKit dbKit = new DBKit(DBPool.getInstance().getBIExchangeDataSource());
                String[] ids = ds.getVirtualLinkIds().split(",");
                String sql = ds.getSqlCmd();
                List<String> dropSqlList = new ArrayList<>();
                for (int i = 0; i < ids.length; i++) {
                    String cid = ids[i];
                    String tableName = "bi_exchange_" + cid + "_" + System.currentTimeMillis();
                    List<String> keyList = this.getMetadata(cid);
                    //删除表
                    String dropSql = "drop table if exists " + tableName;
                    dropSqlList.add(dropSql);
                    dbKit.execute(dropSql);

                    //创建表
                    StringBuffer createTableSql = new StringBuffer("create table " + tableName + " (");
                    for (String key : keyList) {
                        createTableSql.append(key).append(" varchar(100),");
                    }
                    createTableSql = new StringBuffer(createTableSql.substring(0, createTableSql.length() - 1));
                    createTableSql.append(")");
                    dbKit.execute(createTableSql.toString());

                    //导入数据
                    List<Map<String, Object>> mapList = this.getData(cid, null);
                    for (Map<String, Object> map : mapList) {
                        StringBuilder insertSql = new StringBuilder("insert into `" + tableName + "`(" + StringKit.toString(keyList) + ") values(");
                        for (String key : keyList) {
                            insertSql.append(String.format("'%s',", map.get(key)));
                        }
                        insertSql = new StringBuilder(insertSql.substring(0, insertSql.length() - 1));
                        insertSql.append(")");

                        dbKit.execute(insertSql.toString());
                    }

                    sql = sql.replace("{" + i + "}", tableName);
                }
                System.out.println("H2：" + sql);
                data = dbKit.listToMap(sql);
                //清理
                for (String dropSql : dropSqlList) {
                    dbKit.execute(dropSql);
                }
            } else {
                //获取参数列表
                List<BiDatasourceParams> paramList = biDatasourceParamsService.list(Condition.NEW().eq("datasource", ds).asc("field"));
                if (paramList.size() > 0) {
                    Map<String, String> paramsMap = new HashMap<>();
                    for (BiDatasourceParams param : paramList) {
                        String value = "";
                        if (params != null) {
                            value = params.get(param.getField());
                        }
                        if (ObjectKit.isNull(value))
                            value = param.getDefaultValue();
                        if (ObjectKit.isNull(value))
                            value = "";
                        paramsMap.put(param.getField(), value);
                    }

                    ds.setSqlCmd(mergeSql(ds.getSqlCmd(), paramsMap));
                }
                DBKit dbKit = new DBKit(DBPool.getInstance().getDataSource(ds.getDb()));
                data = dbKit.listToMap(ds.getSqlCmd());
            }

        }

        return data;
    }

    public String mergeSql(String sql, String[] field, String[] value) {
        //转换成MAP
        Map<String, String> paramsMap = new HashMap<>();
        if (ObjectKit.isNotNull(field)) {
            for (int i = 0; i < field.length; i++) {
                paramsMap.put(field[i], value[i]);
            }
        }
        return mergeSql(sql, paramsMap);
    }

    public String mergeSql(String sql, Map<String, String> paramsMap) {
        String regex = "\\{#(\\S+)#\\}";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(sql);
        while (matcher.find()) {
            String name = matcher.group(1);
            String v = paramsMap.get(name);
            if (ObjectKit.isNotNull(v))
                sql = matcher.replaceAll(paramsMap.get(name));
        }
        return sql;
    }

    /**
     * 获取数据源结构
     * 如果数据库中未缓存结构，那么在第一次获取结构后，缓存到数据库中提高效率
     *
     * @param id
     * @return
     */
    @Transactional
    public List<String> getMetadata(String id) {
        List<String> list = new ArrayList<>();
        List<BiDatasourceMeta> listMap = biDatasourceMetaService.list(Condition.NEW().eq("datasource.id", id));
        //如果数据库存在记录，直接返回
        if (listMap.size() == 0) {
            listMap = biDatasourceMetaService.getMetadataForEntity(id);
            biDatasourceMetaService.save(listMap);
        }
        for (BiDatasourceMeta meta : listMap) {
            list.add(meta.getLabel());
        }
        return list;
    }

    /***************************数据源数据格式转换**********************************/
    public JSONArray toJSON(List<Map<String, Object>> list) {
        JSONArray data = new JSONArray();
        for (Map<String, Object> map : list) {
            JSONObject obj = new JSONObject();
            for (String key : map.keySet()) {
                Object value = map.get(key);
                if (value != null)
                    obj.element(key, value.toString());
                else
                    obj.element(key, "");
            }

            data.add(obj);
        }
        return data;
    }

    public String toXML(List<Map<String, Object>> data) {
        StringBuffer xml = new StringBuffer();
        xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<list>\n");
        for (Map<String, Object> map : data) {
            xml.append("  <data>\n");
            Iterator<String> iter = map.keySet().iterator();
            while (iter.hasNext()) {
                String key = iter.next();
                Object val = map.get(key);

                xml.append("    <prop key=\"" + key + "\">\n      <![CDATA[" + val + "]]>\n    </prop>\n");
            }
            xml.append("  </data>\n");
        }
        xml.append("</list>\n");
        return xml.toString();
    }

    public String toHTML(List<Map<String, Object>> data) {
        StringBuffer html = new StringBuffer("<table class='table table-bordered table-condensed'>");
        StringBuffer head = new StringBuffer("<thead><tr>");
        StringBuffer body = new StringBuffer("<tbody><tr>");

        for (int i = 0; i < data.size(); i++) {
            Map<String, Object> map = data.get(i);
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                if (i == 0) {
                    head.append("<th>").append(entry.getKey()).append("</th>");
                }
                body.append("<td>").append(entry.getValue()).append("</td>");
            }
            body.append("</tr><tr>");
        }

        head.append("</tr></thead>");
        body.append("</tr></tbody>");
        html.append(head).append(body).append("</table>");
        return html.toString();
    }
}
