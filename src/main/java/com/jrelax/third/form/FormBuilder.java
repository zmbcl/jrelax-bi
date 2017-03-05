package com.jrelax.third.form;

import com.jrelax.kit.StringKit;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.*;

/**
 * 表单构建
 * Created by zengchao on 2017-02-17.
 */
public class FormBuilder {
    public static final String ATTR_CONTAINER = "containers";
    public static final String ATTR_FIELD = "field";//字段标签
    public static final String ATTR_MACRO = "macro";//宏变量标签
    public static final String ATTR_VARIABLE = "variable";//流程变量标签


    /**
     * @param source
     */
    public FormBuilder(String source) {
        this.source = source;
        document = Jsoup.parse(source);
        this.addPrefixElement("<input type='hidden' name='_formId' value='#formId#'/>")//表单ID
        .addPrefixElement("<input type='hidden' name='_tid' value='#tid#'/>")//流程相关ID
        .addPrefixElement("<input type='hidden' name='_start' value='#start#'/>");//启动流程标识
    }

    //表单头部
    private String header = "<form action='#formAction#' method='post' onsubmit='return fd.run.submit(this)'>";
    //表单尾部
    private String footer = "</form>";
    //前置元素
    private List<String> prefixElements = new ArrayList<>();
    //表单源文件
    private String source = "";
    private Document document = null;
    private Map<String, String> columnMapping = new LinkedHashMap<>();

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public String getFooter() {
        return footer;
    }

    public void setFooter(String footer) {
        this.footer = footer;
    }

    public List<String> getPrefixElements() {
        return prefixElements;
    }

    public void setPrefixElements(List<String> prefixElements) {
        this.prefixElements = prefixElements;
    }

    /**
     * 增加前置元素
     *
     * @param element
     * @return
     */
    public FormBuilder addPrefixElement(String element) {
        this.prefixElements.add(element);
        return this;
    }

    public Map<String, String> getColumnMapping() {
        return columnMapping;
    }

    /**
     * 是否是空表单
     * @return
     */
    public boolean isEmpty(){
        return getContainers().size() == 0;
    }

    public Elements getContainers(){
        return document.getElementsByClass(ATTR_CONTAINER);
    }

    public Element getDesign(){
        return getContainers().get(0);
    }

    /**
     * 获取表单完成提示语
     * @return
     */
    public String getFormTip(){
        return getDesign().attr("tip");
    }

    /**
     * 解析
     *
     * @return
     */
    public String render() {
        this.renderMacro();
        this.renderVariable();
        this.renderField();
        this.clear();

        StringBuilder content = new StringBuilder();
        content.append(this.header).append(System.lineSeparator());
        for(String prefix : this.prefixElements){
            content.append(prefix).append(System.lineSeparator());
        }
        content.append(document.body().html());
        content.append(this.footer);
        return content.toString();
    }

    /**
     * 解析宏变量
     *
     * @return
     */
    public void renderMacro() {
        Elements macros = document.getElementsByAttribute(ATTR_MACRO);
        for (Element e : macros) {
            String name = e.attr(ATTR_MACRO);
            e.after(String.format("<span class='macro %s' style='%s'>#%s#</span>", e.attr("class"), e.attr("style"), name));
            this.prefixElements.add(String.format("<input type='hidden' field='%s' name='%s' value='#%s#'/>", name, name, name));
            e.remove();
        }
    }

    /**
     * 解析流程变量
     *
     * @return
     */
    public void renderVariable() {
        Elements variables = document.getElementsByAttribute(ATTR_VARIABLE);
        for (Element e : variables) {
            String name = e.attr(ATTR_VARIABLE);
            e.after(String.format("<span class='variables %s' style='%s'>#%s#</span>", e.attr("class"), e.attr("style"), name));
            this.prefixElements.add(String.format("<input type='hidden' field='%s' name='%s' value='#%s#'/>", name, name, name));
            e.remove();
        }
    }

    /**
     * 解析字段
     * @return
     */
    public void renderField(){
        columnMapping.clear();
        Elements controls = document.getElementsByAttribute(ATTR_FIELD);
        if (controls.size() > 0) {
            Iterator<Element> iterator = controls.iterator();
            int i = 0;
            while (iterator.hasNext()) {
                Element control = iterator.next();
                //如果没有名称，则自动生成名称
                if (StringKit.isEmpty(control.attr(ATTR_FIELD))) {
                    control.attr(ATTR_FIELD, "data_" + i);
                }
                if (StringKit.isEmpty(control.attr("name")))
                    control.attr("name", control.attr(ATTR_FIELD));
                i++;
                columnMapping.put(control.attr(ATTR_FIELD), control.tagName());
            }
        }
    }

    /**
     * 清理无用信息
     */
    private void clear() {
        document.getElementsByAttribute("contenteditable").removeAttr("contenteditable");
        document.getElementsByAttribute("fd-move").removeAttr("fd-move");
        document.getElementsByAttribute("fd-view").removeAttr("fd-view");
        document.getElementsByAttribute("fd-label").removeAttr("fd-label");
        document.getElementsByAttribute("id").removeAttr("id");
        document.getElementsByAttribute("field").removeAttr("field");
        document.getElementsByClass("fd-view-selected").removeClass("fd-view-selected");
        document.getElementsByClass("fd-view-current").removeClass("fd-view-current");
        document.getElementsByClass("fd-view-drag-in").removeClass("fd-view-drag-in");
    }
}
