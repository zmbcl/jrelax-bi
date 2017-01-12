ns.ready(function(){
	ns.view.datatables = {
			init : function(){
				//引入必要的样式+JS文件
				ns.requireCSS("/framework/plugins/datatables/jquery.dataTables.css");
				ns.requireJS("/framework/plugins/datatables/jquery.dataTables.js");
			}
	};
	try{
		ns.view.datatables.init();
	}catch(e){
		alert("请引入DataTables组件！");
	}
});
