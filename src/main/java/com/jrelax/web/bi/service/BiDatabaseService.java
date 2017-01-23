package com.jrelax.web.bi.service;

import com.jrelax.web.support.BaseService;
import com.jrelax.web.bi.entity.BiDatabase;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author zengchao
 * @version 1.0
 * @since 1.0
 */
@Service
public class BiDatabaseService extends BaseService<BiDatabase>{
    /**
     * 转换为JDBC连接
     *
     * @param type
     * @param host
     * @param port
     * @param dbName
     * @return
     */
    public String toUrl(String type, String host, int port, String dbName) {
        Map<String, String> dbJdbc = getDataDict().getMap("bi_db_jdbc_url");
        String template = dbJdbc.get(type);
        if (template != null) {
            return template.replace("${host}", host).replace("${port}", port + "").replace("${db}", dbName);
        }
        return null;
    }

    /**
     * 获取JDBC驱动
     *
     * @param type
     * @return
     */
    public String getDriver(String type) {
        Map<String, String> dbDriver = getDataDict().getMap("bi_db_driver");
        return dbDriver.get(type);
    }
}
