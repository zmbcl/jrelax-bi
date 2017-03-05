package com.jrelax.web.bi.controller.flow;

import com.jrelax.core.web.transform.DataGridTransforms;
import com.jrelax.orm.query.PageBean;
import net.sf.json.JSONObject;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.DeploymentQuery;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.task.Event;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jrelax.core.web.support.WebResult;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 流程申请
 */
@Controller
@RequestMapping("/bi/flow/apply")
public class BiFlowApplyController {
private final String TPL = "bi/flow/apply/";
	
	@Autowired
	private RepositoryService repositoryService;
	@Autowired
	private RuntimeService runtimeService;
	@Autowired
	private ProcessEngine processEngine;
	
	/**
	 * 已部署流程列表
	 * @param model
	 * @return
	 */
	@RequestMapping(method={RequestMethod.GET, RequestMethod.POST})
	public String list(Model model){
		return TPL + "index";
	}

	/**
	 * 获取已部署流程数据
	 * @param pageBean
	 * @return
	 */
	@RequestMapping("/data")
	@ResponseBody
	public Map<String, Object> data(PageBean pageBean){
		ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery();
		pageBean.setTotalCount((int) query.count());
		List<JSONObject> jsonList = new ArrayList<>();

		List<ProcessDefinition> list = query.listPage((pageBean.getPage() - 1) * pageBean.getRows(), pageBean.getRows());

		list.forEach(processDefinition -> {
			JSONObject json = new JSONObject();
			json.element("id", processDefinition.getId());
			json.element("name", processDefinition.getName());
			json.element("key", processDefinition.getKey());
			json.element("descript", processDefinition.getDescription());

			jsonList.add(json);
		});

		return DataGridTransforms.JQGRID.transform(jsonList, pageBean);
	}
	
	/**
	 * 启动流程
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/start/{id}")
	@ResponseBody
	public JSONObject start(@PathVariable String id){
		try {
			JSONObject result = WebResult.success();
			ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(id).singleResult();
			if(processDefinition.hasStartFormKey()){
				result.element("type", "form");
				result.element("formKey", processEngine.getFormService().getStartFormKey(id));
			}else{
				runtimeService.startProcessInstanceById(id);
			}
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return WebResult.error(e);
		}
	}
}
