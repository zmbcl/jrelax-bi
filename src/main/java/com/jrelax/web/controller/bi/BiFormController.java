package com.jrelax.web.controller.bi;

import com.jrelax.core.support.ApplicationCommon;
import com.jrelax.kit.DateKit;
import com.jrelax.kit.ObjectKit;
import com.jrelax.kit.StringKit;
import com.jrelax.kit.UUIDKit;
import com.jrelax.core.web.support.WebResult;
import com.jrelax.orm.query.PageBean;
import com.jrelax.web.controller.BaseController;
import com.jrelax.web.entity.bi.BIForm;
import com.jrelax.web.service.bi.BIFormService;
import com.jrelax.web.service.bi.BiDatasourceService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.activiti.engine.FormService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.form.TaskFormData;
import org.activiti.engine.task.Task;
import org.apache.ddlutils.Platform;
import org.apache.ddlutils.PlatformFactory;
import org.apache.log4j.Logger;
import org.hibernate.criterion.Order;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

/**
 * 开发 - UI表单设计器
 * @author zengchao
 *
 */
@Controller
@RequestMapping("/bi/form")
public class BiFormController extends BaseController<BIForm>{
	private Logger logger = Logger.getLogger(this.getClass());
	private final String TPL = "bi/form/";
	private final String TABLE_EXT = "_ext";
	private final String TABLE_EXT_VAL = "_ext_val";
	private static String DBNAME = ""; //当前数据库名称
	
	@Autowired
	private BIFormService wFormService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private FormService formService;
	@Autowired
	private BiDatasourceService biDatasourceService;
	@Autowired
	private DataSource multiDataSource;

	@RequestMapping(method={RequestMethod.GET, RequestMethod.POST})
	public String index(Model model, PageBean pageBean){
		pageBean.addOrder(Order.desc("createTime"));
		List<BIForm> list = wFormService.list(pageBean);
		
		model.addAttribute("list", list);
		return TPL + "index";
	}
	
	/**
	 * 表单设计
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/design",method={RequestMethod.GET, RequestMethod.POST})
	public String design(Model model){
		return TPL + "design";
	}
	
	/**
	 * 表单编辑
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit/{id}", method={RequestMethod.GET, RequestMethod.POST})
	public String edit(Model model, @PathVariable String id){
		BIForm form = wFormService.getById(id);
		model.addAttribute("form", form);
		return TPL + "design";
	}
	
	/**
	 * 删除表单
	 * 删除表单的同时，删除对应的数据库表
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/delete/{id}", method={RequestMethod.POST})
	@ResponseBody
	public JSONObject delete(@PathVariable String id){
		try{
			BIForm form = wFormService.getById(id);
			if(ObjectKit.isNotNull(form)){
				String table = form.getTableName();
				wFormService.delete(form);
				
				//2.0 版本需要删除表
				if(!form.getVersion().equals("2.0") && !StringKit.isEmpty(table)){
					String sql = "drop table if exists "+table;
					wFormService.executeSqlBatch(sql);
				}
			}
			return WebResult.success();
		}catch(Exception e){
			logger.error(e.toString());
			return WebResult.error(e);
		}
	}
	
	/**
	 * 保存表单
	 * @param html
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/save", method={RequestMethod.POST})
	@ResponseBody
	public JSONObject save(String html, String id){
		try {
			BIForm form = new BIForm();
			if(!StringKit.isEmpty(id)){
				form = wFormService.getById(id);
			}
			form.setVersion("1.0");
			form.setSource(html);
			form.setCreateTime(DateKit.now());
			
			return wFormService.saveForm(form);
		} catch (Exception e) {
			e.printStackTrace();
			return WebResult.error(e);
		}
	}
	/**
	 * 测试表单
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/test/{id}", method={RequestMethod.GET, RequestMethod.POST})
	public String test(Model model, @PathVariable String id, String tid){
		BIForm form = wFormService.getById(id);
		if(ObjectKit.isNotNull(form)){
			form.setContent(parseFormContent(form.getContent(), tid));
			if(!StringKit.isEmpty(tid)){
				model.addAttribute("tid", tid);
				//合并流程变量
				Task task = taskService.createTaskQuery().taskId(tid).singleResult();
				if(ObjectKit.isNotNull(task)){
					form.setContent(parseFormForTaskVaiables(form.getContent(),taskService.getVariables(task.getId())));
				}
			}
			model.addAttribute("content", form.getContent());
			model.addAttribute("id", form.getId());
		}
		return TPL + "test";
	}
	
	/**
	 * 测试提交
	 * @param request
	 * @param _formId
	 * @param _tid
	 * @return
	 */
	@RequestMapping(value="/test/submit", method={RequestMethod.POST})
	@ResponseBody
	public JSONObject submit(HttpServletRequest request, String _formId, String _tid){
		try {
			BIForm form = wFormService.getById(_formId);
			if(ObjectKit.isNotNull(form)){
				Task task = taskService.createTaskQuery().taskId(_tid).singleResult();
				if(ObjectKit.isNull(task)){
					return WebResult.error("任务已结束或流程不存在！");
				}
				if(!StringKit.isEmpty(form.getTableName())){
					//遍历参数，组装sql语句
					String insertSql = "insert into "+form.getTableName()+"(";
					String insertSqlValue = " values(";
					Enumeration<String> enumer = request.getParameterNames();
					while(enumer.hasMoreElements()){
						String name = enumer.nextElement();
						if("_formId".equals(name) || "_tid".equals(name))
							continue;
						insertSql += ""+name+",";
						insertSqlValue += "'"+request.getParameter(name)+"',";
					}
					UUIDKit uuid = new UUIDKit();
					insertSql += "id)"+insertSqlValue+"'"+uuid.generate()+"')";
					
					wFormService.executeSqlBatch(insertSql);
				}
				//处理流程相关
				Map<String,String> varables = new HashMap<String, String>();
				TaskFormData formData = formService.getTaskFormData(_tid);
				List<FormProperty> properties = formData.getFormProperties();
				for(FormProperty prop : properties){
					varables.put(prop.getId(), request.getParameter(prop.getId()));
				}
				if(varables.size() == 0){
					taskService.complete(_tid);
				}else{
					//提交数据，完成流程
					formService.submitTaskFormData(_tid, varables);
				}
				
			}
			return WebResult.success();
		} catch (Exception e) {
			e.printStackTrace();
			return WebResult.error(e);
		}
	}
	//处理公用参数和宏参数
	public String parseFormContent(String content,String tid){
		content = content.replace("#formAction#", ApplicationCommon.BASEPATH+"/flow/form/test/submit");
		tid= StringKit.isEmpty(tid)?"":tid;
		content = content.replace("#tid#", tid);
		content = content.replaceAll("#user_realname#", "张三");
		content = content.replaceAll("#user_unitname#", "技术部");
		content = content.replaceAll("#dt_yyyy-MM-dd HH:mm:ss#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		content = content.replaceAll("#dt_yyyy-MM-dd HH:mm#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_yyyy-MM-dd#", DateKit.format(new Date(), "yyyy-MM-dd"));
		content = content.replaceAll("#dt_yyyy年MM月dd日#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_yyyy年MM月#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_MM月dd日#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_yyyy#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_yyyy年#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_HH:mm#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_HH:mm:ss#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_week#", DateKit.getWeek());
		
		return content;
	}
	
	//合并流程变量
	private String parseFormForTaskVaiables(String content, Map<String, Object> processVariables) {
		for(String key : processVariables.keySet()){
			content = content.replaceAll("#var_"+key+"#", processVariables.get(key)+"");
		}
		return content;
	}
	
	//==========================================================2.0==================================================================//
	
	@RequestMapping(value="/design/v2/table", method={RequestMethod.GET, RequestMethod.POST})
	public String design20table(Model model){
		//获取当前数据库名称
		Platform platform = PlatformFactory.createNewPlatformInstance(multiDataSource);
		try {
			Connection conn = platform.getDataSource().getConnection();
			DBNAME = conn.getCatalog();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//获取数据库表
		String sql = "SELECT table_name, TABLE_COMMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA='"+DBNAME+"' and table_name like 'bi_%'";
		List<?> tableList = wFormService.nativeListToArray(sql);
		List<List<Object>> list = new ArrayList<>();
		for(Object obj : tableList){
			Object[] array = (Object[]) obj;
			
			list.add(Arrays.asList(array));
		}
		
		model.addAttribute("list", list);
		
		return TPL + "/v2/table";
	}
	
	/**
	 * 表单设计 2.0
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/design/v2",method={RequestMethod.GET, RequestMethod.POST})
	public String design20(Model model, @RequestParam("tables")String[] tables, String primary){
		String tableName = "";
		//获取表结构
		for(String table : tables){
			tableName += ",'"+table+"'";
		}
		if(tableName.length()>0)
			tableName = tableName.substring(1);

		//判断主表
		if(ObjectKit.isNull(primary) && tables.length == 1){
			primary = tables[0];
		}
		
		List<List<String>> columns = getColumns(tableName);
		model.addAttribute("columns", columns);
		model.addAttribute("table", tableName.replaceAll("'", ""));//删除单引号
		model.addAttribute("tables", tables);
		model.addAttribute("primary", primary);
		
		//获取数据源
		model.addAttribute("dsList", biDatasourceService.list());
		return TPL + "v2/design";
	}
	/**
	 * 表单编辑
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/design/v2/edit/{id}", method={RequestMethod.GET, RequestMethod.POST})
	public String edit20(Model model, @PathVariable String id){
		BIForm form = wFormService.getById(id);
		if(ObjectKit.isNull(form))//如果表单已不存在，则调整到新建页面
			return "redirect:/bi/form/design/v2";
		String tableName = "";
		//获取表结构
		String[] tables = form.getTableName().split(",");
		for(String table : tables){
			tableName += ",'"+table+"'";
		}
		if(tableName.length()>0)
			tableName = tableName.substring(1);
		List<List<String>> columns = getColumns(tableName);
		model.addAttribute("columns", columns);
		model.addAttribute("table", form.getTableName());
		model.addAttribute("tables", tables);
		model.addAttribute("primary", form.getPrimaryTable());
		model.addAttribute("form", form);
		//获取数据源
		model.addAttribute("dsList", biDatasourceService.list());
		return TPL + "v2/design";
	}
	/**
	 * 获取表字段
	 * @param tableName
	 * @return
	 */
	private List<List<String>> getColumns(String tableName){
		//获取表结构
		List<?> list = wFormService.nativeListToArray(String.format("SELECT table_schema,table_name,column_name,column_comment "
				+ "FROM information_schema.columns WHERE table_schema='%s' AND table_name in (%s) "
				+ "ORDER BY table_schema,table_name", DBNAME, tableName));
		
		List<List<String>> columns = new ArrayList<List<String>>();
		for(Object obj : list){
			Object[] row = (Object[]) obj;
			List<String> column = new ArrayList<>();
			column.add(row[2].toString());//1
			if(ObjectKit.isNull(row[3]) || StringKit.isEmpty(row[3].toString())){
				column.add(row[2].toString());//2
			}else{
				column.add(row[3].toString());///2
			}
			column.add(row[1].toString());//3
			columns.add(column);
		}
		return columns;
	}
	
	@RequestMapping(value="/design/v2/preview", method={RequestMethod.GET, RequestMethod.POST})
	public String preview20(Model model, String html){
		html = parseHTML20(html);
		html = parseFormContent20(html, null);
		
		model.addAttribute("html", html);
		return TPL + "v2/preview";
	}
	/**
	 * 预览数据库中的表单
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/design/v2/preview/{id}", method={RequestMethod.GET, RequestMethod.POST})
	public String preview20_id(Model model, @PathVariable String id){
		BIForm form = new BIForm();
		if(!StringKit.isEmpty(id)){
			form = wFormService.getById(id);
			model.addAttribute("html", parseFormContent20(form.getContent(), form.getId()));
			
			model.addAttribute("form", form);
		}
		return TPL + "v2/preview";
	}
	//处理公用参数和宏参数
	public String parseFormContent20(String content,String tid){
		content = content.replace("#formAction#", ApplicationCommon.BASEPATH+"/bi/form/submit20");
		tid= StringKit.isEmpty(tid)?"":tid;
		content = content.replace("#tid#", tid);
		content = content.replaceAll("#user_realname#", getCurrentUser().getRealName());
		content = content.replaceAll("#user_unitname#", getCurrentUser().getUnits().get(0).getName());
		content = content.replaceAll("#dt_yyyy-MM-dd HH:mm:ss#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm:ss"));
		content = content.replaceAll("#dt_yyyy-MM-dd HH:mm#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_yyyy-MM-dd#", DateKit.format(new Date(), "yyyy-MM-dd"));
		content = content.replaceAll("#dt_yyyy年MM月dd日#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_yyyy年MM月#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_MM月dd日#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_yyyy#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_yyyy年#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_HH:mm#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_HH:mm:ss#", DateKit.format(new Date(), "yyyy-MM-dd HH:mm"));
		content = content.replaceAll("#dt_week#", DateKit.getWeek());
		
		return content;
	}
	/**
	 * 处理表单，删除不必要的元素
	 * @param html
	 * @return
	 */
	private String parseHTML20(String html){
		//追加form在首尾处
		html = "<form action='#formAction#' method='post' onsubmit='return fd.run.submit(this)'><input type='hidden' name='$formId' value='#tid#'/>" + html;
		html = html + "</form>";
		html = html.replaceAll("field=", "name=");
		Document root = Jsoup.parse(html);
		//#1 处理script脚本
		//Element script = root.getElementById("script");
		//script.attr("type", "text/javascript");
		//script.removeAttr("id").removeAttr("class");
		//script.tagName("script");
		//#2 处理contenteditable
		Elements editable = root.getElementsByAttribute("contenteditable");
		editable.removeAttr("contenteditable");
		//#3 处理fd-move
		Elements fdmove = root.getElementsByAttribute("fd-move");
		fdmove.removeAttr("fd-move");
		//处理class
		Elements selecteds = root.getElementsByClass("fd-view-selected");
		selecteds.removeClass("fd-view-selected");
		Elements currents = root.getElementsByClass("fd-view-current");
		currents.removeClass("fd-view-current");
		return root.body().html();
	}
	
	@RequestMapping(value="/design/v2/data", method={RequestMethod.POST})
	@ResponseBody
	public JSONObject data20(){
		try{
			JSONArray array = new JSONArray();
			for(int i=0;i<5;i++){
				JSONObject obj = new JSONObject();
				obj.element("value", i);
				obj.element("text", "远程选项"+i);
				
				array.add(obj);
			}
			return WebResult.success().element("data", array);
		}catch(Exception e){
			return WebResult.error(e);
		}
	}
	
	@RequestMapping(value="/design/v2/save", method={RequestMethod.POST})
	@ResponseBody
	public JSONObject save20(String name , String html , String id, String primaryTable, String table){
		try{
			if(StringKit.isEmpty(name) && StringKit.isEmpty(id)){
				return WebResult.error("表单信息不完整，无法保存！");
			}
			if(StringKit.isEmpty(table)){
				return WebResult.error("必须绑定数据表！");
			}
			BIForm form = new BIForm();
			if(!StringKit.isEmpty(id)){
				form = wFormService.getById(id);
				if(ObjectKit.isNull(form))
					return WebResult.error("表单已不存在，请检查是否已被删除！");
			}else{
				form.setName(name);
				form.setVersion("2.0");
				form.setTableName(table);
				form.setPrimaryTable(primaryTable);
			}
			form.setSource(html);
			form.setContent(parseHTML20(html));
			form.setCreateTime(DateKit.now());
			
			return wFormService.saveForm20(form);
		}catch(Exception e){
			logger.error(e.toString());
			e.printStackTrace();
			return WebResult.error(e);
		}
	}
	
	
	/**
	 * 表单提交
	 * @return
	 */
	@RequestMapping(value="/submit20", method={RequestMethod.POST})
	@ResponseBody
	public JSONObject submit20(String data){
		try{
			JSONObject jData = JSONObject.fromObject(data);
			return wFormService.executeSubmit20(jData);
		}catch(Exception e){
			logger.error(e.toString(), e);
			return WebResult.error(e);
		}
	}
	
	/**
	 * 表单数据展示
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/datalist20/{id}", method={RequestMethod.GET, RequestMethod.POST})
	public String datalist20(Model model, @PathVariable String id){
		BIForm form = wFormService.getById(id);
		if(ObjectKit.isNull(form)){
			model.addAttribute("msg", "表单不存在");
		}else{
			Map<String, List<Object>> map = new LinkedHashMap<>();
			String[] _tables = form.getTableName().split(",");
			List<String> tables = new ArrayList<>();
			tables.add(form.getPrimaryTable());
			//将主表放在第一位
			for(String table : _tables){
				if(!table.equals(form.getPrimaryTable()))
					tables.add(table);
			}
			for(String tableName : tables){
				List<Object> tableInfoList = new ArrayList<>();
				//#1字段信息
				List<List<String>> columns = getColumns("'"+tableName+"'");
				List<String> dbColumns = new ArrayList<>();
				List<String> displayColumns = new ArrayList<>();
				for(List<String> list : columns){
					dbColumns.add(list.get(0));
					displayColumns.add(list.get(1));
				}
				tableInfoList.add(displayColumns);
				//#2数据
				String sql = "select "+ StringKit.toString(dbColumns)+" from "+tableName+" limit 0,50";
				List<?> _data = wFormService.nativeListToArray(sql);
				List<List<Object>> data = new ArrayList<>();
				for(Object obj : _data){
					Object[] values = (Object[]) obj;
					data.add(Arrays.asList(values));
				}
				tableInfoList.add(data);
				//#3表备注
				List<?> tableInfos = wFormService.nativeListToArray("SELECT table_name, TABLE_COMMENT FROM information_schema.TABLES WHERE table_name='"+tableName+"'");
				if(tableInfos.size()>0){
					Object[] tableInfo = (Object[]) tableInfos.get(0);
					if(ObjectKit.isNotNull(tableInfo[1]) && !StringKit.isEmpty(tableInfo[1]+""))
						tableInfoList.add(tableInfo[1]);
					else
						tableInfoList.add(tableName);
				}
				
				map.put(tableName, tableInfoList);
			}
			model.addAttribute("form", form);
			//model.addAttribute("displayColumns", displayColumns);
			//model.addAttribute("data", data);
			model.addAttribute("map", map);
		}
		return TPL + "v2/datalist";
	}
	
	/**
	 * 动态显示数据源数据
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/ds/{id}", method={RequestMethod.GET, RequestMethod.POST})
	public String ds(Model model, @PathVariable String id, PageBean pageBean){
//		//获取数据源
//		BiDatasource ds = biDatasourceService.getById(id);
//		String sql = ds.getSqlCmd();
//		//执行数据源配置的sql命令
//		List<?> list = biDatasourceService.queryForList(sql);
//		//查询数据
//		List<BiDatasourceCols> cols = biDatasourceColsService.list(Restrictions.eq("biDatasource", ds));
//		Map<String, String> colsMap = new LinkedHashMap<>();
//		for(BiDatasourceCols col : cols){
//			colsMap.put(col.getCode(), col.getDisplay());
//		}
//		model.addAttribute("colsMap", colsMap);
//		model.addAttribute("list", list);
//		model.addAttribute("ds", ds);
		return TPL + "v2/datasource";
	}
	
	/**
	 * 添加数据字段
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/column/{id}", method={RequestMethod.GET, RequestMethod.POST})
	public String column(Model model, @PathVariable String id){
		BIForm form = wFormService.getById(id);
		if(ObjectKit.isNotNull(form)){
			String sql_exisisTable = String.format("SELECT table_name, TABLE_COMMENT FROM information_schema.TABLES WHERE table_name='%s'", form.getPrimaryTable()+TABLE_EXT);
			String sql_createExtTable = "CREATE TABLE `"+form.getPrimaryTable()+TABLE_EXT+"`(`id` INT NOT NULL AUTO_INCREMENT ,`columnType` VARCHAR(100) NOT NULL COMMENT '字段类型',`columnName` VARCHAR(100) NOT NULL COMMENT '扩展字段',`comments` VARCHAR(500) COMMENT '字段描述',PRIMARY KEY (`id`))";
			String sql_createExtValTable = "CREATE TABLE `"+form.getPrimaryTable()+TABLE_EXT_VAL+"`(`id` INT NOT NULL AUTO_INCREMENT ,`pid` INT NOT NULL COMMENT '主表数据ID',`columnName` VARCHAR(100) NOT NULL COMMENT '扩展字段',`columnVal` VARCHAR(1000) COMMENT '扩展字段值',PRIMARY KEY (`id`)  )";
			
			//wFormService.listByNativeSqlForList(sql_exisisTable);
			if(wFormService.nativeList(sql_exisisTable).size() == 0){
				wFormService.executeSqlBatch(sql_createExtTable);
				wFormService.executeSqlBatch(sql_createExtValTable);
				
				logger.info("创建扩展表");
			}
			List<?> columns = wFormService.nativeList("select id, columnName, columnType, comments from "+form.getPrimaryTable()+"_ext");
			model.addAttribute("columns", columns);
			model.addAttribute("id", id);
		}
		return TPL + "v2/column";
	}
	
	/**
	 *  保存
	 * @return
	 */
	@RequestMapping(value="/column/save", method={RequestMethod.POST})
	@ResponseBody
	public JSONObject column_save(String id, String data){
		try{
			BIForm form = wFormService.getById(id);
			if(ObjectKit.isNotNull(form)){
				JSONArray jData = JSONArray.fromObject(data);
				List<String> ids = new ArrayList<>();
				for(int i=0;i<jData.size();i++){
					JSONObject jColumn = jData.getJSONObject(i);
					if(jColumn.containsKey("id")){//存在此字段，修改操作
						String cid = jColumn.getString("id");
						ids.add("'"+cid+"'");
					}
				}
				if(ids.size()>0)
					wFormService.executeSqlBatch("delete from "+form.getPrimaryTable()+TABLE_EXT+" where id not in ("+ StringKit.toString(ids)+")");
				for(int i=0;i<jData.size();i++){
					JSONObject jColumn = jData.getJSONObject(i);
					String columnName = jColumn.getString("columnName");
					String columnType = jColumn.getString("columnType");
					String comments = jColumn.getString("comments");
					
					if(jColumn.containsKey("id")){//存在此字段，修改操作
						String cid = jColumn.getString("id");
						ids.add("'"+cid+"'");
						wFormService.executeSqlBatch("update "+form.getPrimaryTable()+TABLE_EXT+" set columnName='"+columnName+"',columnType='"+columnType+"',comments='"+comments+"' where id='"+cid+"'");
					}else{
						wFormService.executeSqlBatch("insert into "+form.getPrimaryTable()+TABLE_EXT+"(columnName,columnType,comments) values('"+columnName+"','"+columnType+"','"+comments+"')");
					}
				}
			}else{
				return WebResult.error("表单不存在！");
			}
			return WebResult.success();
		}catch(Exception e){
			logger.error(e.toString());
			return WebResult.error(e);
		}
	}
	
	
}
