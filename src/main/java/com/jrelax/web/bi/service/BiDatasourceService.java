package com.jrelax.web.bi.service;

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
                    if(ObjectKit.isNull(value))
                        value = "";
                    paramsMap.put(param.getField(), value.toString());
                }

                ds.setSqlCmd(mergeSql(ds.getSqlCmd(), paramsMap));
            }
            data = super.nativeListToMap(ds.getSqlCmd());
        }

        return data;
    }

    public String mergeSql(String sql, String[] field, String[] value) {
        //转换成MAP
        Map<String, String> paramsMap = new HashMap<>();
        if(ObjectKit.isNotNull(field)){
            for(int i=0;i<field.length;i++){
                paramsMap.put(field[i], value[i]);
            }
        }
        return mergeSql(sql, paramsMap);
    }

    public String mergeSql(String sql, Map<String, String> paramsMap){
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

    /**
     * 获取数据源结构
     * 如果数据库中未缓存结构，那么在第一次获取结构后，缓存到数据库中提高效率
     * @param id
     * @return
     */
    @Transactional
    public List<String> getMetadata(String id) {
        List<String> list = new ArrayList<>();
        List<BiDatasourceMeta> listMap = biDatasourceMetaService.list(Condition.NEW().eq("datasource.id", id));
        //如果数据库存在记录，直接返回
        if(listMap.size() == 0){
            listMap = biDatasourceMetaService.getMetadataForEntity(id);
            biDatasourceMetaService.save(listMap);
            System.out.println("获取并保存入库");
        }
        for(BiDatasourceMeta meta : listMap){
            list.add(meta.getLabel());
        }
        return list;
    }

    /***************************数据源数据格式转换**********************************/
    public JSONArray toJSON(List<Map<String, Object>> list){
        JSONArray data = new JSONArray();
        for (Map<String, Object> map : list) {
            JSONObject obj = new JSONObject();
            Iterator<String> iter = map.keySet().iterator();
            while (iter.hasNext()) {
                String key = iter.next();
                Object value = map.get(key);
                if(value != null)
                    obj.element(key, value.toString());
                else
                    obj.element(key, "");
            }

            data.add(obj);
        }
        return data;
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
}
