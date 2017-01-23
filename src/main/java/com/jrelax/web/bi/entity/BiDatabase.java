package com.jrelax.web.bi.entity;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;

/**
 * @author zengchao
 * @version 1.0
 * @since 1.0
 */
@Entity
@Table(name = "bi_database")
@DynamicUpdate(true)
public class BiDatabase implements Serializable{
	
	private static final long serialVersionUID = 3509941384851901401L;
	
			 			@Id
			@GenericGenerator(name="idGenerator", strategy="uuid")
			@GeneratedValue(generator="idGenerator")
						private String id; //ID
														@Column
										@NotNull
							private String name;//数据库名称
																	@Column
										@NotNull
							private String type;//数据库类型
																	@Column
										@NotNull
							private String driver;//数据库驱动
																	@Column
										@NotNull
							private String host;//主机地址
																	@Column
										@NotNull
							private Integer port;//端口
																	@Column
										@NotNull
							private String dbName;//数据库名
																	@Column
										@NotNull
							private String url;//数据库连接
																	@Column
										@NotNull
							private String username;//数据库用户名
																	@Column
										private String password;//数据库密码
																	@Column
										@NotNull
							private Integer invokes;//调用次数
																	@Column
										@NotNull
							private String createUser;//创建人
																	@Column
										@NotNull
							private String createTime;//创建时间
							
				/**
	 * 获取 ID
	 */
	public String getId(){
		return this.id;
	}
		/**
    	 * 设置 ID
    	 */
    	public void setId(String id){
    		this.id = id;
    	}
					/**
	 * 获取 数据库名称
	 */
	public String getName(){
		return this.name;
	}
		/**
    	 * 设置 数据库名称
    	 */
    	public void setName(String name){
    		this.name = name;
    	}
					/**
	 * 获取 数据库类型
	 */
	public String getType(){
		return this.type;
	}
		/**
    	 * 设置 数据库类型
    	 */
    	public void setType(String type){
    		this.type = type;
    	}
					/**
	 * 获取 数据库驱动
	 */
	public String getDriver(){
		return this.driver;
	}
		/**
    	 * 设置 数据库驱动
    	 */
    	public void setDriver(String driver){
    		this.driver = driver;
    	}
					/**
	 * 获取 主机地址
	 */
	public String getHost(){
		return this.host;
	}
		/**
    	 * 设置 主机地址
    	 */
    	public void setHost(String host){
    		this.host = host;
    	}
					/**
	 * 获取 端口
	 */
	public Integer getPort(){
		return this.port;
	}
		/**
    	 * 设置 端口
    	 */
    	public void setPort(Integer port){
    		this.port = port;
    	}
					/**
	 * 获取 数据库名
	 */
	public String getDbName(){
		return this.dbName;
	}
		/**
    	 * 设置 数据库名
    	 */
    	public void setDbName(String dbName){
    		this.dbName = dbName;
    	}
					/**
	 * 获取 数据库连接
	 */
	public String getUrl(){
		return this.url;
	}
		/**
    	 * 设置 数据库连接
    	 */
    	public void setUrl(String url){
    		this.url = url;
    	}
					/**
	 * 获取 数据库用户名
	 */
	public String getUsername(){
		return this.username;
	}
		/**
    	 * 设置 数据库用户名
    	 */
    	public void setUsername(String username){
    		this.username = username;
    	}
					/**
	 * 获取 数据库密码
	 */
	public String getPassword(){
		return this.password;
	}
		/**
    	 * 设置 数据库密码
    	 */
    	public void setPassword(String password){
    		this.password = password;
    	}
					/**
	 * 获取 调用次数
	 */
	public Integer getInvokes(){
		return this.invokes;
	}
		/**
    	 * 设置 调用次数
    	 */
    	public void setInvokes(Integer invokes){
    		this.invokes = invokes;
    	}
					/**
	 * 获取 创建人
	 */
	public String getCreateUser(){
		return this.createUser;
	}
		/**
    	 * 设置 创建人
    	 */
    	public void setCreateUser(String createUser){
    		this.createUser = createUser;
    	}
					/**
	 * 获取 创建时间
	 */
	public String getCreateTime(){
		return this.createTime;
	}
		/**
    	 * 设置 创建时间
    	 */
    	public void setCreateTime(String createTime){
    		this.createTime = createTime;
    	}
		}
