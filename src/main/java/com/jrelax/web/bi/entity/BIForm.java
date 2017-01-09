package com.jrelax.web.bi.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 工作流对应的表单类
 * @author zengchao
 *
 */
@Entity
@Table(name="bi_form")
public class BIForm implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8210688383724382838L;
	
	@Id
	@GenericGenerator(name="idGenerator", strategy="uuid")
	@GeneratedValue(generator="idGenerator")
	private String id;
	@Column
	private String name;//表单名称
	@Column
	private String tip;//表单提交完成提示
	@Column
	private String primaryTable;//主表
	@Column
	private String tableName;//对应表名
	@Column
	private String source;//html源码
	@Column
	private String content;//解析后的html
	@Column
	private String version;
	@Column
	private String createUser;//创建人
	@Column
	private String createTime;//创建时间
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTip() {
		return tip;
	}
	public void setTip(String tip) {
		this.tip = tip;
	}
	public String getPrimaryTable() {
		return primaryTable;
	}
	public void setPrimaryTable(String primaryTable) {
		this.primaryTable = primaryTable;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
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
