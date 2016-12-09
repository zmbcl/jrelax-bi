/**
 * 用于提交生成的表单
 * 引用表单的页面，必须要引用此脚本
 */
function _form_submit(form){
	if(!$){
		alert("必须引入jQuery！");
		return false;
	}
	var param = {};
	var controls = $(form).find("[name]");
	for(var i=0;i<controls.length;i++){
		var control = controls[i];
		var name = $(control).attr("name");
		var val = control.value || $(control).text();
		//进行非空验证
		if($(control).attr("data-required") == "true"){
			if(val == 0){
				$(control).css("border","1px solid red");
				return false;
			}else{
				$(control).css("border","1px solid #e3e6f3");
			}
		}
		param[name] = val;
	}
	jQuery.post(form.action,param,function(data){
		if(data.success == true){
			var tip = $(form).find("[tip]");
			if(tip.length>0)
				alert(tip.attr("tip"));
			else
				alert("保存成功！");
		}else{
			alert(data.error);
		}
	});
	return false;
}