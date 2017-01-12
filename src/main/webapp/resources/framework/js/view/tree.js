ns.ready(function(){
	ns.view.tree = {
			init : function(){
				//引入必要的样式+JS文件
				ns.requireCSS("/framework/plugins/jstree/themes/default/style.min.css");
				ns.requireJS("/framework/plugins/jstree/jstree.min.js");
			}
	};
	try{
		ns.view.tree.init();
	}catch(e){
		alert("请引入JSTree组件！");
	}
});
