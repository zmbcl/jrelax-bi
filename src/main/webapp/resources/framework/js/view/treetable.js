ns.ready(function(){
	ns.view.treeTable = {
			init : function(){
				ns.requireCSS("/framework/plugins/treetable/jquery.treetable.css");
				ns.requireJS("/framework/plugins/treetable/jquery.treetable.js");
			}
	};
	try{
		ns.view.treeTable.init();
	}catch(e){
		alert("请引入TreeTable组件！");
	}
});
