package com.jrelax.web.controller.bi.flow;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jrelax.kit.ObjectKit;
import net.sf.json.JSONObject;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.apache.commons.io.FileUtils;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jrelax.core.web.support.WebResult;
import com.jrelax.orm.query.PageBean;
import com.jrelax.web.controller.BaseController;
import com.jrelax.web.entity.bi.BIFlow;
import com.jrelax.web.entity.bi.BIForm;
import com.jrelax.web.entity.system.Role;
import com.jrelax.web.entity.system.User;
import com.jrelax.web.service.bi.BIFlowService;
import com.jrelax.web.service.bi.BIFormService;
import com.jrelax.web.service.system.UnitService;

@Controller
@RequestMapping("/bi/flow")
public class BiFlowController extends BaseController<BIFlow>{
	private final String TPL = "bi/flow/flow/";
	
	@Autowired
	private ProcessEngine processEngine;
	@Autowired
	private BIFlowService wflowService;
	@Autowired
	private BIFormService wformService;
	@Autowired
	private UnitService unitService;
	/**
	 * 首页
	 * @return
	 */
	@RequestMapping(method={RequestMethod.GET, RequestMethod.POST})
	public String index(Model model, PageBean pageBean){
		pageBean.addOrder(Order.desc("createTime"));
		List<BIFlow> list = wflowService.list(pageBean);
		model.addAttribute("list", list);
		return TPL + "index";
	}
	
	/**
	 * 设计新流程
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/design", method={RequestMethod.GET, RequestMethod.POST})
	public String design(Model model){
		//用户列表
		List<User> userList = unitService.listUser();
		//用户组列表
		List<Role> roleList = unitService.listRole();
		//表单列表
		List<BIForm> formList = wformService.listToEntity("select id,name from BIForm order by createTime desc");
		
		model.addAttribute("userList", userList);
		model.addAttribute("roleList", roleList);
		model.addAttribute("formList", formList);
		
		return TPL + "design";
	}
	
	/**
	 * 部署流程
	 * @return
	 */
	@RequestMapping(value="/deploy")
	@ResponseBody
	public JSONObject deploy(HttpServletRequest request, String id){
		try {
			BIFlow flow = wflowService.get("select id,content,name from BIForm where id='"+id+"'");
			if(ObjectKit.isNull(flow))
				return WebResult.error("流程不存在！");
			//创建临时文件
			String tempDir = request.getServletContext().getRealPath("/");
			File file = new File(tempDir+"/resources/temp");
			if(!file.exists())
				file.mkdirs();
			file = new File(file.getPath()+"/"+flow.getName()+".bpmn");
			FileUtils.writeStringToFile(file, flow.getContent(), "UTF-8");
			InputStream is = FileUtils.openInputStream(file);
			RepositoryService rs = processEngine.getRepositoryService();
			//String deployId = rs.createDeployment().addClasspathResource("请假流程.bpmn").deploy().getId();
			//部署流程
			String deployId = rs.createDeployment().addInputStream(file.getName(), is).deploy().getId();
			is.close();
			file.delete();//删除文件
			//更新流程为已部署
			wflowService.executeSqlBatch("update WFlow set deployId='"+deployId+"' where id='"+id+"'");//更新流程状态为未部署
			//System.out.println("当前流程定义数量："+rs.createProcessDefinitionQuery().count());
		} catch (Exception e) {
			e.printStackTrace();
			return WebResult.error(e);
		}
		return WebResult.success();
	}
	
	/**
	 * 取消部署流程
	 * @return
	 */
	@RequestMapping(value="/undeploy")
	@ResponseBody
	public JSONObject unDeploy(String id){
		try {
			BIFlow flow = wflowService.get("select id,deployId from BIForm where id='"+id+"'");
			if(ObjectKit.isNull(flow))
				return WebResult.error("流程不存在！");
			RepositoryService rs = processEngine.getRepositoryService();
			rs.deleteDeployment(flow.getDeployId(), true);//级联删除，删除所有信息，包括历史
			wflowService.executeSqlBatch("update BIForm set deployId=null where id='"+id+"'");//更新流程状态为未部署
		} catch (Exception e) {
			e.printStackTrace();
			return WebResult.error(e);
		}
		return WebResult.success();
	}
	
	
	@RequestMapping(value="/image")
	public void image(HttpServletRequest request, HttpServletResponse response){
		//获取图片
		RepositoryService rs = processEngine.getRepositoryService();
		ProcessDefinition processDefinition = rs.createProcessDefinitionQuery().processDefinitionKey("myProcess").singleResult();
		
		InputStream is = rs.getProcessDiagram(processDefinition.getId());
		
		try {
			OutputStream out = response.getOutputStream();
			byte[] data = new byte[1024];
			while(is.read(data)!=-1){
				out.write(data);
			}
			is.close();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
