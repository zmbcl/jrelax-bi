package com.jrelax.web.bi.controller.flow;

import net.sf.json.JSONObject;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jrelax.core.web.support.WebResult;

@Controller
@RequestMapping("/bi/flow/apply")
public class BiFlowApplyController {
private final String TPL = "bi/flow/apply/";
	
	@Autowired
	private RepositoryService repositoryService;
	@Autowired
	private RuntimeService runtimeService;
	
	/**
	 * 已部署流程列表
	 * @param model
	 * @return
	 */
	@RequestMapping(method={RequestMethod.GET, RequestMethod.POST})
	public String list(Model model){
		model.addAttribute("list", repositoryService.createProcessDefinitionQuery().list());
		return TPL + "index";
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
			runtimeService.startProcessInstanceById(id);
			
			return WebResult.success();
		} catch (Exception e) {
			e.printStackTrace();
			return WebResult.error(e);
		}
	}
}
