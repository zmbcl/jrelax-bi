package com.jrelax.web.bi.service;

import com.jrelax.third.form.FormBuilder;
import com.jrelax.third.form.FormTableBuilder;
import com.jrelax.core.support.ApplicationCommon;
import com.jrelax.core.web.support.WebResult;
import com.jrelax.kit.DateKit;
import com.jrelax.kit.ObjectKit;
import com.jrelax.kit.StringKit;
import com.jrelax.kit.UUIDKit;
import com.jrelax.web.bi.entity.BIForm;
import com.jrelax.web.support.BaseService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.activiti.engine.FormService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.apache.ddlutils.Platform;
import org.apache.ddlutils.PlatformFactory;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

@Service
public class BIFormService extends BaseService<BIForm> {
    @Autowired
    private TaskService taskService;
    @Autowired
    private FormService formService;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private DataSource multiDataSource;

    public JSONObject saveForm(BIForm form) {
        FormBuilder formBuilder = new FormBuilder(form.getSource());
        if (formBuilder.isEmpty())
            return WebResult.error("数据格式错误！");
        if (StringKit.isEmpty(form.getName()))
            form.setName("新建表单");
        //表单完成提示
        form.setTip(formBuilder.getFormTip());
        //解析表单内容
        String content = formBuilder.render();
        //生成数据库表
        FormTableBuilder formTableBuilder = new FormTableBuilder(this, form.getTableName());
        formTableBuilder.createTable(formBuilder.getColumnMapping());

        form.setTableName(formTableBuilder.getTableName());
        form.setContent(content);
        form.setCreateUser(getCurrentUser().getUserName());
        //保存/更新到数据库
        super.saveOrUpdate(form);
        return WebResult.success().element("id", form.getId());
    }

    /**
     * 保存表单2.0
     *
     * @param form
     * @return
     */
    public JSONObject saveForm20(BIForm form) {
        if (StringKit.isEmpty(form.getId()))
            form.setCreateUser(getCurrentUser().getUserName());
        //更新到数据库
        super.saveOrUpdate(form);
        return WebResult.success().element("id", form.getId());
    }

    /**
     * 保存表单
     *
     * @param jData
     * @return
     */
    public JSONObject executeSubmit(JSONObject jData) {
        jData = jData.getJSONObject("master");
        try {
            BIForm form = super.getById(jData.getString("_formId"));
            if (ObjectKit.isNotNull(form)) {
                //处理流程相关
                Map<String, Object> variables = new HashMap<>();
                //保存表单数据
                if (!StringKit.isEmpty(form.getTableName())) {
                    //遍历参数，组装sql语句
                    String insertSql = "insert into " + form.getTableName() + "(";
                    String insertSqlValue = " values(";
                    for (Object name : jData.keySet()) {
                        if ("_formId".equals(name) || "_tid".equals(name) || "_start".equals(name))
                            continue;
                        insertSql += "" + name + ",";
                        insertSqlValue += "'" + jData.get(name) + "',";
                        variables.put(name + "", jData.get(name));
                    }
                    UUIDKit uuid = new UUIDKit();
                    insertSql += "id)" + insertSqlValue + "'" + uuid.generate() + "')";

                    super.executeSqlBatch(insertSql);
                }
                String tid = jData.getString("_tid");
                //驱动流程
                if (StringKit.isNotEmpty(tid)) {
                    if (jData.getBoolean("_start")) {
                        runtimeService.startProcessInstanceById(tid, variables);
                    } else {
                        Task task = taskService.createTaskQuery().taskId(tid).singleResult();
                        if (ObjectKit.isNull(task)) {
                            return WebResult.error("任务已结束或流程不存在！");
                        }
                        taskService.complete(tid, variables);
                    }

                }
            }
            JSONObject result = WebResult.success();
            if (StringKit.isNotEmpty(form.getTip()))
                result.element("tip", form.getTip());
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return WebResult.error(e);
        }
    }

    /**
     * 获取当前数据库名
     *
     * @return
     */
    public String getDbName() {
        String db = null;
        //获取当前数据库名称
        Platform platform = PlatformFactory.createNewPlatformInstance(multiDataSource);
        try {
            Connection conn = platform.getDataSource().getConnection();
            db = conn.getCatalog();

            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return db;
    }

    /**
     * 获取表字段
     *
     * @param db        数据库
     * @param tableName
     * @return
     */
    public List<List<String>> getColumns(String db, String tableName) {
        if (db == null) db = getDbName();
        //获取表结构
        List<?> list = super.nativeListToArray(String.format("SELECT table_schema,table_name,column_name,column_comment "
                + "FROM information_schema.columns WHERE table_schema='%s' AND table_name in (%s) "
                + "ORDER BY table_schema,table_name", db, tableName));

        List<List<String>> columns = new ArrayList<List<String>>();
        for (Object obj : list) {
            Object[] row = (Object[]) obj;
            List<String> column = new ArrayList<>();
            column.add(row[2].toString());//1
            if (ObjectKit.isNull(row[3]) || StringKit.isEmpty(row[3].toString())) {
                column.add(row[2].toString());//2
            } else {
                column.add(row[3].toString());///2
            }
            column.add(row[1].toString());//3
            columns.add(column);
        }
        return columns;
    }

    public JSONObject executeSubmit20(JSONObject jData) {
        if (ObjectKit.isNull(jData.get("form"))) return WebResult.error("未发现任何表单项，无法提交！");
        String formId = jData.getJSONObject("form").getString("id");
        if (ObjectKit.isNotNull(formId)) {
            BIForm form = super.getById(formId);
            //先往主表中插入数据
            //#1获取主表字段，不包含.的都是主表字段
            StringBuffer sql = new StringBuffer("insert into " + form.getPrimaryTable() + "(");
            String columns = "";
            String values = "";
            JSONObject master = jData.getJSONObject("master");
            for (Object key : master.keySet()) {
                columns += "," + key;
                values += ",'" + master.get(key) + "'";
            }
            if (columns.length() > 0) columns = columns.substring(1);
            if (values.length() > 0) values = values.substring(1);
            sql.append(columns + ")values(" + values + ")");
            this.executeSqlBatch(sql.toString());
            //获取ID
            List<?> _last_id = super.nativeList("SELECT LAST_INSERT_ID()");

            //插入子表
            String last_id = _last_id.get(0).toString();
            JSONObject slave = jData.getJSONObject("slave");
            if (ObjectKit.isNotNull(slave)) {
                for (Object key : slave.keySet()) {//遍历所有从表
                    JSONArray slaveDatas = slave.getJSONArray(key.toString());
                    if (ObjectKit.isNotNull(slaveDatas)) {
                        for (int i = 0; i < slaveDatas.size(); i++) {
                            JSONObject slaveData = slaveDatas.getJSONObject(i);
                            StringBuffer childSql = new StringBuffer("insert into " + key + "(");
                            String childColumns = "fid";
                            String childValues = last_id;
                            for (Object cKey : slaveData.keySet()) {
                                childColumns += "," + cKey;
                                childValues += ",'" + slaveData.get(cKey) + "'";
                            }
                            childSql.append(childColumns + ")values(" + childValues + ")");
                            super.executeSqlBatch(childSql.toString());
                        }
                    }
                }
            }
        } else {
            return WebResult.error("表单已不存在，无法提交。");
        }
        return WebResult.success();
    }


    //处理公用参数和宏参数
    public String parseFormContent(String content, String tid, boolean start, String version) {
        if ("1.0".equals(version))
            content = content.replace("#formAction#", ApplicationCommon.BASEPATH + "/bi/form/submit");
        else if ("2.0".equals(version))
            content = content.replace("#formAction#", ApplicationCommon.BASEPATH + "/bi/form/v2/submit");

        tid = StringKit.isEmpty(tid) ? "" : tid;
        content = content.replace("#tid#", tid);
        content = content.replace("#start#", start + "");
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
        content = content.replaceAll("#dt_week#", DateKit.getWeek(DateKit.nowOfDate()));

        return content;
    }

    /**
     * 处理表单，删除不必要的元素
     *
     * @param html
     * @return
     */
    public String parseHTML(String html) {
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

    /**
     * 合并流程变量
     *
     * @param content
     * @param processVariables
     * @return
     */
    public String parseFormForTaskVaiables(String content, Map<String, Object> processVariables) {
        for (String key : processVariables.keySet()) {
            content = content.replaceAll("#var_" + key + "#", processVariables.get(key) + "");
        }
        return content;
    }


}
