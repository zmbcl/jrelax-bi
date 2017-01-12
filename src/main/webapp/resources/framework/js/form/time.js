ns.ready(function(){
	ns.form.timePicker = {
			init : function(){
				if (!$.isFunction($.fn.timepicker)) {
					ns.requireCSS("/framework/plugins/timepicker/jquery.timepicker.css");
					ns.requireJS("/framework/plugins/timepicker/jquery.timepicker.min.js");
				}
				ns.form.initTimePicker = function(obj){//初始化控件
					if ($.isFunction($.fn.timepicker)) {
		                if (obj)
		                    $(obj).timepicker();
		                else{
		                	$(".time,[data-time]").timepicker({
		                    	lang:{am:"上午", pm:"下午"},
		                    	show2400:true,
		                    	timeFormat:"H:i"
		                    });
		                }
		                    
		            }
				};
				ns.form.initTimePicker();
			}
	};
	try{
		ns.form.timePicker.init();
	}catch(e){
		alert("请引入Bootstrap.DateTimePicker组件！");
	}
});