package com.jrelax.web.bi.entity;

import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import javax.validation.constraints.NotNull;


/**
 * @author zengchao
 * @version 1.0
 * @since 1.0
 */
@Entity
@Table(name = "bi_datasource")
@DynamicUpdate(true)
public class BiDatasource implements Serializable {
    private static final long serialVersionUID = 3509941384851901401L;
    @Id
    @GenericGenerator(name = "idGenerator", strategy = "uuid")
    @GeneratedValue(generator = "idGenerator")
    private String id; //ID
    @Column
    @NotNull
    private String name; //name
    @Column
    @NotNull
    private String sqlCmd; //sqlCmd
    @Column
    @NotNull
    private String createUser; //创建人
    @Column
    @NotNull
    private String createTime; //创建时间

    /**
     * 获取 ID
     */
    public String getId() {
        return this.id;
    }

    /**
     * 设置 ID
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * 获取 name
     */
    public String getName() {
        return this.name;
    }

    /**
     * 设置 name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 获取 sqlCmd
     */
    public String getSqlCmd() {
        return this.sqlCmd;
    }

    /**
     * 设置 sqlCmd
     */
    public void setSqlCmd(String sqlCmd) {
        this.sqlCmd = sqlCmd;
    }

    /**
     * 获取 创建人
     */
    public String getCreateUser() {
        return this.createUser;
    }

    /**
     * 设置 创建人
     */
    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    /**
     * 获取 创建时间
     */
    public String getCreateTime() {
        return this.createTime;
    }

    /**
     * 设置 创建时间
     */
    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
}
