ns.ready(function(){
	ns.form.markdown = {
			init : function(){
				ns.requireCSS("/framework/plugins/bootstrap-markdown/css/bootstrap-markdown.min.css");
				ns.requireJS("/framework/plugins/bootstrap-markdown/js/bootstrap-markdown.js");
				ns.requireJS("/framework/plugins/bootstrap-markdown/js/bootstrap-markdown.zh.js");
			}
	};
	try{
		ns.form.markdown.init();
	}catch(e){
		alert("请引入markdown组件！");
	}
});