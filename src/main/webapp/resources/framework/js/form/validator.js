ns.ready(function(){
	ns.form.validator = {
			init : function(){
				ns.requireJS("/framework/plugins/parsley/parsley.min.js");
				ns.requireJS("/framework/plugins/parsley/parsley.zh_cn.js");

				//如果想要改变异常提示的方向，在验证节点上配置 data-parsley-placement = "left|right|top|bottom"
			}
	};
	try{
		ns.form.validator.init();
	}catch(e){
		alert("请引入parsley组件！");
	}
});