package com.jrelax.third.form;

import com.jrelax.kit.StringKit;
import com.jrelax.web.support.BaseService;
import org.apache.commons.lang.math.RandomUtils;

import java.util.Map;

/**
 * 表单数据表生成
 * Created by zengchao on 2017-02-17.
 */
public class FormTableBuilder {
    private String tablePrefix = "wf_form_";
    private String tableName = "";
    private BaseService baseService;

    public FormTableBuilder(BaseService baseService, String tableName) {
        this.baseService = baseService;
        if(StringKit.isEmpty(tableName))
            this.tableName = tablePrefix + System.currentTimeMillis() + RandomUtils.nextInt(2);
        else
            this.tableName = tableName;
    }

    /**
     * 删除表格
     *
     * @return
     */
    public boolean dropTable() {
        baseService.executeSqlBatch("drop table if exists " + tableName);
        return true;
    }

    /**
     * 创建表格
     *
     * @param columnMapping
     * @return
     */
    public boolean createTable(Map<String, String> columnMapping) {
        if (this.dropTable()) {
            //生成-更新数据表
            if (!columnMapping.isEmpty()) {
                String sql = "create table " + tableName + " ( `id` varchar(32),";
                for (String key : columnMapping.keySet()) {
                    String tag = columnMapping.get(key);
                    if (tag.equals("textarea"))
                        sql += "`" + key + "`" + " text,";
                    else
                        sql += "`" + key + "`" + " varchar(100),";
                }
                sql += "PRIMARY KEY (`id`) )";
                //创建表
                baseService.executeSqlBatch(sql);
            }
        }
        return true;
    }

    public String getTableName() {
        return tableName;
    }
}
