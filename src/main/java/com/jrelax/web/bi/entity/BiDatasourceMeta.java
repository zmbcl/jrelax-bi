package com.jrelax.web.bi.entity;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * 数据源字段信息
 * Created by zengchao on 2016-12-15.
 */
@Entity
@Table(name="bi_datasource_meta")
public class BiDatasourceMeta implements Serializable{
    private static final long serialVersionUID = 3509941384851901401L;
    @Id
    @GenericGenerator(name = "idGenerator", strategy = "uuid")
    @GeneratedValue(generator = "idGenerator")
    private String id; //ID
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dsId")
    private BiDatasource datasource; //关联数据源
    @Column
    @NotNull
    private String name; //名称
    @Column
    @NotNull
    private String label; //标签
    @Column
    @NotNull
    private String type; //类型

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public BiDatasource getDatasource() {
        return datasource;
    }

    public void setDatasource(BiDatasource datasource) {
        this.datasource = datasource;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
