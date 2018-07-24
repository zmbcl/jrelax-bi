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
@Table(name = "bi_report")
@DynamicUpdate(true)
public class BiReport implements Serializable {
    private static final long serialVersionUID = 3509941384851901401L;
    @Id
    @GenericGenerator(name = "idGenerator", strategy = "uuid")
    @GeneratedValue(generator = "idGenerator")
    private String id; //ID
    @Column
    @NotNull
    private String name; //报表名称
    @Column
    private String descript; //描述
    @Column
    private String source; //源码
    @Column
    private String content; //生成代码
    @Column(name = "search_form_id")
    private String searchFormId;//搜索表单ID
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
    * 获取 报表名称
    */
    public String getName() {
        return this.name;
    }

    /**
    * 设置 报表名称
    */
    public void setName(String name) {
        this.name = name;
    }

    /**
    * 获取 描述
    */
    public String getDescript() {
        return this.descript;
    }

    /**
    * 设置 描述
    */
    public void setDescript(String descript) {
        this.descript = descript;
    }

    /**
    * 获取 源码
    */
    public String getSource() {
        return this.source;
    }

    /**
    * 设置 源码
    */
    public void setSource(String source) {
        this.source = source;
    }

    /**
    * 获取 生成代码
    */
    public String getContent() {
        return this.content;
    }

    /**
    * 设置 生成代码
    */
    public void setContent(String content) {
        this.content = content;
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

    public String getSearchFormId() {
        return searchFormId;
    }

    public void setSearchFormId(String searchFormId) {
        this.searchFormId = searchFormId;
    }
}
