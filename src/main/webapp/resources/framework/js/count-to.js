ns.ready(function(){
	ns.countTo = {
			init : function(){
				//引入必要的样式+JS文件
				$("body").append("<script src=\""+ns.getBasePath()+"/framework/plugins/count-to/jquery.countTo.js\"></script>");
				if (!$.browser.mobile && $.fn.appear) {
		            $(".count").appear();
		            $(".count").on("appear", function () {
		                if (!$(this).hasClass("done")) {
		                    var speed = $(this).data("speed") || 2000,
		                        interval = $(this).data("interval") || 100;
		                    $(this).addClass("done").countTo({
		                        speed: speed,
		                        refreshInterval: interval
		                    });
		                }
		            });
		        } else {
		            $(".count").each(function () {
		                if (!$(this).hasClass("done")) {
		                    $(this).addClass("done").countTo({
		                        speed: 1000
		                    });
		                }
		            });
		        }
			}
	};
	try{
		ns.countTo.init();
	}catch(e){
		alert("请引入jquery.countTo组件！"+e);
	}
});