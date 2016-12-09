package com.jrelax.web.controller.bi.flow;

import java.util.List;

import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jrelax.kit.StringKit;
import com.jrelax.web.controller.BaseController;

@Controller
@RequestMapping("/bi/flow/task")
public class BiFlowTaskController extends BaseController<Object>{
	private final String TPL = "bi/flow/task/";
	
	@Autowired
	private TaskService taskService;
	
	/**
	 * 任务列表
	 * @param model
	 * @return
	 */
	@RequestMapping(method={RequestMethod.GET, RequestMethod.POST})
	public String tasklist(Model model){
		List<Task> tasks = taskService.createTaskQuery().taskCandidateOrAssigned(getCurrentUser().getId()).list();//taskService.createTaskQuery().taskCandidateOrAssigned(id2).list();
		model.addAttribute("list", tasks);
		
		return TPL + "index";
	}
	
	/**
	 * 完成任务
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/complete/{id}")
	public String completeTask(@PathVariable String id){
		Task task = taskService.createTaskQuery().taskId(id).singleResult();
		if(!StringKit.isEmpty(task.getFormKey())){
			return "redirect:/flow/form/test/"+task.getFormKey()+"?tid="+task.getId();
		}else{
			taskService.complete(id);
		}
		return "redirect:/flow/task";
	}
}
