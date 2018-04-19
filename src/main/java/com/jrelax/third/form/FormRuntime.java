package com.jrelax.third.form;

import com.jrelax.core.support.ApplicationCommon;
import com.jrelax.core.web.support.WebApplicationCommon;
import com.jrelax.kit.DateKit;
import com.jrelax.kit.StringKit;
import com.jrelax.web.system.entity.User;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 解析表单为可运行表单
 * Created by zengchao on 2017-02-17.
 */
public class FormRuntime {
    //表达内容
    private String content;
    //参数
    private Map<String, Object> paramMap = new HashMap<>();
    //流程变量
    private Map<String, Object> variableMap = new HashMap<>();
    //当前登录用户
    private User user;

    public FormRuntime(String content) {
        this.content = content;
        user = WebApplicationCommon.getSession() == null ? null : (User) WebApplicationCommon.getSession().getAttribute(ApplicationCommon.SESSION_ADMIN);
    }

    /**
     * 增加参数
     *
     * @param key
     * @param value
     * @return
     */
    public FormRuntime addParam(String key, Object value) {
        this.paramMap.put(key, value);
        return this;
    }

    /**
     * 设置流程变量列表
     *
     * @param variableMap
     */
    public void setVariableMap(Map<String, Object> variableMap) {
        this.variableMap = variableMap;
    }

    /**
     * 获取可运行的表单
     * @return
     */
    public String html() {
        this.parseParam();
        this.parseMacro();
        this.parseVariable();
        return content;
    }

    /**
     * 解析参数
     */
    private void parseParam() {
        for (String key : paramMap.keySet()) {
            content = content.replace("#" + key + "#", StringKit.null2String(paramMap.get(key)));
        }
    }

    //解析宏变量
    private void parseMacro() {
        content = content.replaceAll("#user_realname#", user.getRealName());
        content = content.replaceAll("#user_unitname#", user.getDefaultUnit().getName());
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
    }

    //解析流程变量
    private void parseVariable() {
        for (String key : this.variableMap.keySet()) {
            content = content.replaceAll("#var_" + key + "#", this.variableMap.get(key) + "");
        }
    }

}
