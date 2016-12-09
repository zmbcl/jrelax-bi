package com.jrelax.web.entity.bi;

import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;


/**
 * @author zengchao
 * @version 1.0
 * @since 1.0
 */
@Entity
@Table(name = "bi_datasource_params")
@DynamicUpdate(true)
public class BiDatasourceParams implements Serializable {
    private static final long serialVersionUID = 3509941384851901401L;
    @Id
    @GenericGenerator(name = "idGenerator", strategy = "uuid")
    @GeneratedValue(generator = "idGenerator")
    private String id; //ID
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dsId")
    private BiDatasource datasource;
    @Column
    @NotNull
    private String field; //字段
    @Column
    private String defaultValue; //默认值

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
    * 获取 数据源
    */
    public BiDatasource getDatasource() {
        return this.datasource;
    }

    /**
     * 设置 数据源
     */
    public void setDatasource(BiDatasource datasource) {
        this.datasource = datasource;
    }

    /**
    * 获取 字段
    */
    public String getField() {
        return this.field;
    }

    /**
     * 设置 字段
     */
    public void setField(String field) {
        this.field = field;
    }

    /**
    * 获取 默认值
    */
    public String getDefaultValue() {
        return this.defaultValue;
    }

    /**
     * 设置 默认值
     */
    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }
}
