package com.jrelax.web.bi.controller;

import com.jrelax.core.web.support.WebResult;
import com.jrelax.core.web.transform.DataGridTransforms;
import com.jrelax.kit.ObjectKit;
import com.jrelax.orm.query.PageBean;
import com.jrelax.web.support.BaseController;
import com.jrelax.web.bi.entity.BiCharts;
import com.jrelax.web.bi.service.BiChartsService;
import com.jrelax.web.bi.service.BiDatasourceService;
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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 图表
 * Created by zengc on 2016-05-05.
 */
@Controller
@RequestMapping("/bi/charts")
public class BiChartsController extends BaseController<Object> {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    public final String TPL = "/bi/charts/";

    @Autowired
    private BiDatasourceService datasourceService;
    @Autowired
    private BiChartsService chartsService;

    /**
     * 首页
     *
     * @param model
     * @return
     */
    @RequestMapping(method = {RequestMethod.GET})
    public String index(Model model) {
        model.addAttribute("chartsType", JSONObject.fromObject(getDataDict().getMap("bi_charts_type")));
        return TPL + "index";
    }

    /**
     * 数据
     * @param pageBean
     * @return
     */
    @RequestMapping("/data")
    @ResponseBody
    public Map<String, Object> data(PageBean pageBean){
        List<BiCharts> list = chartsService.list(pageBean);

        return DataGridTransforms.JQGRID.transform(list, pageBean);
    }

    /**
     * 选择图表
     *
     * @param model
     * @return
     */
    @RequestMapping("/add")
    public String add(Model model) {
        model.addAttribute("chartsType", getDataDict().getMap("bi_charts_type"));
        return TPL + "add";
    }

    /**
     * @param model
     * @param type  图表类型
     * @return
     */
    @RequestMapping("/add/2")
    public String step2(Model model, String type) {
        model.addAttribute("dsList", datasourceService.list());
        model.addAttribute("type", type);
        return TPL + "/2";
    }

    /**
     * 根据选择的数据源获取数据源相关信息：基础信息、结构
     *
     * @param model
     * @param ids   数据源id数组
     * @return
     */
    @RequestMapping("/datasource")
    public String datasource(Model model, String type, String[] ids) {
        List<Map<String, Object>> list = new ArrayList<>();
        for (String id : ids) {
            Map<String, Object> map = new HashMap<>();
            map.put("datasource", datasourceService.get("select id,name from BiDatasource where id=?", id));
            map.put("meta", datasourceService.getMetadata(id));
            list.add(map);
        }
        model.addAttribute("list", list);
        model.addAttribute("type", type);
        return TPL + "datasource";
    }

    /**
     * @param model
     * @param type    图表类型
     * @param configs 数据源配置
     * @return
     */
    @RequestMapping("/add/3")
    public String step3(Model model, String type, String configs) {
        model.addAttribute("type", type);
        model.addAttribute("configs", configs);
        return TPL + type + "/3";
    }

    /**
     * @param model
     * @param type    图表类型
     * @param configs 图表配置
     * @return
     */
    @RequestMapping("/add/4")
    public String step4(Model model, String type, String configs) {
        model.addAttribute("type", type);
        model.addAttribute("configs", configs);
        return TPL + type + "/4";
    }

    /**
     * 保存入库
     *
     * @return
     */
    @RequestMapping("/add/do")
    @ResponseBody
    public JSONObject doAdd(String name, String type, String configs) {
        BiCharts charts = new BiCharts();
        charts.setName(name);
        charts.setType(type);
        charts.setConfigs(configs);
        charts.setCreateUser(getCurrentUser().getRealName());
        charts.setCreateTime(getCurrentTime());

        //保存入库
        try {
            chartsService.save(charts);
        } catch (Exception e) {
            e.printStackTrace();
            return WebResult.error(e);
        }
        return WebResult.success();
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
            chartsService.delete(id);

            return WebResult.success();
        } catch (Exception e) {
            logger.error(e.getMessage(), e);

            return WebResult.error(e.toString());
        }
    }

    @RequestMapping(value = "/detail", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public JSONObject detail(String id){
        JSONObject json = new JSONObject();
        BiCharts charts = chartsService.getById(id);
        if(ObjectKit.isNotNull(charts)){
            json.element("id", charts.getId());
            json.element("type", charts.getType());
            json.element("configs", JSONObject.fromObject(charts.getConfigs()));
        }
        return json;
    }

    /**
     * 预览
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/preview")
    public String preview(Model model, String id) {
        model.addAttribute("id", id);
        return TPL + "/preview";
    }

    /**
     * 查看引用代码
     * @param model
     * @param id
     * @return
     */
    @RequestMapping("/code")
    public String code(Model model, String id) {
        model.addAttribute("id", id);
        return TPL + "/code";
    }
}
