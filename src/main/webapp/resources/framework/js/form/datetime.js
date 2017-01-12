ns.ready(function(){
	ns.form.dateTimePicker = {
			init : function(){
				if (!$.isFunction($.fn.datetimepicker)) {
					//引入必要的样式+JS文件
					ns.requireCSS("/framework/plugins/datetimepicker/css/bootstrap-datetimepicker.min.css");
					ns.requireJS("/framework/plugins/datetimepicker/js/bootstrap-datetimepicker.min.js");
					ns.requireJS("/framework/plugins/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js");
				}
				ns.form.initDateTimePicker = function(obj){//初始化控件
					if ($.isFunction($.fn.datetimepicker)) {
						var options = {
							format : "yyyy-mm-dd hh:mm:ss",
							autoclose : true,
							todayBtn : true,
							todayHighlight : true,
							language : "zh-CN"
						}
		                if (obj)
		                    $(obj).datetimepicker(options);
		                else
		                    $(".datetime,[data-datetime]").datetimepicker(options);
		            }
				};
				ns.form.initDateTimePicker();
			}
	};
	try{
		ns.form.dateTimePicker.init();
	}catch(e){
		alert("请引入Bootstrap.DateTimePicker组件！");
	}
});