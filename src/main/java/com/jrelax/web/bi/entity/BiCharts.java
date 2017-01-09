package com.jrelax.web.bi.entity;

import com.jrelax.web.support.BaseEntity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

/**
 * 图表实体类
 * Created by zengchao on 2016-12-03.
 */
@Entity
@Table(name="bi_charts")
public class BiCharts extends BaseEntity{

    @Column
    @NotNull
    private String name;//图表名称
    @Column
    @NotNull
    private String type;//图表类型
    @Column
    @NotNull
    private String configs;//图表配置
    @Column
    @NotNull
    private String createUser;//创建人
    @Column
    @NotNull
    private String createTime;//创建时间

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getConfigs() {
        return configs;
    }

    public void setConfigs(String configs) {
        this.configs = configs;
    }

    public String getCreateUser() {
        return createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
}
