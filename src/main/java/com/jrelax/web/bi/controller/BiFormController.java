package com.jrelax.web.bi.controller;

import com.jrelax.core.support.ApplicationCommon;
import com.jrelax.core.web.support.WebResult;
import com.jrelax.kit.DateKit;
import com.jrelax.kit.ObjectKit;
import com.jrelax.kit.StringKit;
import com.jrelax.kit.UUIDKit;
import com.jrelax.orm.query.PageBean;
import com.jrelax.web.bi.entity.BIForm;
import com.jrelax.web.bi.service.BIFormService;
import com.jrelax.web.support.BaseController;
import net.sf.json.JSONObject;
import org.activiti.engine.FormService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.form.TaskFormData;
import org.activiti.engine.task.Task;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * 开发 - UI表单设计器1.0
 * @author zengchao
 *
 */
@Controller
@RequestMapping("/bi/form")
public class BiFormController extends BaseController<BIForm>{
	private Logger logger = LoggerFactory.getLogger(this.getClass());
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

	@RequestMapping(method={RequestMethod.GET, RequestMethod.POST})
	public String index(Model model, PageBean pageBean){
		pageBean.addOrder(Order.desc("createTime"));
		pageBean.addCriterion(Restrictions.eq("version", "1.0"));
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
	@RequestMapping(value="/design/edit/{id}", method={RequestMethod.GET, RequestMethod.POST})
	public String design(Model model, @PathVariable String id){
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
				wFormService.delete(form);
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
	@RequestMapping(value="/preview/{id}", method={RequestMethod.GET, RequestMethod.POST})
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
		return TPL + "preview";
	}
	
	/**
	 * 测试提交
	 * @param request
	 * @param _formId
	 * @param _tid
	 * @return
	 */
	@RequestMapping(value="/preview/submit", method={RequestMethod.POST})
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
		content = content.replaceAll("#dt_week#", DateKit.getWeek(DateKit.nowOfDate()));
		
		return content;
	}
	
	//合并流程变量
	private String parseFormForTaskVaiables(String content, Map<String, Object> processVariables) {
		for(String key : processVariables.keySet()){
			content = content.replaceAll("#var_"+key+"#", processVariables.get(key)+"");
		}
		return content;
	}
}
