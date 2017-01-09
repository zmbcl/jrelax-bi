package com.jrelax.web.bi.controller;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import com.jrelax.kit.ObjectKit;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.ddlutils.Platform;
import org.apache.ddlutils.PlatformFactory;
import org.apache.ddlutils.model.Column;
import org.apache.ddlutils.model.Database;
import org.apache.ddlutils.model.Table;
import org.apache.ddlutils.model.TypeMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jrelax.kit.ClassKit;
import com.jrelax.kit.StringKit;
import com.jrelax.core.web.support.WebResult;
import com.jrelax.orm.query.PageBean;

@Controller
@RequestMapping("/bi/table")
public class BiTableController {
	private final String TPL = "/bi/table/";
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	private DataSource multiDataSource;
	
	@RequestMapping(method={RequestMethod.GET, RequestMethod.POST})
	public String index(Model model, PageBean pageBean){
		Platform platform = PlatformFactory.createNewPlatformInstance(multiDataSource);
		try {
			Connection conn = platform.getDataSource().getConnection();
			String catalog = conn.getCatalog();
			Database db = platform.readModelFromDatabase(catalog);
			model.addAttribute("tables", db.getTables());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		logger.debug("访问动态添加数据库表");
		return TPL + "index";
	}
	
	/**
	 * 创建新表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/create", method={RequestMethod.GET, RequestMethod.POST})
	public String create(Model model){
		Platform platform = PlatformFactory.createNewPlatformInstance(multiDataSource);
		try {
			Connection conn = platform.getDataSource().getConnection();
			//String schema = conn.getSchema();
			String catalog = conn.getCatalog();
			model.addAttribute("catalog", catalog);
			model.addAttribute("schema", "");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.addAttribute("columnTypes", ClassKit.getFields(TypeMap.class));
		return TPL + "create";
	}
	
	@RequestMapping(value="/create/do", method={RequestMethod.POST})
	@ResponseBody
	public JSONObject doCreate(Table table, String columns){
		try{
			Platform platform = PlatformFactory.createNewPlatformInstance(multiDataSource);
			Connection conn = platform.getDataSource().getConnection();
			String catalog = conn.getCatalog();
			Database db = platform.readModelFromDatabase(catalog);
			Table eqTable = db.findTable(table.getName());
			if(ObjectKit.isNotNull(eqTable)){
				return WebResult.error("表 '"+table.getName()+"' 已存在！");
			}
			JSONArray jColumns = JSONArray.fromObject("["+columns+"]");
			for(Object col : jColumns){
				JSONObject jColumn = JSONObject.fromObject(col);
				
				Column column = new Column();
				column.setName(jColumn.getString("name"));
				column.setType(jColumn.getString("type"));
				if(!StringKit.isEmpty(jColumn.getString("size")))
					column.setSize(jColumn.getString("size"));
				column.setPrimaryKey(jColumn.getBoolean("pk"));
				if(!column.isPrimaryKey())
					column.setDefaultValue(jColumn.getString("def"));
				column.setRequired(jColumn.getBoolean("notNull"));
				column.setAutoIncrement(jColumn.getBoolean("autoIncr"));
				column.setDescription(jColumn.getString("comment"));
				
				table.addColumn(column);
			}
			Database db2 = new Database();
			db2.addTable(table);
			platform.createTables(db2, false, false);
			return WebResult.success();
		}catch(Exception e){
			e.printStackTrace();
			logger.error(e.toString());
			return WebResult.error(e);
		}
	}
	
	/**
	 * 修改表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/alter/{name}", method={RequestMethod.GET, RequestMethod.POST})
	public String alter(Model model, @PathVariable String name){
		Platform platform = PlatformFactory.createNewPlatformInstance(multiDataSource);
		try {
			Connection conn = platform.getDataSource().getConnection();
			String catalog = conn.getCatalog();
			Database db = platform.readModelFromDatabase(catalog);
			Table table = db.findTable(name);
			model.addAttribute("table", table);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		model.addAttribute("columnTypes", ClassKit.getFields(TypeMap.class));
		return TPL + "alter";
	}
	
	@RequestMapping(value="/alter/do", method={RequestMethod.POST})
	@ResponseBody
	public JSONObject doAlter(Table table, String columns){
		try{
			Platform platform = PlatformFactory.createNewPlatformInstance(multiDataSource);
			try {
				Connection conn = platform.getDataSource().getConnection();
				String catalog = conn.getCatalog();
				Database db = platform.readModelFromDatabase(catalog);
				Table eqTable = db.findTable(table.getName());
				if(ObjectKit.isNotNull(eqTable)){
					eqTable.setName(table.getName());
					eqTable.setDescription(table.getDescription());
					
					JSONArray jColumns = JSONArray.fromObject("["+columns+"]");
					for(int i=0;i<jColumns.size();i++){
						JSONObject jColumn = JSONObject.fromObject(jColumns.get(i));
						boolean isNew = false;
						if(i+1 > eqTable.getColumnCount())
							isNew = true;
						Column column = new Column();
						if(!isNew)
							column = eqTable.getColumn(i);
						column.setName(jColumn.getString("name"));
						column.setType(jColumn.getString("type"));
						if(!StringKit.isEmpty(jColumn.getString("size")))
							column.setSize(jColumn.getString("size"));
						column.setPrimaryKey(jColumn.getBoolean("pk"));
						if(!column.isPrimaryKey())
							column.setDefaultValue(jColumn.getString("def"));
						column.setRequired(jColumn.getBoolean("notNull"));
						column.setAutoIncrement(jColumn.getBoolean("autoIncr"));
						column.setDescription(jColumn.getString("comment"));
						
						if(isNew)
							eqTable.addColumn(column);
					}
					for(int i=jColumns.size();i<eqTable.getColumnCount();i++){
						eqTable.removeColumn(i);
					}
					platform.alterTables(db, false);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return WebResult.success();
		}catch(Exception e){
			logger.error(e.toString());
			return WebResult.error(e);
		}
	}
	
	@RequestMapping(value="/fk/{name}", method={RequestMethod.GET, RequestMethod.POST})
	public String forgetKey(Model model, @PathVariable String name){
		Platform platform = PlatformFactory.createNewPlatformInstance(multiDataSource);
		try {
			Connection conn = platform.getDataSource().getConnection();
			String catalog = conn.getCatalog();
			Database db = platform.readModelFromDatabase(catalog);
			Table table = db.findTable(name);
			model.addAttribute("table", table);
			model.addAttribute("tables", db.getTables());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return TPL + "fk";
	}
	
	@RequestMapping(value="/fk/{name}/columns", method={RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public JSONArray columns(@PathVariable String name){
		JSONArray array = new JSONArray();
		Platform platform = PlatformFactory.createNewPlatformInstance(multiDataSource);
		try{
			Connection conn = platform.getDataSource().getConnection();
			String catalog = conn.getCatalog();
			Database db = platform.readModelFromDatabase(catalog);
			Table table = db.findTable(name);
			
			for(Column col : table.getColumns()){
				JSONObject obj = new JSONObject();
				obj.element("name", col.getName());
				
				array.add(obj);
			}
			return array;
		}catch(Exception e){
			logger.error(e.toString());
			return array;
		}
	}
	
}
