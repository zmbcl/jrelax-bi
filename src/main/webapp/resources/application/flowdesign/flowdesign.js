var instance;
var cseqid;//当前选择的连接线ID
var currentMousePos;
jsPlumb.ready(function(){
	//实时获取鼠标位置
	$(document).on("mousemove", function(e){
		e = e||window.event;
		if(e.pageX || e.pageY){ 
			currentMousePos = {x:e.pageX, y:e.pageY}; 
		}else{
			currentMousePos = { 
					x:e.clientX + document.body.scrollLeft - document.body.clientLeft, 
					y:e.clientY + document.body.scrollTop - document.body.clientTop 
			}; 
		}
		currentMousePos.x = currentMousePos.x - $(".layout aside:first").width();
	});
	//配置滚动条
	$(".form-horizontal").slimScroll({
		height : "150px"
	});
	//配置拖曳事件
	$(".flow-element").dragg();
	var content;
	// 开始拖动
	$(document).on('dragstart', '.flow-element', function(e) {
		content = $(this);
	});
	// 拖动过程中
	$(document).on('drag', '#helper', function(e) {
		$(this).css('opacity', 0.5);
	});
	// 拖进指定区域
	$(document).on('dragin', '.main-content .wrapper', function(e) {
		$(this).addClass("bg-default");
	});
	// 拖出指定区域
	$(document).on('dragout', '.main-content .wrapper', function(e) {
		$(this).removeClass("bg-default");
	});
	// 拖动结束
	$(document).on('drop', '.main-content .wrapper', function(e) {
		if($(e.target).attr("class").indexOf("flow-item")>=0)
			return false;
		var element = $(content).parent().next();
		element = element.clone().children();
		element.addClass("flow-item");
		element.append("<div class='ep'></div>");
		element.attr("id", new Date().getTime());
		element.css("left", currentMousePos.x);
		element.css("top", currentMousePos.y);
		$(this).append(element);
		$(this).removeClass("bg-default");
		bindEvents();// 绑定点击事件
		return false;
	});
	// 删除事件
	$(document).bind("keyup", function(e) {
		if (e.keyCode == 46) {
			removeElement();
		}
		_cache_redo = false;
	});
	//选中事件
	$(".main-content .wrapper").bind("click", function() {
		clearSelected();
	});
	//配置连线
	instance = jsPlumb.getInstance({
		Connector : [ "Straight", { curviness:50 } ],
		Anchors : [ "RightMiddle", "LeftMiddle"],
		Endpoint : ["Blank", {radius:20}],
		HoverPaintStyle : {strokeStyle:"#15db81", lineWidth:4 },
		DragOptions : { cursor: 'pointer', zIndex:2000 },
		ConnectionOverlays : [
			[ "Arrow", { location:1 } ],
			[ "Label", { 
				location:0.1,
				id:"label",
				cssClass:"aLabel"
			}]
		]
	});
	//bindEvents();
	//初始化配置显示
	clearProperty();
	initPropertyEvent();
	//防止无意刷新
	$(window).bind('beforeunload',function(){
		//return '您输入的内容尚未保存，确定离开此页面吗？';
	});
});
//绑定事件
function bindEvents(){
	instance.draggable($(".flow-item"), {});
	$(".flow-item").each(function() {
		$(this).unbind("click");
		$(this).bind("click", function(e) {
			var ele = $(this);
			if (!e.ctrlKey) {
				clearSelected();
			}
			initProperty(this);
			ele.addClass("selected");
			return false;
		});
	});
	//连线
	instance.doWhileSuspended(function() {
		var isFilterSupported = instance.isDragFilterSupported();
		if (isFilterSupported) {
			instance.makeSource($(".flow-item"), {
				filter:".ep",
				anchor:"Continuous",
				//connector:[ "Bezier", { curviness:50 } ],
				connectorStyle:{ strokeStyle:"#5c96bc", lineWidth:4, outlineColor:"transparent", outlineWidth:4 },
				maxConnections:5,
				onMaxConnections:function(info, e) {
					alert("Maximum connections (" + info.maxConnections + ") reached");
				}
			});
		}
		else {
			var eps = jsPlumb.getSelector(".ep");
			for (var i = 0; i < eps.length; i++) {
				var e = eps[i], p = e.parentNode;
				instance.makeSource(e, {
					parent:p,
					anchor:"Continuous",
					//connector:[ "Bezier", { curviness:50 } ],
					connectorStyle:{ strokeStyle:"#5c96bc",lineWidth:2, outlineColor:"transparent", outlineWidth:4 },
					maxConnections:5,
					onMaxConnections:function(info, e) {
						alert("Maximum connections (" + info.maxConnections + ") reached");
					}
				});
			}
		}
	});
	instance.makeTarget($(".flow-item"), {
		dropOptions:{ hoverClass:"dragHover" },
		anchor:"Continuous",
		allowLoopback:true
	});
	//Ctrl+单击删除连线
	instance.bind("click", function(c,e) {
		if(e.ctrlKey){
			instance.detach(c);
		}
		//读取参数
		cseqid = c.getId();
		if($(".seq div[cid='"+cseqid+"']").length == 0){
			$(".seq").append("<div cid='"+cseqid+"'></div>");
		}
		initProperty($(".seq div[cid='"+cseqid+"']"), "sequenceFlow");//初始化参数
		return false;
	});
}
//删除选中
function removeElement() {
	$(".main-content .wrapper .selected").remove();
}
//读取参数
function initProperty(obj,_t){
	obj = $(obj);
	//初始化控件显示
	var t = _t || obj.attr("t") || obj.parents("[t]").attr("t");
	if (t) {
		$(".tab-content .form-group[with!='*'],.tab-content form[with][with!='*']").hide();
		$(".tab-content .form-group[with*='" + t + "'],.tab-content form[with][with*='" + t + "']").show();
	}
	$(".tab-content input,.tab-content select,.tab-content textarea").each(function(){
		$(".tab-content input[name='"+this.name+"']").val(obj.attr(this.name));
		$(".tab-content textarea[name='"+this.name+"']").val(obj.attr(this.name));
		$(".tab-content select[name='"+this.name+"']").val(obj.attr(this.name));
	});
}
//设置参数
function initPropertyEvent(){
	$(".tab-content .form-group input,.tab-content .form-group textarea").bind("keyup", function(){
		var obj = $(this);
		_initPropertyEvent(this.name, obj.val());
	});
	$(".tab-content .form-group select,.tab-content .form-group input[type='checkbox']").bind("change", function(){
		var obj = $(this);
		if(this.type=="checkbox")
			_initPropertyEvent(this.name, obj.is(":checked")+"");
		else
			_initPropertyEvent(this.name, obj.val());
	});
}
function _initPropertyEvent(name,value){
	//设置连接线参数
	if(cseqid){//如果当前选择的是连接线，则设置连接线的参数
		$(".seq div[cid='"+cseqid+"']").attr(name, value);
		return;
	}
	var selecteds = $(".main-content .wrapper .selected");
	if(selecteds.length>0){
		var sel = $(selecteds[0]);
		if(value.length>0)
			sel.attr(name,value);
		else
			sel.removeAttr(name);
		
		if(name == "name"){//修改显示名称
			sel.find("span").text(value);
		}
	}
}
//清除所有选中
function clearSelected() {
	clearProperty();
	$(".flow-item").removeClass("selected");
}
//清除参数
function clearProperty() {
	$(".tab-content .form-group input").val("");
	$(".tab-content .form-group textarea").val("");
	$(".tab-content .form-group select").val("");
	$(".tab-content .form-group[with!='*'],.tab-content form[with][with!='*']").hide();
	cseqid = undefined;
}
function addLink(){
	
}