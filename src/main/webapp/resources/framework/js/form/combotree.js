ns.ready(function(){
	ns.form.combotree = {
			init : function(){
				//引入必要的样式+JS文件
				ns.requireJS("/framework/js/view/tree.js");
				ns.requireCSS("/framework/plugins/combotree/combotree.css");
				ns.requireJS("/framework/plugins/combotree/combotree.js");
			}
	};
	try{
		ns.form.combotree.init();
	}catch(e){
		alert("请引入Combotree组件！");
	}
});
