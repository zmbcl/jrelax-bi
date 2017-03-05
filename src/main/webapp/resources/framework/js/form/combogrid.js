ns.ready(function(){
	ns.form.combogrid = {
			init : function(){
				//引入必要的样式+JS文件
				ns.requireJS("/framework/js/view/datagrid.js");
				ns.requireCSS("/framework/plugins/combogrid/combogrid.css");
				ns.requireJS("/framework/plugins/combogrid/combogrid.js");
			}
	};
	try{
		ns.form.combogrid.init();
	}catch(e){
		alert("请引入ComboGrid组件！");
	}
});
