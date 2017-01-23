/**
 * 表单自定义-核心js
 * author 曾超 
 * 依赖：jQuery bootstrap json2
 */
fd.design = {
	view : {//视图组件
		$currentView : undefined,
		$currentViews : [],//选择的视图集合
		currentView : function(){//当前操作的视图
			return fd.design.view.$currentView || $(fd.config.viewCurrentTag+":eq(0)");
		},
		currentViews : function(){//当前操作的视图集合
			return fd.design.view.$currentViews || $(fd.config.viewCurrentTag);
		},
		setCurrentView : function(view){
			if(view){
				fd.design.view.$currentView = view;
				fd.design.view.setCurrentViews([]);
				fd.design.view.addCurrentView(view);
			}
		},
		addCurrentView : function(view){
			if(view) fd.design.view.$currentViews.push(view);
		},
		setCurrentViews : function(views){
			if(views) fd.design.view.$currentViews = views;
		}
	},
	properties : {//属性组件
		hideAll : function(){//隐藏所有控件
			$(fd.config.propertiesPanel + " ["+fd.config.propertiesTag+"]").addClass("hide");
			//关闭无子项的选项卡
			$("#pro_content2 .panel").each(function(i, panel){
				panel = $(panel);
				var len = panel.find("[fd-property]:not(.hide)").length;
				if(len == 0)
					panel.addClass("hide");
				else
					panel.removeClass("hide");
			});
		},
		get : function(name){//获取控件
			return $(fd.config.propertiesPanel + " ["+fd.config.propertiesTag+"='"+name+"']");
		},
		hide : function(name){
			fd.design.properties.get(name).addClass("hide");
		},
		show : function(name){
			fd.design.properties.get(name).removeClass("hide");
		},
		open : function(cView){
			cView = cView || fd.design.view.currentView();//设置当前视图
			if(!cView.attr(fd.config.viewTag)) return false;//确保是视图组件
			var viewName = jQuery.trim(cView.attr(fd.config.viewTag));
			cView.attr(fd.config.viewTag, viewName);
			var view = fd.config.view[viewName];//视图配置
			fd.design.properties.hideAll();
			$.each(view.properties, function(i, n){
				var prop = fd.config.properties[n];
				if(prop){
					fd.design.properties.show(n);
					//初始化方法
					var control = fd.design.properties.get(n);
					var opt = fd.design.util.opt(control, prop, cView);
					
					prop.events.init(opt);
				}
			});
			//关闭无子项的选项卡
			$("#pro_content2 .panel").each(function(i, panel){
				panel = $(panel);
				var len = panel.find("[fd-property]:not(.hide)").length;
				if(len == 0)
					panel.addClass("hide");
				else
					panel.removeClass("hide");
			});
		}
	},
	init : function(){//属性编辑器初始化
		//#1 初始化拖拽
		fd.design.drag_view_content = undefined;
		$(fd.config.viewDragTag).dragg();
		var content;
		// 开始拖动
		$(document).on('dragstart', fd.config.viewDragTag, function(e) {
			content = $(this);
		});
		// 拖动过程中
		$(document).on('drag', 'clone', function(e, ui) {
			$(this).css('opacity', 0.5);
		});
		// 拖进指定区域
		$(document).on('dragin', fd.config.viewDragInTag, function(e) {
			$(this).addClass("bg-default");
		});
		// 拖出指定区域
		$(document).on('dragout', fd.config.viewDragInTag, function(e) {
			$(this).removeClass("bg-default");
		});
		// 拖动结束
		$(document).on('drop', fd.config.viewDragInTag, function(e) {
			if(fd.design.drag_view_content && fd.design.dragmode == true){
				var view = fd.design.drag_view_content.clone();
				$(this).append(view);
				$(this).removeClass("bg-default");
				fd.design.bindViewEvent(view);// 绑定视图触发属性事件
				
				fd.design.drag_view_content.remove();
				fd.design.drag_view_content = undefined;
				fd.design.disabledrag(1, 2, view);
				fd.design.enabledrag(1, 2, view);
			}else{
				var element = $(content).parent().next();
				var view = element.clone().children();
				$(this).append(view);
				$(this).removeClass("bg-default");
				fd.design.bindViewEvent(view);// 绑定视图触发属性事件
			}
			
			return false;
		});
		//#2 初始化属性控件事件
		$(fd.config.propertiesPanel + " " + fd.config.supportType).each(function(){
			var proptype = $(this).parent().attr(fd.config.propertiesTag);
			var prop = fd.config.properties[proptype];
			if(!prop) return;
			var property = $(this);
			$.each(prop.events, function(i, event){
				if(i.length > 1 && i.substr(0,2) == "on"){
					property.bind(i.substr(2), function(){
						var opt = fd.design.util.opt($(this), prop);
						event(opt);
						opt.data.save();//保存属性值
					});
				}
			});
		});
		$(fd.config.propertiesPanel + " .colorPicker").colorpicker();
		//#3 初始化视图组件事件，用来触发属性面板
		fd.design.bindViewEvent();
		//#4 初始化表单视图面板事件，点击表单视图，切换到表单属性选项卡
		$(fd.config.containerPanel).bind("click", function(){
			fd.design.unselecteAllView();
			$(this).addClass(fd.config.viewSelectedClass);
			$("#propertyTab a:first").tab("show");
		});
		//#5 增加删除按钮事件监听
		$(document).bind("keydown", function(e){
			if(e.keyCode == 46) return fd.design.remove();
		});
		
		//#6 美化
		//设置属性编辑器滚动条
		// $(fd.config.propertiesPanel).slimScroll({
		// 	height:($(document).height()-100)+"px"
		// });
		//隐藏所有属性，点击后出现
		fd.design.properties.hideAll();
	},
	bindViewEvent : function($views){
		if($views){
			if(!$views.length)
				$views = [$views];
			$.each($views, function(i, $views){
				var childViews = $($views).find("["+fd.config.viewTag+"]");//获取下属子试图
				$views = [$($views)];
				//初始化子视图
				$views.push(childViews);
				$.each($views, function(i,$view){
					$view = $($view);
					var view = fd.config.view[$view.attr(fd.config.viewTag)];
					if(view) if(view.events && view.events.init) view.events.init($view);
					fd.design._bindViewEvent($view);
				});
				//fd.design._bindViewEvent($view.find("["+fd.config.viewTag+"]"));
			});
		}else{
			$(fd.config.containerPanel+" ["+fd.config.viewTag+"]").each(function() {
				if($(this).attr("editable") != "false"){
					var view = fd.config.view[$(this).attr(fd.config.viewTag)];
					if(view) if(view.events && view.events.init) view.events.init($(this));
					fd.design._bindViewEvent($(this));
				}
			});
		}
	},
	_bindViewEvent : function(view){//内部方法
		view.unbind("click");
		view.bind("click", function(e) {
			if (e.ctrlKey) {// @TODO 多选操作
				fd.design.view.addCurrentView($(this));
				fd.design.selectViews();
			}else if(e.altKey){//选择父容器
                fd.design.selectView($(this).parents("["+fd.config.viewTag+"][id]"));
			} else{
				fd.design.selectView($(this))
			}
			return false;
		});
	},
	disabledrag : function(btn1, btn2, $view){
		if($view) $view = [$view];
		fd.design.dragmode = false;
		fd.design.drag_view_content = undefined;
		$(btn1).removeClass("hide");
		$(btn2).addClass("hide");
		
		$(fd.config.containerPanel+" ["+fd.config.viewTag+"]").each(function(i, view){
			view = $(view);
			view.off('mousedown');
		});
		$(fd.config.containerPanel+" ["+fd.config.moveTag+"]").removeClass("move");
	},
	enabledrag : function(btn1, btn2, $view){
		if($view) $view = [$view];
		fd.design.dragmode = true;
		$(btn1).addClass("hide");
		$(btn2).removeClass("hide");
		$(fd.config.containerPanel+" ["+fd.config.viewTag+"]").each(function(i, view){
			view = $(view);
			view.dragg();
			view.on('dragstart', view, function(e) {
				if(!fd.design.drag_view_content)
					fd.design.drag_view_content = $(this);
			});
			view.on('mousedown');
		});
		$(fd.config.containerPanel+" ["+fd.config.moveTag+"]").addClass("move");
	},
	editMode : function(target){//源码编辑模式
		var modal = $(target);
		var textarea = modal.find("textarea");
		textarea.height($(document).height() * 0.6);//设置textarea的高度
		var html = $(fd.config.containerPanel).html();
		//html = html_beautify(html);//代码格式化
        textarea.html(html);// 设置显示的html代码
		
		modal.find("#btnOk").unbind("click");
		modal.find("#btnOk").bind("click", function(e){
			var textarea = modal.find("textarea");
			var newHtml = html_beautify(textarea.val());
			$(fd.config.containerPanel).html(newHtml);
			//重新绑定事件
			fd.design.bindViewEvent();
			modal.modal("hide");
		});
		modal.modal("show");
	},
	editScript : function(target){//脚本编辑模式 
		return alert("功能未开放！");
		var modal = $(target);
		var textarea = modal.find("textarea");
		textarea.height($(document).height() * 0.6);//设置textarea的高度
		var html = $(fd.config.containerPanel + " #script").html();
		textarea.html(html);// 设置显示的html代码
		
		modal.find("#btnOk").unbind("click");
		modal.find("#btnOk").bind("click", function(e){
			var textarea = modal.find("textarea");
			//测试脚本
			try {
				var newHtml = textarea.val();
				eval(newHtml);
				$(fd.config.containerPanel + " #script").html(newHtml);
				modal.modal("hide");
			} catch (e) {
				alert("脚本有错误！");
			}
			
		});
		modal.modal("show");
	},
	move : function(arrow){//移动
		var view = fd.design.view.currentView();
		if(!view[0]) return alert("请先选择要移动的组件！");
		if(arrow == 'up'){
			view = $(view[0]);
			var prevView = view.prev();
			if(prevView[0]){
				prevView.before(view);
			}
		}else if(arrow == 'down'){
			view = $(view[0]);
			var nextView = view.next();
			if(nextView[0]){
				nextView.after(view);
			}
		}
	},
	selectView : function(view){//选中视图
		fd.design.unselecteAllView();
		
		fd.design.properties.open(view);
		fd.design.view.setCurrentView(view);
		view.addClass(fd.config.viewSelectedClass);//增加选中样式
		view.addClass(fd.config.viewCurrentTag.replace(".",""));//增加当前视图标识
		$("#propertyTab a:last").tab("show");
	},
	selectViews : function(views){
		views = views || fd.design.view.currentViews();
		$.each(views, function(i, view){
			fd.design.properties.open(view);
			if(!fd.design.view.currentView() || fd.design.view.currentView().length == 0)
				fd.design.view.setCurrentView(view);
			view.addClass(fd.config.viewSelectedClass);//增加选中样式
			view.addClass(fd.config.viewCurrentTag.replace(".",""));//增加当前视图标识
		});
		$("#propertyTab a:last").tab("show");
	},
	unselecteAllView : function(){//清除所有选中的view
		$(fd.config.viewCurrentTag).removeClass(fd.config.viewCurrentTag.replace(".",""));//移除当前视图标识
		$("."+fd.config.viewSelectedClass).removeClass(fd.config.viewSelectedClass);//移除选中样式
		//清理内存数据
		fd.design.view.setCurrentView(undefined);
		fd.design.view.setCurrentViews([]);
		fd.design.properties.hideAll();
	},
	table : {
		merge : function(){
			var selecteds = fd.design.view.currentViews();
			if (selecteds.length < 2) {
				alert("选中2个单元格以上才可以合并！\n（按住Ctrl可以多选）");
				return;
			}
			$.each(selecteds, function(i, item) {
				if (!item.is("td")) {
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
			//fd.design.bindViewEvent(newTr);
			fd.design.unselecteAllView();
		},
		insertRow : function(arrow){
			var selecteds = fd.design.view.currentView();
			if (selecteds.length <= 0) {
				alert("请先选中单元格！");
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
				var newTr = $(tr.clone());
				newTr.find("."+fd.config.viewSelectedClass).removeClass(fd.config.viewSelectedClass);
				if(arrow == "down")
					tr = newTr.insertAfter(tr);
				else
					tr = newTr.insertBefore(tr);
				tr.find("td").removeClass("selected");
				tr.find("td").text("");
			}
			fd.design.bindViewEvent(newTr);
		},
		insertCol : function(arrow){
			var selecteds = fd.design.view.currentView();
			if (selecteds.length <= 0) {
				alert("先选中单元格！");
				return;
			}
			var tagName = selecteds[0].tagName.toLowerCase();
			var newTds = [];
			switch (tagName) {
			case "td":
				var index = $(selecteds[0]).index();
				var table = $(selecteds[0]).parents("table");
				table.find("tr").each(function() {
					var td = $(this).find("td:eq(" + index + ")");
					var newTd = $(td.clone());
					newTd.removeClass(fd.config.viewSelectedClass);
					if(arrow == "right")
						td = newTd.insertAfter(td);
					else
						td = newTd.insertBefore(td);
					td.removeClass("selected");
					td.text("");
					
					newTds.push(newTd);
				});
				break;
			case "tr":
				var table = $(selecteds[0]).parents("table");
				table.find("tr").each(function() {
					var td = $(this).find("td:first");
					var newTd = $(td.clone());
					newTd.removeClass(fd.config.viewSelectedClass);
					if(arrow == "right")
						td = newTd.insertAfter(td);
					else
						td = newTd.insertBefore(td);
					td.removeClass("selected");
					td.text("");
					
					newTds.push(newTd);
				});
				break;
			}
			fd.design.bindViewEvent(newTds);
		}
	},
	remove : function(){
		var element = $(fd.config.viewCurrentTag);
		if(element.parent().is("tr") && element.parent().children().length == 0)//如果tr下已经没有td，则删除该tr
			element.parent().remove();
		else
			element.remove();
		fd.design.properties.hideAll();
	},
	redo : function(){//重做
		ns.tip.confirm("将会清空当前的内容并无法恢复，确定要重做吗？", function(){
			//进行一下清理工作
			fd.design.view.setCurrentView(undefined);
			fd.design.view.setCurrentViews([]);
			fd.design.unselecteAllView();
			
			$(fd.config.containerPanel).html("");
		});
	},
	_html : function(){//处理HTML
		var panel = $(fd.config.containerPanel).clone();//复制
		panel.find("[data]").removeAttr("data");//移除data属性
		var html = panel[0].outerHTML;
		return html;
	},
	preview : function(){
		var html = fd.design._html();
		var form = $("#previewForm");
		form.find("textarea").html(html);
		form.submit();
	},
	save : function(callback){
		fd.design.unselecteAllView();
		//暂时调用design.html页面上的saveForm方法
		saveForm(callback);
	},
	saveAndPreview : function(){
		fd.design.save(function(){
			preview();
		})
	},
	showProperties : function(obj, target, panel){//显示属性面板
		$(panel).removeClass("hide");
		$(obj).addClass("hide");
		$(target).removeClass("hide");
	},
	hideProperties : function(obj, target, panel){//隐藏属性面板
		$(panel).addClass("hide");
		$(obj).addClass("hide");
		$(target).removeClass("hide");
	},
	util : {//工具类
		data : function(view){//获取view视图的data属性，save方法保存
			view = view || fd.design.view.currentView();
			var data = view.attr("data");
			if(!data) 
				data = {};
			else{
				data = data.replace(new RegExp("'",'gm'),'"');
				data = JSON.parse(data);
			}
			data.save = function(){
				var cview = fd.design.view.currentView();
				cview.attr("data", JSON.stringify(data));
			};
			return data;
		},
		opt : function(control, property, view){//生成事件传递参数，control：属性视图控件，prop:视图配置
			var opt = {
				control : control,//属性控件
				property : property,//属性控件配置参数
				view : view || fd.design.view.currentView(),//view视图控件
				data : fd.design.util.data(view || fd.design.view.currentView())//view视图数据
			};
			return opt;
		},
		rgb2hex : function(rgb) {// 颜色值转换
			rgb = rgb.match(/^rgb\((\d+),\s*(\d+),\s*(\d+)\)$/) || rgb.match(/^rgba\((\d+),\s*(\d+),\s*(\d+),\s*(\d+)\)$/);
			function hex(x) {
				return ("0" + parseInt(x).toString(16)).slice(-2).toUpperCase();
			}
			return "#" + hex(rgb[1]) + hex(rgb[2]) + hex(rgb[3]).toUpperCase();
		}
	}
};