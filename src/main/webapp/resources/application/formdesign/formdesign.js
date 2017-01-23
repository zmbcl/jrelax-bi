/**
 * 说明
 * .design 表示布局容器，所有的表单项全部放在此处
 * .design-item 表示可以拖至的容器
 * .form-element 用来拖动
 * .view 下面的内容是实际要放置到表单容器里的
 * t属性与右侧属性栏里面的 with属性相对应， 用来表示此空间拥有哪些可以设置的属性
 * data-element 表示此节点是用来存放或输入数据的，后台会生成对应的数据库字段
 */
$(function() {
	$(".form-element").dragg();
	var content;
	// 开始拖动
	$(document).on('dragstart', '.form-element', function(e) {
		content = $(this);
	});
	// 拖动过程中
	$(document).on('drag', '#helper', function(e) {
		$(this).css('opacity', 0.5);
	});
	// 拖进指定区域
	$(document).on('dragin', '.design-item', function(e) {
		$(this).addClass("bg-default");
	});
	// 拖出指定区域
	$(document).on('dragout', '.design-item', function(e) {
		$(this).removeClass("bg-default");
	});
	// 拖动结束
	$(document).on('drop', '.design-item', function(e) {
		var element = $(content).parent().next();
		$(this).append(element.clone().children());
		$(this).removeClass("bg-default");
		bindEvents();// 绑定点击事件
		return false;
	});
	$("#propertyForm2 div[with!='*']").hide();
	$(".design").bind("click", function() {
		clearSelected();
	});
	
	//实现撤销功能
	var _cache = [];
	var _cache_redo = false;
	setInterval(function(){
		var html = $(".design").html();
		if(_cache.length > 0){
			if(_cache[_cache.length-1] != html && !_cache_redo){
				//判断是否超出10个，超出10个则从头开始一个一个删除
				if(_cache.length >= 10){
					_cache.shift();
				}
				_cache.push(html);
			}
		}else{
			_cache.push(html);
		}
	}, 1000);
	// 删除
	$(document).bind("keyup", function(e) {
		if (e.keyCode == 46) {
			removeElement();
		}
		_cache_redo = false;
	});
	//撤销+反撤销事件
	$(document).bind("keydown", function(e){
		if(e.ctrlKey){
			_cache_redo = true;
		}
		if (e.ctrlKey && e.keyCode == 90) {// Ctrl + Z
			var html = $(".design").html();
			if(html == _cache.pop())
				html = _cache.pop();
			$(".design").html(html);
		}
	});
	// 初始化属性编辑器
	initPropertyForm();
});
function bindEvents() {
	$(".design *").each(function() {
		$(this).unbind("click");
		$(this).bind("click", function(e) {
			var ele = $(this);
			/*if (ele.hasClass("selected")) {
				clearProperty();
				ele.removeClass("selected");
			}else {
				if (!e.ctrlKey) {
					clearSelected();
				}
				initProperty(this);
				ele.addClass("selected");
			}*/
			if (!e.ctrlKey) {
				clearSelected();
			}
			initProperty(this);
			ele.addClass("selected");
			return false;
		});
	});
}
// 重做
function clearHtml() {
	$(".design").html("");
}
// 删除选中
function removeElement() {
	$(".design .selected").remove();
}
// 合并单元格
function mergeCell() {
	var selecteds = $(".design .selected");
	if (selecteds.length < 2) {
		alert("选中2个单元格以上才可以合并！（提示：按住Ctrl可以多选）");
		return;
	}
	selecteds.each(function() {
		if (this.tagName.toLowerCase() != "td") {
			alert("选中的不全是单元格！");

		}
	});
	// 判断是否是同一行
	var sameRow = true;
	var _index;
	for ( var i = 0; i < selecteds.length; i++) {
		if (_index != undefined) {
			var _index2 = $(selecteds[i]).parents("tr").index();
			if (_index != _index2) {
				sameRow = false;
			}
		} else {
			_index = $(selecteds[i]).parents("tr").index();
		}
	}
	if (sameRow) {
		var firstTd = $(selecteds[0]);
		var colspan = firstTd.attr("colspan") ? parseInt(firstTd
				.attr("colspan"))
				+ selecteds.length - 1 : selecteds.length;
		firstTd.attr("colspan", colspan);
	} else {
		var firstTd = $(selecteds[0]);
		var colspan = firstTd.attr("rowspan") ? parseInt(firstTd
				.attr("rowspan"))
				+ selecteds.length - 1 : selecteds.length;
		firstTd.attr("rowspan", colspan);
	}
	for ( var i = 1; i < selecteds.length; i++) {
		$(selecteds[i]).remove();
	}
	bindEvents();
}
// 插入一行
function insertRow($table,t) {
	var selecteds = $table || $(".design .selected");
	if (selecteds.length <= 0) {
		alert("先选中表格！");
		return;
	}
	var tagName = selecteds[0].tagName.toLowerCase();
	var tr;
	switch (tagName) {
	case "td":
		tr = $(selecteds[0]).parents("tr");
		break;
	case "tr":
		tr = $(selecteds[0]);
		break;
	case "table":
		tr = $(selecteds[0]).find("tr:first");
		break;
	}
	if (tr) {
		if(t == 2)
			tr = $(tr.clone()).insertAfter(tr);
		else
			tr = $(tr.clone()).insertBefore(tr);
		tr.find("td").removeClass("selected");
		tr.find("td").text("");
	}
	bindEvents();
}
//插入一行
function insertRow2($table) {
	insertRow($table,2);
}
// 删除一行
function removeRow($table) {
	var selecteds = $table || $(".design .selected");
	if (selecteds.length <= 0) {
		alert("先选中表格！");
		return;
	}
	var table = _getTable(selecteds[0]);
	if (table) {
		table.find("tr:last").remove();
	}
}
// 插入一列
function insertCol($table,t) {
	var selecteds = $table || $(".design .selected");
	if (selecteds.length <= 0) {
		alert("先选中表格！");
		return;
	}
	var tagName = selecteds[0].tagName.toLowerCase();
	switch (tagName) {
	case "td":
		var index = $(selecteds[0]).index();
		var table = $(selecteds[0]).parents("table");
		table.find("tr").each(function() {
			var td = $(this).find("td:eq(" + index + ")");
			if(t == 2)
				td = $(td.clone()).insertAfter(td);
			else
				td = $(td.clone()).insertBefore(td);
			td.removeClass("selected");
			td.text("");
		});
		break;
	case "tr":
		var table = $(selecteds[0]).parents("table");
		table.find("tr").each(function() {
			var td = $(this).find("td:first");
			if(t == 2)
				td = $(td.clone()).insertAfter(td);
			else
				td = $(td.clone()).insertBefore(td);
			td.removeClass("selected");
			td.text("");
		});
		break;
	case "table":
		var table = $(selecteds[0]);
		table.find("tr").each(function() {
			var td = $(this).find("td:first");
			if(t == 2)
				td = $(td.clone()).insertAfter(td);
			else
				td = $(td.clone()).insertBefore(td);
			td.removeClass("selected");
			td.text("");
		});
		break;
	}
	bindEvents();
}
// 追加一列
function insertCol2($table){
	insertCol($table, 2);
}
// 删除一列
function removeCol($table) {
	var selecteds = $table || $(".design .selected");
	if (selecteds.length <= 0) {
		alert("先选中表格！");
		return;
	}
	var table = _getTable(selecteds[0]);
	if (table) {
		table.find("tr").each(function(){
			$(this).find("td:last").remove();
		});
	}
}
//获取表格
function _getTable(obj){
	if(!obj.tagName)
		return undefined;
	var tagName = obj.tagName.toLowerCase();
	var table;
	switch (tagName) {
		case "td":
			table = $(obj).parents("table");
			break;
		case "tr":
			tr = $(obj).parents("table");
			break;
		case "table":
			table = $(obj);
			break;
	}
	return table;
}
//设置数据源（select、宏标记、列表数据）
function setListData(){
	var selecteds = $(".design .selected");
	if (selecteds.length > 0) {
		var modal = $("#listDataModal");
		var obj = $(selecteds[0]);
		obj = obj.attr("t")?obj:obj.parents("[t]");
		var type = obj.attr("t");
		switch(type){
			case "select"://下拉菜单
				modal.find("h4").text("下拉菜单");
				var tbody = modal.find("table tbody");
				tbody.html("");
				//获取当前值并添加到表格中
				obj.find("option").each(function(){
					var tr = "<tr>";
					tr += "<td><input type='text' value='"+$(this).val()+"'/></td>";
					tr += "<td><input type='text' value='"+$(this).text()+"'/></td>";
					tr += "<td><a href='javascript:;'><i class='fa fa-close'></i></a></td>";
					tbody.append(tr);
				});
				tbody.find("a").bind("click", function(){
					$(this).parents("tr").remove();
				});
				//添加一项按钮事件
				modal.find("#btnAddItem").unbind("click");
				modal.find("#btnAddItem").bind("click", function(){
					var tr = "<tr>";
					tr += "<td><input type='text' value=''/></td>";
					tr += "<td><input type='text' value=''/></td>";
					tr += "<td><a href='javascript:;'><i class='fa fa-close'></i></a></td>";
					tr = $(tr);
					tr.find("a").bind("click", function(){
						$(this).parents("tr").remove();
					});
					tbody.append(tr);
				});
				//保存按钮事件
				modal.find("#btnOk").unbind("click");
				modal.find("#btnOk").bind("click", function(){
					obj.html("");
					modal.find("table tbody tr").each(function(){
						var inputs = $(this).find("input");
						obj.append("<option value='"+inputs[0].value+"'>"+inputs[1].value+"</option>");
					});
					modal.modal("hide");
				});
				modal.modal("show");
			break;
		}
	}
}
//获取控件参数
function initProperty(obj) {
	//切换到控件属性Tab
	$("#propertyTab a:last").tab("show");
	obj = $(obj);
	var form = $("#propertyForm2");
	//初始化控件显示
	var t = obj.attr("t") || obj.parents("[t]").attr("t");
	if (t) {
		form.find("div[with!='*']").hide();
		form.find("div[with*='" + t + "']").show();
	}
	//初始化数值
	if(obj.attr("name")){
		form.find("input[name='controlName']").val(obj.attr("name"));
	}
	if(obj.val()){
		form.find("input[name='controlValue']").val(obj.val());
	}
	if(obj.text()){
		if(obj[0].tagName && obj[0].tagName.toLowerCase() == "textarea")
			form.find("input[name='controlText']").val(obj.val());
		else
			form.find("input[name='controlText']").val(obj.text());
	}
	if(obj.attr("placeholder")){
		form.find("input[name='controlPlaceholder']").val(obj.attr("placeholder"));
	}
	if(obj.attr("macrosType")){//宏类型
		form.find("select[name='controlMacros']").val(obj.attr("macrosType"));
	}
	if(obj.attr("type")){//控件类型
		form.find("select[name='controlDataType']").val(obj.attr("type"));
	}
	if(obj.attr("defaultValue")){//默认值
		form.find("input[name='controlDefaultValue']").val(obj.attr("defaultValue"));
	}
	if(obj.css("textAlign")){//对齐方式
		var align = obj.css("textAlign");
		if(align == "start")
			align = "left";
		form.find("select[name='controlAlign']").val(align);
	}
	if(_getTable(obj[0])){
		form.find("input[name='controlTableRows']").val(_getTable(obj[0]).find("tr").length);
	}
	if(_getTable(obj[0])){
		form.find("input[name='controlTableCols']").val(_getTable(obj[0]).find("tr:last td").length);
	}
	if(obj.css("color")){//字体颜色
		form.find("input[name='controlFontColor']").val(rgb2hex(obj.css("color")));
	}
	if(obj.attr("class")){//样式
		form.find("input[name='controlClass']").val(obj.attr("class").replace("selected",""));
	}
	if(obj.css("width")){//宽度
		form.find("input[name='controlWidth']").val(obj.css("width"));
	}
	if(obj.css("height")){//高度
		form.find("input[name='controlHeight']").val(obj.css("height"));
	}
	//必填项
	if(obj.attr("data-required") == "true"){
		form.find("select[name='controlRequired']").val("true");
	}else{
		form.find("select[name='controlRequired']").val("false");
	}
}
// 属性表单设置控件事件设置
function initPropertyForm() {
	$("#propertyForm1 input,textarea").bind("keyup", function(e) {
		_initPropertyForm(this.name, $(this).val());
	});
	$("#propertyForm1 select").bind("change", function(e) {
		_initPropertyForm(this.name, $(this).val());
	});
	$("#propertyForm2 input").bind("keyup", function(e) {
		_initPropertyForm2(this.name, $(this).val());
	});
	$("#propertyForm2 select").bind("change", function(e) {
		_initPropertyForm2(this.name, $(this).val());
	});
	// //设置属性编辑器滚动条
	// $("#propertyForm1,#propertyForm2").slimScroll({
	// 	height:($(document).height()-100)+"px"
	// });
}
//表单属性设置生效
function _initPropertyForm(name, value){
	var selecteds = $(".design");
	if (selecteds.length > 0) {
		switch (name) {
			case "formTitle":// 表单标题，对应h4
				selecteds.find("h4").text(value);
				break;
			case "formFontSize":// 表单字体大小
				selecteds.css("fontSize", value);
				break;
			case "formFontColor":// 表单字体颜色
				selecteds.css("color", value);
				break;
			case "formWidth":// 表单宽度
				selecteds.css("width", value);
				break;
			case "formClass":// 表单样式
				selecteds.attr("class", "design design-item "+value);
				break;
			case "formBgColor":// 表单背景色
				selecteds.css("backgroundColor",value);
				break;
			case "formTip":// 表单完成提示
				selecteds.attr("tip",value);
				break;
		}
	}
}
//控件属性表单设置生效
function _initPropertyForm2(name, value) {
	var selecteds = $(".design .selected");
	if (selecteds.length > 0) {
		switch (name) {
		case "controlName":// 控件名
			selecteds.attr("name", value);
			break;
		case "controlValue":// 控件值
			selecteds.val(value);
			break;
		case "controlText":// 显示文本
			selecteds.text(value);
			break;
		case "controlPlaceholder":// 提示文本呢
			selecteds.attr("placeholder", value);
			break;
		case "controlMacros":// 提示文本呢
			selecteds.attr("macrosType", value);
			break;
		case "controlDataType":// 数据类型
			selecteds.attr("type", value);
			break;
		case "controlDefaultValue":// 默认值，值不为空时，自动填充defaultValue
			selecteds.attr("defaultValue", value);
			if (selecteds.val().length == 0)
				selecteds.val(value);
			break;
		case "controlAlign":// 对齐方式
			selecteds.css("textAlign", value);
			break;
		case "controlTableRows":// 表格行数
			for(var i=0;i<selecteds.length;i++){
				var table = _getTable(selecteds[i]);
				var rows = table.find("tr").length;
				value = parseInt(value);
				if(rows<value){//增加行
					for(var j=0;j<value - rows;j++){
						insertRow(table);
					}
				}else if(rows>value){//减少行
					for(var j=0;j<rows - value;j++){
						removeRow(table);
					}
				}
			}
			break;
		case "controlTableCols":// 表格列数
			for(var i=0;i<selecteds.length;i++){
				var table = _getTable(selecteds[i]);
				var cols = table.find("tr:last td").length;
				value = parseInt(value);
				if(cols<value){//增加列
					for(var j=0;j<value - cols;j++){
						insertCol(table);
					}
				}else if(cols>value){//减少列
					for(var j=0;j<cols - value;j++){
						removeCol(table);
					}
				}
			}
			break;
		case "controlFontColor":
			selecteds.css("color", value);
			break;
		case "controlClass":
			selecteds.attr("class","selected "+value);
			break;
		case "controlWidth":
			selecteds.css("width", parseInt(value) + "px");
			break;
		case "controlHeight":
			selecteds.css("height", parseInt(value) + "px");
			break;
		case "controlRequired":
			if(value == "true")//必需
				selecteds.attr("data-required","true");
			else
				selecteds.removeAttr("data-required");
			break;
		}
	}
}
//清除参数
function clearProperty() {
	$("#propertyForm2 input").val("");
	$("#propertyForm2 div[with!='*']").hide();
}
// 清除所有选中
function clearSelected() {
	$("#propertyForm2 input").val("");
	$("#propertyForm2 div[with!='*']").hide();
	$(".design *").removeClass("selected");
}
// 颜色值转换
function rgb2hex(rgb) {
	rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/);
	function hex(x) {
		return ("0" + parseInt(x).toString(16)).slice(-2).toUpperCase();
	}
	return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]).toUpperCase();
}