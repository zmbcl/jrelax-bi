package com.jrelax.web.bi.entity;

import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;

import java.io.Serializable;

import javax.persistence.*;


/**
 * @author zengchao
 * @version 1.0
 * @since 1.0
 */
@Entity
@Table(name = "bi_report_data")
@DynamicUpdate(true)
public class BiReportData implements Serializable {
    private static final long serialVersionUID = 3509941384851901401L;
    @Id
    @GenericGenerator(name = "idGenerator", strategy = "uuid")
    @GeneratedValue(generator = "idGenerator")
    private String id; //ID
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "reportId")
    private BiReport report; //报表
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dsId")
    private BiDatasource datasource; //数据源

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
    * 获取 报表
    */
    public BiReport getReport() {
        return this.report;
    }

    /**
    * 设置 报表
    */
    public void setReport(BiReport report) {
        this.report = report;
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
}
