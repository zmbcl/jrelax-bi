package com.jrelax.web.bi.controller;

import com.jrelax.bi.DBKit;
import com.jrelax.bi.DBPool;
import com.jrelax.core.web.support.WebApplicationCommon;
import com.jrelax.core.web.support.WebResult;
import com.jrelax.core.web.support.http.ContentType;
import com.jrelax.core.web.transform.DataGridTransforms;
import com.jrelax.kit.ExcelKit;
import com.jrelax.kit.ObjectKit;
import com.jrelax.kit.StringKit;
import com.jrelax.orm.query.Condition;
import com.jrelax.orm.query.PageBean;
import com.jrelax.web.bi.entity.BiDatasource;
import com.jrelax.web.bi.entity.BiDatasourceParams;
import com.jrelax.web.bi.service.BiDatabaseService;
import com.jrelax.web.bi.service.BiDatasourceParamsService;
import com.jrelax.web.bi.service.BiDatasourceService;
import com.jrelax.web.support.BaseController;
import com.jrelax.web.support.UploadKit;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * BI数据源
 * Created by zengc on 2016-05-05.
 */
@Controller
@RequestMapping("/bi/datasource")
public class BiDataSourceController extends BaseController<Object> {
    public final String TPL = "/bi/datasource/";
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private BiDatasourceService biDatasourceService;
    @Autowired
    private BiDatasourceParamsService biDatasourceParamsService;
    @Autowired
    private BiDatabaseService biDatabaseService;

    @RequestMapping(method = {RequestMethod.GET})
    public String index(Model model, PageBean pageBean) {
        return TPL + "index";
    }

    @RequestMapping("/data")
    @ResponseBody
    public Map<String, Object> data(PageBean pageBean) {
        List<BiDatasource> list = biDatasourceService.list(pageBean);

        return DataGridTransforms.JQGRID.transform(list, pageBean);
    }

    /**
     * 选择数据源
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/select")
    public String select(Model model, String virtual) {
        if (ObjectKit.isNotNull(virtual)) {
            model.addAttribute("dsList", biDatasourceService.list(Condition.NEW().eq("virtuald", Boolean.parseBoolean(virtual))));
        } else {
            model.addAttribute("dsList", biDatasourceService.list());
        }
        return TPL + "select";
    }

    /**
     * 执行sql
     *
     * @param sql
     * @return
     */
    @RequestMapping(value = "/exec", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject exec(String db, String sql, String[] field, String[] method, String[] defaultValue) {
        try {
            DBKit dbKit = new DBKit(DBPool.getInstance().getDataSource(db));
            if (sql.contains("delete") || sql.contains("update"))
                return WebResult.error("只允许执行查询操作！");
            List<Map<String, Object>> list = biDatasourceService.getData(db, sql, biDatasourceService.convertParam(field, method, defaultValue), biDatasourceService.convertParamValue(field, defaultValue));
            //数据格式转换
            JSONArray data = biDatasourceService.toJSON(list);

            //返回结果
            JSONObject result = WebResult.success();
            result.element("html", biDatasourceService.toHTML(data));
            result.element("json", biDatasourceService.toJSON(data));
            result.element("xml", biDatasourceService.toXML(data));
            return result;
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            if (ObjectKit.isNotNull(e.getCause()))
                return WebResult.error(e.getCause().getLocalizedMessage());
            else
                return WebResult.error(e.getLocalizedMessage());
        }
    }

    /**
     * 转向新增页面
     */
    @RequestMapping(value = "/add", method = {RequestMethod.GET})
    public String add(Model model, String pid) {
        model.addAttribute("list", biDatabaseService.listAll());
        return TPL + "add";
    }

    /**
     * 执行新增
     */
    @RequestMapping(value = "/add/do", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject doAdd(BiDatasource biDatasource, String[] field, String[] method, String[] defaultValue) {
        try {
            biDatasource.setCreateTime(getCurrentTime());
            biDatasource.setCreateUser(getCurrentUser().getUserName());
            biDatasourceService.save(biDatasource, field, method, defaultValue);
            return WebResult.success();
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return WebResult.error(e);
        }
    }

    /**
     * 导入Excel
     *
     * @param path 文件路径
     * @return
     */
    @RequestMapping(value = "/add/excel")
    @ResponseBody
    public JSONObject addExcel(String path) {
        try {
            File excel = new File(UploadKit.getAbsolutePath(path));
            if (!excel.exists()) return WebResult.error("文件不存在");
            List<List<String>> data = ExcelKit.getRows(excel, 0, 0);
            if (data.size() == 0) return WebResult.error("Excel文件为空");
            if (data.size() < 2) return WebResult.error("Excel文件数据为空");
            List<String> title = data.get(0);
            if (title.size() == 0) return WebResult.error("Excel标题数据为空");
            String tableName = "ds_excel_" + System.currentTimeMillis();
            StringBuilder createSql = new StringBuilder(String.format("CREATE TABLE `%s` (\n", tableName));
            StringBuilder columnSql = new StringBuilder("");
            List<String> values = new ArrayList<>();

            for (String column : title) {
                createSql.append(String.format("`%s` varchar(255) NULL,\n", column));
                columnSql.append(",").append(column).append(" ");
                values.add("?");
            }

            createSql = createSql.replace(createSql.length() - 2, createSql.length() - 1, "");
            createSql.append(")");

            String columns = columnSql.substring(1);

            //创建表
            try {
                biDatabaseService.executeSqlBatch(createSql.toString());
            } catch (Exception e) {
                return WebResult.error("数据库表创建失败：" + e.getMessage());
            }

            //导入数据
            String insertSql = String.format("insert into `%s`(%s) values(%s)", tableName, columns, StringKit.toString(values));
            for (int i = 1; i < data.size(); i++) {
                List<String> row = data.get(i);
                if (row.size() < title.size()) {//补充空值
                    for (int j = row.size(); j < title.size(); j++) {
                        row.add("");
                    }
                }
                try {
                    biDatabaseService.executeSqlBatch(insertSql, row.toArray(new Object[]{}));
                } catch (Exception e) {
                    logger.error("数据源Excel数据导入错误：" + e.getMessage());
                }
            }


            return WebResult.success().element("sql", String.format("select %s from %s", columns, tableName));
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return WebResult.error(e);
        }
    }

    /**
     * 转向新增页面
     */
    @RequestMapping(value = "/virtual/add", method = {RequestMethod.GET})
    public String addVirtual(Model model, String pid) {
        return TPL + "virtual";
    }

    /**
     * 执行新增
     */
    @RequestMapping(value = "/virtual/add/do", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject doAddVirtual(BiDatasource biDatasource) {
        try {
            biDatasource.setDb("local");
            biDatasource.setVirtuald(true);
            biDatasource.setCreateTime(getCurrentTime());
            biDatasource.setCreateUser(getCurrentUser().getUserName());
            biDatasourceService.save(biDatasource);
            return WebResult.success();
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return WebResult.error(e);
        }
    }

    /**
     * 执行sql
     *
     * @param sql
     * @return
     */
    @RequestMapping(value = "virtual/exec", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject execVirtual(String sql, String[] ids) {
        try {
            //返回结果
            JSONObject result = WebResult.success();

            DBKit dbKit = new DBKit(DBPool.getInstance().getBIExchangeDataSource());
            for (int i = 0; i < ids.length; i++) {
                String id = ids[i];
                String tableName = "tb_" + id;
                List<String> keyList = biDatasourceService.getMetadata(id);
                //删除表
                dbKit.execute("drop table if exists " + tableName);
                //创建表
                StringBuffer createTableSql = new StringBuffer("create table " + tableName + " (");
                for (String key : keyList) {
                    createTableSql.append(key).append(" varchar(100),");
                }
                createTableSql = new StringBuffer(createTableSql.substring(0, createTableSql.length() - 1));
                createTableSql.append(")");
                dbKit.execute(createTableSql.toString());

                List<Map<String, Object>> mapList = biDatasourceService.getData(id, null);

                for (Map<String, Object> map : mapList) {
                    StringBuilder insertSql = new StringBuilder("insert into `" + tableName + "`(" + StringKit.toString(keyList) + ") values(");
                    for (String key : keyList) {
                        insertSql.append(String.format("'%s',", map.get(key)));
                    }
                    insertSql = new StringBuilder(insertSql.substring(0, insertSql.length() - 1));
                    insertSql.append(")");

                    dbKit.execute(insertSql.toString());
                }

                sql = sql.replace("{" + i + "}", tableName);
            }
//            System.out.println("H2：" + sql);
            List<Map<String, Object>> list = dbKit.listToMap(sql);

            //数据格式转换
            result.element("html", biDatasourceService.toHTML(list));
            result.element("json", biDatasourceService.toJSON(list));
            result.element("xml", biDatasourceService.toXML(list));
            return result;
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            if (ObjectKit.isNotNull(e.getCause()))
                return WebResult.error(e.getCause().getLocalizedMessage());
            else
                return WebResult.error(e.getLocalizedMessage());
        }
    }

    /**
     * 删除
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/delete/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public JSONObject delete(@PathVariable String id) {
        try {
            //删除相关的所有数据
            biDatasourceService.delete(id);

            return WebResult.success();
        } catch (Exception e) {
            logger.error(e.getMessage(), e);

            return WebResult.error(e.toString());
        }
    }

    /**
     * 查看详情
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "/detail/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public String detail(Model model, @PathVariable String id) {
        BiDatasource biDatasource = biDatasourceService.getById(id);

        if (!ObjectKit.isNotNull(biDatasource)) {
            return WebApplicationCommon.ERROR.UNAUTHORIZED_ACCESS;
        }
        List<BiDatasourceParams> params = biDatasourceParamsService.list(Condition.NEW().eq("datasource", biDatasource));

        model.addAttribute("biDatasource", biDatasource);
        model.addAttribute("params", params);

        return TPL + "detail";
    }

    @RequestMapping(value = "/view/{type}/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    public String view(Model model, @PathVariable String type, @PathVariable String id) {
        detail(model, id);
        model.addAttribute("type", type);
        return TPL + "view";
    }


    @RequestMapping(value = "/data/{type}/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String data(@PathVariable String type, @PathVariable String id, @RequestParam Map<String, String> params) {
        String str = "";
        try {
            List<Map<String, Object>> data = biDatasourceService.getData(id, params);
            if (ObjectKit.isNotNull(data)) {
                switch (type) {
                    case "json":
                        str = biDatasourceService.toJSON(data).toString();
                        getResponse().setContentType(ContentType.JSON);
                        break;
                    case "xml":
                        str = biDatasourceService.toXML(data);
                        getResponse().setContentType(ContentType.XML);
                        break;
                    case "html":
                        str = biDatasourceService.toHTML(data);
                        getResponse().setContentType(ContentType.HTML);
                        break;
                }
            } else {
                str = "未知数据源";
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }

        return str;
    }

    @RequestMapping(value = "/metadata/{id}", method = {RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public JSONObject metadata(@PathVariable String id) {
        JSONObject metaJson = new JSONObject();
        BiDatasource datasource = biDatasourceService.getById(id);
        metaJson.element("columns", JSONArray.fromObject(biDatasourceService.getMetadata(id)));
        metaJson.element("name", datasource.getName());
        return metaJson;
    }
}
