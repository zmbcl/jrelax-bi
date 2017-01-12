var Toast = {
		success : function(msg, title, fn){
			if(!title)
				title = "成功";
			if(fn){
				top.toastr.options.onclick = fn;
			}
			if(typeof(title) == "function"){
				fn = title;
				title = "成功";
				top.toastr.options.onclick = fn;
			}
			top.toastr["success"](msg);
		},
		info : function(msg, title, fn){
			if(!title)
				title = "提示";
			if(fn){
				top.toastr.options.onclick = fn;
			}
			if(typeof(title) == "function"){
				fn = title;
				title = "提示";
				top.toastr.options.onclick = fn;
			}
			top.toastr["info"](msg);
		},
		warning : function(msg, title, fn){
			if(!title)
				title = "警告";
			if(fn){
				top.toastr.options.onclick = fn;
			}
			if(typeof(title) == "function"){
				fn = title;
				title = "警告";
				top.toastr.options.onclick = fn;
			}
			top.toastr["warning"](msg);
		},
		error : function(msg, title, fn){
			if(!title)
				title = "错误";
			if(fn){
				top.toastr.options.onclick = fn;
			}
			if(typeof(title) == "function"){
				fn = title;
				title = "错误";
				top.toastr.options.onclick = fn;
			}
			top.toastr["error"](msg);
		},
		init : function(){
			//引入必要的样式+JS文件
			top.ns.requireCSS("/framework/plugins/toastr/toastr.min.css");
			top.ns.requireJS("/framework/plugins/toastr/toastr.min.js");
			top.toastr.options = {
				closeButton : false,
				debug : false,
				positionClass : "toast-top-right",
				onclick : null,
				showDuration : 300,
				hideDuration : 300,
				timeOut : 3000,
				extendedTimeOut : 1000,
				showEasing : 'swing',
				hideEasing : 'linear',
				showMethod : 'show',
				hideMethod : 'hide'
			};
		}
};
ns.ready(function(){
	try{
		ns.tip.toast = Toast;
		ns.tip.toast.init();
	}catch(e){
		alert("请引入plugins/toastr/toastr.min.js");
	}
});