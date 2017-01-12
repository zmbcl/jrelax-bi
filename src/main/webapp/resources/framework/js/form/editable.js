ns.ready(function(){
	ns.form.editable = {
			init : function(){
				ns.requireCSS("/framework/plugins/x-editable/bootstrap-editable.css");
				ns.requireJS("/framework/plugins/x-editable/bootstrap-editable.js");
			}
	};
	try{
		ns.form.editable.init();
	}catch(e){
		alert("请引入Bootstrap.x-editable组件！");
	}
});