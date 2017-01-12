ns.ready(function(){
	ns.form.select = {
			init : function(){
				if (!$.isFunction($.fn.chosen)) {
					ns.requireCSS("/framework/plugins/chosen/chosen.min.css");
					ns.requireJS("/framework/plugins/chosen/chosen.jquery.min.js");
				}
				ns.form.initChosen = function(obj){
					if ($.isFunction($.fn.chosen)) {
						var arr = [];
		                if (obj)
		                	arr.push($(obj));
		                else
		                	arr = $(".chosen,.select,[data-select]");
						$.each(arr, function(i,n){
							var el = $(n);
							var w = (el.attr("style") && el.attr("style").indexOf("width") >= 0)?el.css("width"):"100%";
							el.chosen({
								no_results_text: "没有结果匹配",
								placeholder_text_multiple:"请选择...",
								placeholder_text_single:"请选择...",
								disable_search_threshold: 10, //少于10个不显示搜索框
								width:w
							});

							//表单reset后同步更新显示
							el.parents("form").bind("reset", function(){
								setTimeout(function(){
									el.trigger("chosen:updated");
								},50);
							});
						});
		            }
				};
				ns.form.initChosen();
			}
	};
	try{
		ns.form.select.init();
	}catch(e){
		alert("请引入chosen组件！"+e);
	}
});