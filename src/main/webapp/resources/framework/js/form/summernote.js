ns.ready(function(){
	ns.form.summernote = {
			init : function(){
				ns.requireCSS("/framework/plugins/summernote/summernote.css");
				ns.requireJS("/framework/plugins/summernote/summernote.min.js");
				ns.requireJS("/framework/plugins/summernote/summernote-zh-CN.js");

				if(console)
					console.log("请在页面上自行初始化,$('').summernote(options)");
			}
	};
	try{
		ns.form.summernote.init();
	}catch(e){
		alert("请引入Summernote组件！");
	}
});