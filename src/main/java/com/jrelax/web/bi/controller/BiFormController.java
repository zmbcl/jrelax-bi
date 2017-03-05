package com.jrelax.web.bi.controller;

import com.jrelax.third.form.FormRuntime;
import com.jrelax.core.support.ApplicationCommon;
import com.jrelax.core.web.support.WebResult;
import com.jrelax.core.web.transform.DataGridTransforms;
import com.jrelax.kit.DateKit;
import com.jrelax.kit.ObjectKit;
import com.jrelax.kit.StringKit;
import com.jrelax.orm.query.PageBean;
import com.jrelax.web.bi.entity.BIForm;
import com.jrelax.web.bi.service.BIFormService;
import com.jrelax.web.support.BaseController;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * 开发 - UI表单设计器1.0
 *
 * @author zengchao
 */
@Controller
@RequestMapping("/bi/form")
public class BiFormController extends BaseController<BIForm> {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    private final String TPL = "bi/form/";
    private static String DBNAME = ""; //当前数据库名称

    @Autowired
    private BIFormService wFormService;
    @Autowired
    private TaskService taskService;

    /**
     * 显示列表
     *
     * @param model
     * @param pageBean
     * @return
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST})
    public String index(Model model, PageBean pageBean) {
        return TPL + "index";
    }

    @RequestMapping("/data")
    @ResponseBody
    public Map<String, Object> data(PageBean pageBean) {
        pageBean.addCriterion(Restrictions.eq("version", "1.0"));
        List<BIForm> list = wFormService.list(pageBean);

        return DataGridTransforms.JQGRID.transform(list, pageBean);
    }

    /**
     * 删除表单
     * 删除表单的同时，删除对应的数据库表
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/delete/{id}", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject delete(@PathVariable String id) {
        try {
            BIForm form = wFormService.getById(id);
            if (ObjectKit.isNotNull(form)) {
                String table = form.getTableName();
                wFormService.delete(form);

                //需要删除表
                if (!StringKit.isEmpty(table)) {
                    String sql = "drop table if exists " + table;
                    wFormService.executeSqlBatch(sql);
                }
            }
            return WebResult.success();
        } catch (Exception e) {
            logger.error(e.toString());
            return WebResult.error(e);
        }
    }

    /**
     * 表单设计 1.0
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/design", method = {RequestMethod.GET, RequestMethod.POST})
    public String design(Model model) {
        return TPL + "design";
    }

    /**
     * 表单编辑
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/design/edit/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public String edit(Model model, @PathVariable String id) {
        BIForm form = wFormService.getById(id);
        if (ObjectKit.isNull(form))//如果表单已不存在，则调整到新建页面
            return "redirect:/bi/form/v2/design";
        model.addAttribute("form", form);
        return TPL + "design";
    }

    /**
     * 预览数据库中的表单
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "/design/preview/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public String preview_id(Model model, @PathVariable String id, String tid, String start) {
        BIForm form = null;
        if (!StringKit.isEmpty(id)) {
            form = wFormService.getById(id);

            FormRuntime formRuntime = new FormRuntime(form.getContent());
            formRuntime.addParam("tid", tid)
                    .addParam("start", start != null)
                    .addParam("formAction", ApplicationCommon.BASEPATH + "/bi/form/submit")
                    .addParam("formId", form.getId());

            if (StringKit.isNotEmpty(tid)) {
                //合并流程变量
                Task task = taskService.createTaskQuery().taskId(tid).singleResult();
                if (ObjectKit.isNotNull(task)) {
                    formRuntime.setVariableMap(taskService.getVariables(task.getId()));
                }
            }

            model.addAttribute("html", formRuntime.html());
            model.addAttribute("form", form);
        }
        return TPL + "preview";
    }

    @RequestMapping(value = "/design/data", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject data() {
        try {
            JSONArray array = new JSONArray();
            for (int i = 0; i < 5; i++) {
                JSONObject obj = new JSONObject();
                obj.element("value", i);
                obj.element("text", "远程选项" + i);

                array.add(obj);
            }
            return WebResult.success().element("data", array);
        } catch (Exception e) {
            return WebResult.error(e);
        }
    }

    @RequestMapping(value = "/design/save", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject save(String name, String html, String id) {
        try {
            if (StringKit.isEmpty(name) && StringKit.isEmpty(id)) {
                return WebResult.error("表单信息不完整，无法保存！");
            }
            BIForm form = new BIForm();
            if (!StringKit.isEmpty(id)) {//id不为空则更新
                form = wFormService.getById(id);
                if (ObjectKit.isNull(form))
                    return WebResult.error("表单不存在，请检查是否已被删除！");
            } else {
                form.setName(name);
                form.setVersion("1.0");
            }
            form.setSource(html);
            form.setContent(wFormService.parseHTML(html));
            form.setCreateTime(DateKit.now());
            form.setCreateUser(getCurrentUser().getRealName());

            return wFormService.saveForm(form);
        } catch (Exception e) {
            logger.error(e.toString());
            e.printStackTrace();
            return WebResult.error(e);
        }
    }


    /**
     * 表单提交
     *
     * @return
     */
    @RequestMapping(value = "/submit", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject submit(String data) {
        try {
            JSONObject jData = JSONObject.fromObject(data);
            return wFormService.executeSubmit(jData);
        } catch (Exception e) {
            logger.error(e.toString(), e);
            return WebResult.error(e);
        }
    }

    /**
     * 表单数据展示
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "/datalist/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public String datalist(Model model, @PathVariable String id) {
        BIForm form = wFormService.getById(id);
        if (ObjectKit.isNull(form)) {
            model.addAttribute("msg", "表单不存在");
        } else {
            Map<String, List<Object>> map = new LinkedHashMap<>();
            String[] _tables = form.getTableName().split(",");
            List<String> tables = new ArrayList<>();
            Collections.addAll(tables, _tables);

            for (String tableName : tables) {
                List<Object> tableInfoList = new ArrayList<>();
                //#1字段信息
                List<List<String>> columns = wFormService.getColumns(null, "'" + tableName + "'");
                List<String> dbColumns = new ArrayList<>();
                List<String> displayColumns = new ArrayList<>();
                for (List<String> list : columns) {
                    dbColumns.add(list.get(0));
                    displayColumns.add(list.get(1));
                }
                tableInfoList.add(displayColumns);
                //#2数据
                String sql = "select " + StringKit.toString(dbColumns) + " from " + tableName + " limit 0,50";
                List<?> _data = wFormService.nativeListToArray(sql);
                List<List<Object>> data = new ArrayList<>();
                for (Object obj : _data) {
                    Object[] values = (Object[]) obj;
                    data.add(Arrays.asList(values));
                }
                tableInfoList.add(data);
                //#3表备注
                List<?> tableInfos = wFormService.nativeListToArray("SELECT table_name, TABLE_COMMENT FROM information_schema.TABLES WHERE table_name='" + tableName + "'");
                if (tableInfos.size() > 0) {
                    Object[] tableInfo = (Object[]) tableInfos.get(0);
                    if (ObjectKit.isNotNull(tableInfo[1]) && !StringKit.isEmpty(tableInfo[1] + ""))
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
        return TPL + "datalist";
    }
}
