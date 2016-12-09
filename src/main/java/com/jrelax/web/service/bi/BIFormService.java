package com.jrelax.web.service.bi;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.math.RandomUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import com.jrelax.kit.ObjectKit;
import com.jrelax.kit.StringKit;
import com.jrelax.core.web.support.WebResult;
import com.jrelax.web.entity.bi.BIForm;
import com.jrelax.web.service.BaseService;

@Service
public class BIFormService extends BaseService<BIForm>{
	
	public JSONObject saveForm(BIForm form) {
		//解析html
		Document doc = Jsoup.parse(form.getSource());
		Elements root = doc.getElementsByClass("design");
		if(root.size() == 0)
			return WebResult.error("数据格式错误！");
		Element design = root.get(0);
		//获取表单名称
		Elements titles = design.getElementsByTag("h4");
		if(titles.size() == 0)
			form.setName("新建表单");
		else
			form.setName(titles.get(0).text());
		//表单完成提示
		form.setTip(design.attr("tip"));
		//解析表单内容
		//获取含有data-element属性的控件
		Elements controls = doc.getElementsByAttribute("data-element");
		if(controls.size()>0){
			Map<String,String> cols_tag = new LinkedHashMap<String,String>();
			Iterator<Element> iter = controls.iterator();
			int i=0;
			while(iter.hasNext()){
				Element control = iter.next();
				//如果没有名称，则自动生成名称
				if(StringKit.isEmpty(control.attr("name"))){
					control.attr("name", "data_"+i);
				}
				i++;
				cols_tag.put(control.attr("name"),control.tagName());
			}
			//更新html
			form.setSource(doc.body().html());
			//生成表名，建表语句
			String tableName = "wf_form_"+System.currentTimeMillis()+RandomUtils.nextInt(2);
			if(!StringKit.isEmpty(form.getTableName()))
				tableName = form.getTableName();
			String sql = "create table "+tableName+" ( `id` varchar(50),";
			for(String key : cols_tag.keySet()){
				String tag = cols_tag.get(key);
				if(tag.equals("textarea"))
					sql += "`" + key + "`" + " text,";
				else
					sql += "`" + key + "`" + " varchar(100),";
			}
			sql += "PRIMARY KEY (`id`) )";
			//删除表
			this.executeSqlBatch("drop table if exists "+tableName);
			//创建表
			this.executeSqlBatch(sql);
			
			form.setTableName(tableName);
		}
		//处理源码，生成form表单
		//删除多余属性
		Iterator<Element> iter = controls.iterator();
		while(iter.hasNext()){
			Element e = iter.next();
			//处理宏控件
			if("macros".equals(e.attr("t"))){
				if(e.hasAttr("macrostype")){
					e.after("<span name='"+e.attr("name")+"'>#"+e.attr("macrostype")+"#</span>");
				}
				e.remove();
			}
		}
		//处理流程变量控件
		Iterator<Element> iter2 = doc.getElementsByAttributeValue("t", "variable").iterator();
		while(iter2.hasNext()){
			Element e = iter2.next();
			if("variable".equals(e.attr("t"))){
				if(e.hasAttr("name")){
					e.after("<span>#var_"+e.attr("name")+"#</span>");
				}
				e.remove();
			}
		}
		//删除多余样式
		String content = doc.body().html().replaceAll("design-item", "");
		content = content.replaceAll("design", "");
		content = content.replaceAll("contenteditable=\"true\"", "");
		content = content.replaceAll(" class=\"\"", "");
		content = content.replaceAll("class=\"\"", "");
		content = content.replaceAll("class=\"  \"", "");
		content = content.replaceAll("selected", "");
		if(ObjectKit.isEmpty(form.getId()))
			this.save(form);
		//追加form表单
		content = "<form action=\"#formAction#\" method=\"post\" onsubmit=\"return _form_submit(this);\"><input type=\"hidden\" name=\"_formId\" value=\""+form.getId()+"\"/><input type=\"hidden\" name=\"_tid\" value=\"#tid#\"/>"+content+"</form>";
		doc = Jsoup.parse(content);
		content = doc.body().html();
		form.setContent(content);
		
		if(StringKit.isEmpty(form.getId()))
			form.setCreateUser(getCurrentUser().getUserName());
		//更新到数据库
		super.saveOrUpdate(form);
		return WebResult.success().element("id", form.getId());
	}

	/**
	 * 保存表单2.0
	 * @param form
	 * @return
	 */
	public JSONObject saveForm20(BIForm form) {
		if(StringKit.isEmpty(form.getId()))
			form.setCreateUser(getCurrentUser().getUserName());
		//更新到数据库
		super.saveOrUpdate(form);
		return WebResult.success().element("id", form.getId());
	}

	public JSONObject executeSubmit20(JSONObject jData) {
		if(ObjectKit.isNull(jData.get("form"))) return WebResult.error("未发现任何表单项，无法提交！");
		String formId = jData.getJSONObject("form").getString("id");
		if(ObjectKit.isNotNull(formId)){
			BIForm form = super.getById(formId);
			//先往主表中插入数据
			//#1获取主表字段，不包含.的都是主表字段
			StringBuffer sql = new StringBuffer("insert into "+form.getPrimaryTable()+"(");
			String columns = "";
			String values = "";
			JSONObject master = jData.getJSONObject("master");
			for(Object key : master.keySet()){
				columns += "," + key;
				values += ",'"+master.get(key)+"'";
			}
			if(columns.length()>0) columns = columns.substring(1);
			if(values.length()>0) values = values.substring(1);
			sql.append(columns + ")values("+values+")");
			this.executeSqlBatch(sql.toString());
			//获取ID
			List<?> _last_id = super.nativeList("SELECT LAST_INSERT_ID()");
			
			//插入子表
			String last_id = _last_id.get(0).toString();
			JSONObject slave = jData.getJSONObject("slave");
			if(ObjectKit.isNotNull(slave)){
				for(Object key : slave.keySet()){//遍历所有从表
					JSONArray slaveDatas = slave.getJSONArray(key.toString());
					if(ObjectKit.isNotNull(slaveDatas)){
						for(int i=0;i<slaveDatas.size();i++){
							JSONObject slaveData = slaveDatas.getJSONObject(i);
							StringBuffer childSql = new StringBuffer("insert into "+key+"(");
							String childColumns = "fid";
							String childValues = last_id;
							for(Object cKey : slaveData.keySet()){
								childColumns += "," + cKey;
								childValues += ",'"+slaveData.get(cKey)+"'";
							}
							childSql.append(childColumns + ")values("+childValues+")");
							super.executeSqlBatch(childSql.toString());
						}
					}
				}
			}
		}else{
			return WebResult.error("表单已不存在，无法提交。");
		}
		return WebResult.success();
	}
}
