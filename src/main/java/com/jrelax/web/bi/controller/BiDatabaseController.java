package com.jrelax.web.bi.controller;

import com.jrelax.bi.DBPool;
import com.jrelax.kit.StringKit;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.jrelax.kit.ObjectKit;
import com.jrelax.core.web.support.ControllerCommon;
import com.jrelax.core.web.support.WebResult;
import com.jrelax.orm.query.PageBean;
import com.jrelax.web.support.BaseController;
import com.jrelax.core.web.transform.DataGridTransforms;
import com.jrelax.web.bi.service.BiDatabaseService;
import com.jrelax.web.bi.entity.BiDatabase;

/**
 * @author zengchao
 * @version 1.0
 * @since 1.0
 */
@Controller
@RequestMapping(value = "/bi/database")
public class BiDatabaseController extends BaseController<BiDatabase> {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    private final String TPL = "/bi/database/";

    @Autowired
    private BiDatabaseService biDatabaseService;

    /**
     * 首页
     *
     * @param model
     * @param pageBean
     */
    @RequestMapping(method = {RequestMethod.GET, RequestMethod.POST})
    public String index(Model model, PageBean pageBean) {
        model.addAttribute("dbType", JSONObject.fromObject(getDataDict().getMap("bi_db_type")));
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
        List<BiDatabase> list = biDatabaseService.list(pageBean);
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
        model.addAttribute("dbType", getDataDict().getMap("bi_db_type"));
        return TPL + "add";
    }

    /**
     * 执行新增
     *
     * @param biDatabase
     * @return
     */
    @RequestMapping(value = "/add/do", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject doAdd(BiDatabase biDatabase) {
        try {
            biDatabase.setDriver(biDatabaseService.getDriver(biDatabase.getType()));
            biDatabase.setUrl(biDatabaseService.toUrl(biDatabase.getType(), biDatabase.getHost(), biDatabase.getPort(), biDatabase.getDbName()));
            biDatabase.setInvokes(0);
            biDatabase.setCreateUser(getCurrentUser().getRealName());
            biDatabase.setCreateTime(getCurrentTime());
            biDatabaseService.save(biDatabase);

            //添加到数据源池中
            DBPool.getInstance().create(biDatabase.getId(), biDatabase.getDriver(), biDatabase.getUrl(), biDatabase.getUsername(), biDatabase.getPassword());
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
        BiDatabase biDatabase = biDatabaseService.getById(id);
        if (!ObjectKit.isNotNull(biDatabase))
            return ControllerCommon.UNAUTHORIZED_ACCESS;
        model.addAttribute("biDatabase", biDatabase);
        model.addAttribute("dbType", getDataDict().getMap("bi_db_type"));
        return TPL + "edit";
    }

    /**
     * 执行编辑
     *
     * @param biDatabase
     * @return
     */
    @RequestMapping(value = "/edit/do", method = {RequestMethod.POST})
    @ResponseBody
    public JSONObject doEdit(BiDatabase biDatabase) {
        try {
            //从数据库中获取最新数据
            BiDatabase eqBiDatabase = biDatabaseService.getById(biDatabase.getId());
            if (ObjectKit.isNull(eqBiDatabase)) {
                return WebResult.error("非法操作");
            }

            eqBiDatabase.setName(biDatabase.getName());
            eqBiDatabase.setType(biDatabase.getType());
            eqBiDatabase.setDriver(biDatabaseService.getDriver(biDatabase.getType()));
            eqBiDatabase.setHost(biDatabase.getHost());
            eqBiDatabase.setPort(biDatabase.getPort());
            eqBiDatabase.setDbName(biDatabase.getDbName());
            eqBiDatabase.setUrl(biDatabaseService.toUrl(biDatabase.getType(), biDatabase.getHost(), biDatabase.getPort(), biDatabase.getDbName()));
            eqBiDatabase.setUsername(biDatabase.getUsername());
            eqBiDatabase.setPassword(biDatabase.getPassword());

            biDatabaseService.merge(eqBiDatabase);

            //先释放
            DBPool.getInstance().destroy(eqBiDatabase.getId());
            //再创建
            DBPool.getInstance().create(eqBiDatabase.getId(), eqBiDatabase.getDriver(), eqBiDatabase.getUrl(), eqBiDatabase.getUsername(), eqBiDatabase.getPassword());
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
            BiDatabase database = biDatabaseService.getById(id);
            if(ObjectKit.isNotNull(database)){
                //删除相关的所有数据
                biDatabaseService.delete(database);
                //释放数据源
                DBPool.getInstance().destroy(database.getName());
            }
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
        BiDatabase biDatabase = biDatabaseService.getById(id);
        if (!ObjectKit.isNotNull(biDatabase))
            return ControllerCommon.UNAUTHORIZED_ACCESS;
        model.addAttribute("biDatabase", biDatabase);
        return TPL + "detail";
    }

    /**
     * 测试数据源是否可用
     *
     * @param type     数据库类型
     * @param host
     * @param port
     * @param dbName
     * @param username
     * @param password
     * @return
     */
    @RequestMapping("/test")
    @ResponseBody
    public JSONObject test(String type, String host, Integer port, String dbName, String username, String password) {
        if(StringKit.isEmpty(type) || StringKit.isEmpty(host) || StringKit.isEmpty(dbName) || StringKit.isEmpty(username))
            return WebResult.error("配置信息不全");
        if (DBPool.getInstance().test(biDatabaseService.getDriver(type), biDatabaseService.toUrl(type, host, port, dbName), username, password)) {
            return WebResult.success();
        }
        return WebResult.error("连接失败");
    }
}
