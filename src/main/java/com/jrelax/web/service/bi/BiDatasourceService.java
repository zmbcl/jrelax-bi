package com.jrelax.web.service.bi;

import com.jrelax.kit.ObjectKit;
import com.jrelax.kit.RegexKit;
import com.jrelax.kit.StringKit;
import com.jrelax.orm.query.Condition;
import com.jrelax.web.entity.bi.BiDatasource;
import com.jrelax.web.entity.bi.BiDatasourceParams;
import com.jrelax.web.service.BaseService;
import net.sf.json.JSONArray;
import org.hibernate.jdbc.Work;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
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
    public void save(BiDatasource biDatasource, String[] field, String[] defaultValue) {
        super.save(biDatasource);
        if(ObjectKit.isNotNull(field)){
            for(int i=0;i<field.length;i++){
                String f = field[i];
                if(StringKit.isEmpty(f)) continue;
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


    public List<Map<String, Object>> getData(String id, Map<String, String> params){
        List<Map<String, Object>> data = null;
        BiDatasource ds = super.getById(id);
        if(ObjectKit.isNotNull(ds)){
            //获取参数列表
            List<BiDatasourceParams> paramList = biDatasourceParamsService.list(Condition.NEW().eq("datasource", ds).asc("field"));
            if(paramList.size()>0){
                Map<String, String> paramsMap = new HashMap<>();
                for(BiDatasourceParams param : paramList){
                    String value = params.get(param.getField());
                    if(ObjectKit.isNull(value))
                        value = param.getDefaultValue();

                    paramsMap.put(param.getField(), value);
                }

                ds.setSqlCmd(parseSql(ds.getSqlCmd(), paramsMap));
            }
            data = super.nativeListToMap(ds.getSqlCmd());
        }

        return data;
    }

    public String toJSON(List<Map<String, Object>> data){
        JSONArray array = JSONArray.fromObject(data);
        return array.toString();
    }

    public String toXML(List<Map<String, Object>> data){
        StringBuffer xml = new StringBuffer();
        xml.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><list>");
        for(Map<String, Object> map : data){
            xml.append("<data>");
            Iterator<String> iter = map.keySet().iterator();
            while(iter.hasNext()){
                String key = iter.next();
                Object val = map.get(key);

                xml.append("<prop key=\""+key+"\"><![CDATA["+val+"]]></prop>");
            }
            xml.append("</data>");
        }
        xml.append("</list>");
        return xml.toString();
    }

    public String toHTML(List<Map<String, Object>> data) {
        StringBuffer html = new StringBuffer("<table class='table table-bordered table-condensed'>");
        StringBuffer head = new StringBuffer("<thead><tr>");
        StringBuffer body = new StringBuffer("<tbody><tr>");

        for(int i=0;i<data.size();i++){
            Map<String, Object> map = data.get(i);
            for(Map.Entry<String, Object> entry : map.entrySet()){
                if(i == 0){
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

    public String parseSql(String sql, String[] field, String[] value) {
        //转换成MAP
        Map<String, String> paramsMap = new HashMap<>();
        if(ObjectKit.isNotNull(field)){
            for(int i=0;i<field.length;i++){
                paramsMap.put(field[i], value[i]);
            }
        }
        return parseSql(sql, paramsMap);
    }

    public String parseSql(String sql, Map<String, String> paramsMap){
        String regex = "\\{#(\\S+)#\\}";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(sql);
        while(matcher.find()){
            String name = matcher.group(1);
            String v = paramsMap.get(name);
            if(ObjectKit.isNotNull(v))
                sql = matcher.replaceAll(paramsMap.get(name));
        }
        return sql;
    }

    public List<String> getMetadata(String id) {
        List<String> list = new ArrayList<>();
        BiDatasource datasource = super.getById(id);
        if(ObjectKit.isNotNull(datasource)){
            String sql = datasource.getSqlCmd();
            this.baseDao.getSession().doWork(new Work() {
                @Override
                public void execute(Connection connection) throws SQLException {
                    ResultSet rs = connection.createStatement().executeQuery(sql);


                    ResultSetMetaData metaData = rs.getMetaData();

                    for (int i = 1; i <= metaData.getColumnCount(); i++) {
                        list.add(metaData.getColumnLabel(i));
                    }
                }
            });

        }
        return list;
    }
}
