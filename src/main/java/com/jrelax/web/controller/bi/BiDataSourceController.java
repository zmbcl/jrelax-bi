package com.jrelax.web.controller.bi;

import com.jrelax.core.web.support.http.ContentType;
import com.jrelax.kit.ObjectKit;
import com.jrelax.kit.RegexKit;
import com.jrelax.core.web.support.ControllerCommon;
import com.jrelax.core.web.support.WebResult;
import com.jrelax.kit.StringKit;
import com.jrelax.orm.query.Condition;
import com.jrelax.orm.query.PageBean;
import com.jrelax.web.controller.BaseController;
import com.jrelax.web.entity.bi.BiDatasource;
import com.jrelax.web.entity.bi.BiDatasourceParams;
import com.jrelax.web.service.bi.BiDatasourceParamsService;
import com.jrelax.web.service.bi.BiDatasourceService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.log4j.Logger;
import org.hibernate.criterion.Order;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Created by zengc on 2016-05-05.
 */
@Controller
@RequestMapping("/bi/ds")
public class BiDataSourceController extends BaseController<Object> {
    public final String TPL = "/bi/ds/";
    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private BiDatasourceService biDatasourceService;
    @Autowired
    private BiDatasourceParamsService biDatasourceParamsService;

    @RequestMapping(method = {RequestMethod.GET})
    public String index(Model model, PageBean pageBean) {
        pageBean.addOrder(Order.desc("createTime"));
        List<BiDatasource> list = biDatasourceService.list(pageBean);
        model.addAttribute("list", list);
        return TPL + "index";
    }

    /**
     * 执行sql
     *
     * @param sql
     * @return
     */
    @RequestMapping(value = "/exec", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject exec(String sql, String[] field, String[] defaultValue) {
        try {
            if (sql.indexOf("delete") >= 0 || sql.indexOf("update") >= 0)
                return WebResult.error("只允许执行查询操作！");
            sql = biDatasourceService.parseSql(sql, field, defaultValue);
            List<Map<String, Object>> list = biDatasourceService.nativeListToMap(sql);

            JSONArray data = new JSONArray();
            for (Map<String, Object> map : list) {
                JSONObject obj = new JSONObject();
                Iterator<String> iter = map.keySet().iterator();
                while (iter.hasNext()) {
                    String key = iter.next();
                    Object value = map.get(key);

                    obj.element(key, value);
                }

                data.add(obj);
            }
            JSONObject result = WebResult.success();
            result.element("html", biDatasourceService.toHTML(data));
            result.element("json", biDatasourceService.toJSON(data));
            result.element("xml", biDatasourceService.toXML(data));
            return result;
        } catch (Exception e) {
            logger.error(e);
            if(ObjectKit.isNotNull(e.getCause()))
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
        return TPL + "add";
    }

    /**
     * 执行新增
     */
    @RequestMapping(value = "/add/do", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject doAdd(BiDatasource biDatasource, String[] field, String[] defaultValue) {
        try {
            biDatasource.setCreateTime(getCurrentTime());
            biDatasource.setCreateUser(getCurrentUser().getUserName());
            biDatasourceService.save(biDatasource, field, defaultValue);
            return WebResult.success();
        } catch (Exception e) {
            logger.error(e);
            return WebResult.error(e);
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
            logger.error(e);

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
            return ControllerCommon.UNAUTHORIZED_ACCESS;
        }
        List<BiDatasourceParams> params = biDatasourceParamsService.list(Condition.NEW().eq("datasource", biDatasource));

        model.addAttribute("biDatasource", biDatasource);
        model.addAttribute("params", params);

        return TPL + "detail";
    }

    @RequestMapping(value="/view/{type}/{id}", method={RequestMethod.POST, RequestMethod.GET})
    public String view(Model model, @PathVariable String type, @PathVariable  String id){
        detail(model, id);
        model.addAttribute("type", type);
        return TPL + "view";
    }

    
    @RequestMapping(value="/data/{type}/{id}", method={RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public String data(@PathVariable String type, @PathVariable  String id, @RequestParam Map<String, String> params){
        String str = "";
    	try {
            List<Map<String, Object>> data = biDatasourceService.getData(id, params);
            if(ObjectKit.isNotNull(data)){
                switch (type){
                    case "json":
                        str = biDatasourceService.toJSON(data);
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
            }else{
                str = "未知数据源";
            }
    	} catch (Exception e) {
    		logger.error(e);
    	}

        return str;
    }

    @RequestMapping(value="/metadata/{id}", method={RequestMethod.POST, RequestMethod.GET})
    @ResponseBody
    public JSONArray metadata(@PathVariable  String id){
        return JSONArray.fromObject(biDatasourceService.getMetadata(id));
    }
}
