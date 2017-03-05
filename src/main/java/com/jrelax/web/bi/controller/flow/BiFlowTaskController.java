package com.jrelax.web.bi.controller.flow;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.jrelax.core.web.transform.DataGridTransforms;
import com.jrelax.kit.DateKit;
import com.jrelax.orm.query.PageBean;
import net.sf.json.JSONObject;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jrelax.kit.StringKit;
import com.jrelax.web.support.BaseController;
import org.springframework.web.bind.annotation.ResponseBody;

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
		return TPL + "index";
	}

	/**
	 * 任务列表数据
	 * @param pageBean
	 * @return
	 */
	@RequestMapping("/data")
	@ResponseBody
	public Map<String, Object> data(PageBean pageBean){
//		List<Task> tasks = taskService.createTaskQuery().taskCandidateOrAssigned(getCurrentUser().getId()).list();//taskService.createTaskQuery().taskCandidateOrAssigned(id2).list();
//		model.addAttribute("list", tasks);

		String user = getParameter("user").stringValue();
		if(user == null) user = getCurrentUser().getId();
		TaskQuery query = taskService.createTaskQuery().taskAssignee(user);
		List<Task> taskList = query.listPage(pageBean.getStart(), pageBean.getRows());
		List<JSONObject> jsonList = new ArrayList<>();
		taskList.forEach(task -> {
			JSONObject json = new JSONObject();
			json.element("id", task.getId());
			json.element("formKey", task.getFormKey());
			json.element("name", task.getName());
			json.element("createTime", DateKit.format(task.getCreateTime(), DateKit.YYYY_MM_DD_HH_MM_SS));

			jsonList.add(json);
		});

		System.out.println(jsonList.size());
		return DataGridTransforms.JQGRID.transform(jsonList, pageBean);
	}
	
	/**
	 * 完成任务
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/complete/{id}")
	@ResponseBody
	public JSONObject completeTask(@PathVariable String id){
		JSONObject result = new JSONObject();
		Task task = taskService.createTaskQuery().taskId(id).singleResult();
		if(!StringKit.isEmpty(task.getFormKey())){
			result.element("type", "form");
			result.element("formKey", task.getFormKey());
			result.element("taskId", task.getId());
		}else{
			taskService.complete(id);
			result.element("type", "complete");
			result.element("message", "任务处理成功");
		}
		return result;
	}
}
