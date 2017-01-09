package com.jrelax.web.bi.service;

import com.jrelax.orm.query.Condition;
import com.jrelax.web.bi.entity.BiDatasourceParams;
import com.jrelax.web.support.BaseService;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author zengchao
 * @version 1.0
 * @since 1.0
 */
@Service
public class BiDatasourceParamsService extends BaseService<BiDatasourceParams> {

    public Map<String, String> getParamsForMap(String datasourceId){
        Map<String, String> paramsMap = new HashMap<>();
        List<BiDatasourceParams> paramList = super.list(Condition.NEW().eq("datasource.id", datasourceId).asc("field"));
        if(paramList.size()>0){
            for(BiDatasourceParams param : paramList){
                paramsMap.put(param.getField(), param.getDefaultValue());
            }
        }
        return paramsMap;
    }
}
