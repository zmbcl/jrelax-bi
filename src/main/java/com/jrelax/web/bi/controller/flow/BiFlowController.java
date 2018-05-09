package com.jrelax.web.bi.controller.flow;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.jrelax.core.web.support.WebResult;
import com.jrelax.core.web.transform.DataGridTransforms;
import com.jrelax.kit.StringKit;
import com.jrelax.orm.query.PageBean;
import com.jrelax.web.bi.entity.BIFlow;
import com.jrelax.web.bi.service.BIFlowService;
import com.jrelax.web.bi.service.BIFormService;
import com.jrelax.web.support.BaseController;
import com.jrelax.web.system.service.UnitService;
import net.sf.json.JSONObject;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.DeploymentBuilder;
import org.activiti.engine.repository.ModelQuery;
import org.activiti.engine.repository.ProcessDefinition;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/bi/flow")
public class BiFlowController extends BaseController<BIFlow> {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    private final String TPL = "bi/flow/";

    @Autowired
    private ProcessEngine processEngine;
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private BIFlowService wflowService;
    @Autowired
    private BIFormService wformService;
    @Autowired
    private UnitService unitService;

    /**
     * 首页
     *
     * @return
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST})
    public String index(Model model) {
        return TPL + "index";
    }

    @RequestMapping("/data")
    @ResponseBody
    public Map<String, Object> data(PageBean pageBean) {
        ModelQuery query = repositoryService.createModelQuery();
        List<org.activiti.engine.repository.Model> modelList = query.listPage((pageBean.getPage() - 1) * pageBean.getRows(), pageBean.getRows());
        pageBean.setTotalCount((int) query.count());
        return DataGridTransforms.JQGRID.transform(modelList, pageBean);
    }

    @RequestMapping(value = "/add", method = {RequestMethod.GET, RequestMethod.POST})
    public String add(Model model) {
        return TPL + "add";
    }

    /**
     * 添加流程到Activiti中
     *
     * @param name     名称
     * @param key      代号
     * @param descript 流程描述
     * @return
     */
    @RequestMapping(value = "/add/do")
    @ResponseBody
    public JSONObject doAdd(String name, String key, String descript) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            org.activiti.engine.repository.Model modelData = repositoryService.newModel();

            ObjectNode modelObjectNode = objectMapper.createObjectNode();
            modelObjectNode.put(ModelDataJsonConstants.MODEL_ID, key);
            modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, name);
            modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, 1);
            modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, StringKit.null2String(descript));
            modelData.setMetaInfo(modelObjectNode.toString());
            modelData.setName(name);
            modelData.setKey(StringKit.null2String(key));
            modelData.setCategory("");

            repositoryService.saveModel(modelData);

            ObjectNode editorNode = objectMapper.createObjectNode();
            editorNode.put("resourceId", modelData.getId());
            //设置参数
            ObjectNode prop = objectMapper.createObjectNode();
            prop.put("process_id", key);
            prop.put("name", name);
            prop.put("documentation", descript);
            prop.put("process_namespace", "");
            prop.put("process_author", getCurrentUser().getUserName());
            prop.put("process_version", 1);
            editorNode.set("properties", prop);
            //设置stencil
            ObjectNode stencil = objectMapper.createObjectNode();
            stencil.put("id", "BPMNDiagram");
            editorNode.set("stencil", stencil);
            //设置stencilset
            ObjectNode stencilSetNode = objectMapper.createObjectNode();
            stencilSetNode.put("url", "stencilsets/bpmn2.0/bpmn2.0.json");
            stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
            editorNode.set("stencilset", stencilSetNode);
            repositoryService.addModelEditorSource(modelData.getId(), editorNode.toString().getBytes("utf-8"));

            return WebResult.success().element("id", modelData.getId());
        } catch (Exception e) {
            logger.error("创建模型失败：", e);
            return WebResult.error(e);
        }
    }

    /**
     * 设计新流程
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/design", method = {RequestMethod.GET, RequestMethod.POST})
    @Deprecated
    public String design(Model model) {
//		//用户列表
//		List<User> userList = unitService.listUser();
//		//用户组列表
//		List<Role> roleList = unitService.listRole();
//		//表单列表
//		List<BIForm> formList = wformService.listToEntity("select id,name from BIForm order by createTime desc");
//
//		model.addAttribute("userList", userList);
//		model.addAttribute("roleList", roleList);
//		model.addAttribute("formList", formList);

        return TPL + "design";
    }

    @RequestMapping(value = "/modeler", method = {RequestMethod.GET, RequestMethod.POST})
    @Deprecated
    public String modeler(Model model, String modelId) {
        return TPL + "modeler";
    }

    /**
     * 部署流程
     *
     * @return
     */
    @RequestMapping(value = "/deploy")
    @ResponseBody
    public JSONObject deploy(HttpServletRequest request, String id) {
        try {
            org.activiti.engine.repository.Model model = repositoryService.getModel(id);
            ObjectNode modelNode = (ObjectNode) new ObjectMapper().readTree(repositoryService.getModelEditorSource(id));
            BpmnModel bpmnModel = new BpmnJsonConverter().convertToBpmnModel(modelNode);
            String processName = model.getName() + ".bpmn20.xml";

            DeploymentBuilder builder = repositoryService.createDeployment();
            builder.name(model.getName());
            builder.addBpmnModel(processName, bpmnModel);
            builder.category(model.getCategory());
            Deployment deployment = builder.deploy();

            model.setDeploymentId(deployment.getId());
            repositoryService.saveModel(model);


        } catch (Exception e) {
            e.printStackTrace();
            return WebResult.error(e);
        }
        return WebResult.success();
    }

    /**
     * 取消部署流程
     *
     * @return
     */
    @RequestMapping(value = "/undeploy")
    @ResponseBody
    public JSONObject unDeploy(String id) {
        try {
            repositoryService.deleteDeployment(id, true);//级联删除，删除所有信息，包括历史
        } catch (Exception e) {
            e.printStackTrace();
            return WebResult.error(e);
        }
        return WebResult.success();
    }

    /**
     * 删除流程定义
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public JSONObject delete(String id) {
        try {
            repositoryService.deleteModel(id);
        } catch (Exception e) {
            e.printStackTrace();
            return WebResult.error(e);
        }
        return WebResult.success();
    }


    @RequestMapping(value = "/image")
    public void image(HttpServletRequest request, HttpServletResponse response) {
        //获取图片
        RepositoryService rs = processEngine.getRepositoryService();
        ProcessDefinition processDefinition = rs.createProcessDefinitionQuery().processDefinitionKey("myProcess").singleResult();

        InputStream is = rs.getProcessDiagram(processDefinition.getId());

        try {
            OutputStream out = response.getOutputStream();
            byte[] data = new byte[1024];
            while (is.read(data) != -1) {
                out.write(data);
            }
            is.close();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
