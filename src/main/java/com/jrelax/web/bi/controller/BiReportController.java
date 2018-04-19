package com.jrelax.web.bi.controller;

import com.jrelax.core.web.support.WebApplicationCommon;
import com.jrelax.core.web.support.WebResult;
import com.jrelax.core.web.transform.DataGridTransforms;
import com.jrelax.kit.ObjectKit;
import com.jrelax.orm.query.PageBean;
import com.jrelax.web.bi.entity.BiReport;
import com.jrelax.web.bi.service.BiDatasourceService;
import com.jrelax.web.bi.service.BiReportService;
import com.jrelax.web.support.BaseController;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;


/**
 * @author zengchao
 * @version 1.0
 * @since 1.0
 */
@Controller
@RequestMapping(value = "/bi/report")
public class BiReportController extends BaseController<BiReport> {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    private final String TPL = "/bi/report/";
    @Autowired
    private BiReportService biReportService;
    @Autowired
    private BiDatasourceService biDatasourceService;

    /**
     * 首页
     *
     * @param model
     * @param pageBean
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST})
    public String index(Model model, PageBean pageBean) {
        return TPL + "index";
    }

    /**
     * 数据
     *
     * @param pageBean
     * @return
     */
    @RequestMapping(value = "/data", method = {RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> data(PageBean pageBean) {
        List<BiReport> list = biReportService.list(pageBean);

        return DataGridTransforms.JQGRID.transform(list, pageBean);
    }

    /**
     * 转向新增页面
     *
     * @param model
     * @param pid
     */
    @RequestMapping(value = "/add", method = {RequestMethod.GET})
    public String add(Model model, String pid) {
        return TPL + "add";
    }

    /**
     * 执行新增
     *
     * @param biReport
     * @return
     */
    @RequestMapping(value = "/add/do", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject doAdd(BiReport biReport) {
        try {
            biReport.setCreateUser(getCurrentUser().getRealName());
            biReport.setCreateTime(getCurrentTime());
            biReportService.save(biReport);

            return WebResult.success();
        } catch (Exception e) {
            logger.error(e.getMessage(), e);

            return WebResult.error(e.toString());
        }
    }

    /**
     * 转向编辑页面
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "/edit/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public String edit(Model model, @PathVariable String id) {
        BiReport biReport = biReportService.getById(id);

        if (!ObjectKit.isNotNull(biReport)) {
            return WebApplicationCommon.ERROR.UNAUTHORIZED_ACCESS;
        }

        model.addAttribute("biReport", biReport);

        return TPL + "edit";
    }

    /**
     * 执行编辑
     *
     * @param biReport
     * @return
     */
    @RequestMapping(value = "/edit/do", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject doEdit(BiReport biReport) {
        try {
            //从数据库中获取最新数据
            BiReport eqBiReport = biReportService.getById(biReport.getId());

            if (ObjectKit.isNull(eqBiReport)) {
                return WebResult.error("非法操作");
            }

            eqBiReport.setName(biReport.getName());
            eqBiReport.setDescript(biReport.getDescript());
            biReportService.merge(eqBiReport);

            return WebResult.success();
        } catch (Exception e) {
            logger.error(e.getMessage(), e);

            return WebResult.error(e.toString());
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
            biReportService.executeBatch("delete from BiReportData where report.id=?", id);
            biReportService.delete(id);

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
        BiReport biReport = biReportService.getById(id);

        if (!ObjectKit.isNotNull(biReport)) {
            return WebApplicationCommon.ERROR.UNAUTHORIZED_ACCESS;
        }

        model.addAttribute("biReport", biReport);

        return TPL + "detail";
    }

    /**
     * 设计报表
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/design/{id}")
    public String design(Model model, @PathVariable String id) {
        detail(model, id);

        return TPL + "design";
    }

    /**
     * 浏览报表
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "/view/{id}")
    public String view(Model model, @PathVariable String id) {
        detail(model, id);
        return TPL + "view";
    }

    /**
     * 保存设计
     *
     * @param report
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public JSONObject save(BiReport report) {
        biReportService.executeBatch("update BiReport set source=?, content=? where id=?", report.getSource(), report.getContent(), report.getId());
        return WebResult.success();
    }

    /**
     * 帮助说明
     * @param model
     * @param module
     * @return
     */
    @RequestMapping(value = "/help/{module}")
    public String help(Model model, @PathVariable String module) {
        return TPL + "help/" + module;
    }
}
