ns.ready(function(){
	ns.form.iCheck = {
			init : function(){
				//引入必要的样式+JS文件
				ns.requireCSS("/framework/plugins/icheck/skins/all.css");
				ns.requireJS("/framework/plugins/icheck/icheck.js");
				ns.form.initCheckbox = function(obj){
					if ($.isFunction($.fn.iCheck)) {
		                $(".icheck,[data-icheck],[data-checkbox]").each(function(){
		                	//配置skin属性设置按钮皮肤
		                	var skin = $(this).attr("skin");
		                	if(!skin || skin.length == 0){
								skin = "minimal-blue";
		                	}
		                	var text = $(this).attr("title");
							$(this).iCheck({
								checkboxClass: 'icheckbox_'+skin,
								radioClass: 'iradio_'+skin,
								insert : text
							});
		                });
						//绑定全选事件，全选按钮上配置icheck-all属性，属性值为特定的属性名，所有拥有此属性名的icheck将与此icheck同步状态
						$(".icheck[data-check-all],[data-icheck][data-check-all]").on('ifChanged', function(event){
							var item = $(this).attr("data-check-all");
							if(item){
								if($(this).is(":checked"))
									$("input["+item+"]").iCheck("check");
								else
									$("input["+item+"]").iCheck("uncheck");
							}
						});
		            }
				};
				ns.form.initCheckbox();
				//全选、全不选、反选、获取选中
				ns.form.check = function(target){
					return new function(){
						target = typeof (target) == "string" ? $(target) : target;
						this.getChecks = function(){
							var array = [];
							target.find("input[type='checkbox']:checked:not([data-check-all]),input[type='radio']:checked:not([data-check-all])").each(function () {
								array.push(this.value);
							});
							return array;
						}
						this.checkAll = function(){
							var chkAll = target.find("[data-check-all]");
							if(chkAll.hasClass("icheck")){
								chkAll.iCheck("check");
								var item = chkAll.attr("data-check-all");
								if(item){
									target.find("input["+item+"]").iCheck("check");
								}
							}else{
								chkAll.prop("checked", true);
								var item = chkAll.attr("data-check-all");
								if(item){
									target.find("input["+item+"]").prop("checked", true);
								}
							}
						}
						this.uncheckAll = function(){
							var chkAll = target.find("[data-check-all]");
							if(chkAll.hasClass("icheck")){
								chkAll.iCheck("uncheck");
								var item = chkAll.attr("data-check-all");
								if(item){
									target.find("input["+item+"]").iCheck("uncheck");
								}
							}else{
								chkAll.prop("checked", false);
								var item = chkAll.attr("data-check-all");
								if(item){
									target.find("input["+item+"]").prop("checked", false);
								}
							}
						}
						this.reverseCheck = function(){
							target.find(":checkbox:not([data-check-all])").each(function(i, chk){
								chk = $(chk);
								if(chk.hasClass("icheck")){
									chk.iCheck("toggle");
								}else{
									chk.prop("checked", !chk.checked);
								}
							});
						}
					};
				};
			}
	};
	try{
		ns.form.iCheck.init();
	}catch(e){
		alert("请引入icheck组件！");
	}
});