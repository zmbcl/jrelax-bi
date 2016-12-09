fd.run = {
	tooltip : {placement:"right"},
	init : function(){
		//获取所有视图，并调用其init方法
		var views = $("["+fd.config.viewTag+"]");
		$.each(views, function(i, view){
			view = $(view);
			var tag = jQuery.trim(view.attr(fd.config.viewTag));
			var fd_view = fd.config.view[tag];
			if(fd_view && fd_view.events){
				if(fd_view.events.init){
					fd_view.events.init(view);
				}
			}
		});
		//加载远程数据
		var remoteViews = $("select[remote]");
		$.each(remoteViews, function(i, view){
			view = $(view);
			var url = view.attr("remote");
			if(url.length > 0){
				view.html("<option value=''>正在加载中...</option>");
				view.attr("disabled", "disabled");
				$.post(url, {}, function(data){
					if(data.success == true){
						var list = data.data;
						view.html("");
						$.each(list, function(i, option){
							view.append("<option value='"+option.value+"'>"+option.text+"</option>");
						});
						view.removeAttr("disabled");
					}
				});
			}
		});
	},
	validate : function(){//验证
		var result = true;
		var views = $("["+fd.config.viewTag+"]");
		$.each(views, function(i, view){
			view = $(view);
			var value = view.val();//控件值
			var required = view.attr("required");
			if(required){
				if(value.length == 0){
					fd.run._validate_result(false, view, "必填项");
					result = false;
				}else{
					fd.run._validate_result(true, view, "ok");
				}
			}else{
				if(value.length == 0) return true;//非必填项并且值为空时，不验证其他规则
			}
			var rules = view.attr("rules");//验证规则
			if(result && rules){
				var validate = fd.run.validator.test(value,rules, view);
				if(!validate.pass){
					if(result){
						result = false;
					}
					fd.run._validate_result(false, view, validate.tip);
					return result;
				}else{
					if(fd.run._validate_range(view))
						fd.run._validate_result(true, view);
				}
			}
			if(result){//特殊组件判断
				result = fd.run._validate_range(view);
			}
		});
		return result;
	},
	_validate_range : function(view){
		if(view.parent().attr(fd.config.viewTag) == "moneyrange"){
			return fd.config.view.moneyrange.events.validate(view.parent());
		}else if(view.parent().attr(fd.config.viewTag) == "datepickerrange"){
			return fd.config.view.datepickerrange.events.validate(view.parent());
		}
		return true;
	},
	_validate_result : function(pass, view, tip){
		view.tooltip("destroy");
		if(pass == true){
			if(view.parent().is(fd.config.containerPanel))
				view.css("borderColor", "#15db81");
			else
				view.parent().removeClass("has-error").addClass("has-success");
		}else{
			if(view.parent().is(fd.config.containerPanel))
				view.css("borderColor", "#da3e16");
			else
				view.parent().removeClass("has-success").addClass("has-error");
			view.tooltip({title:tip, placement:fd.run.tooltip.placement});
			view.tooltip("show");
		}
	},
	submit : function(form){
		if(fd.run.validate()){
			//开始提交
			var data = {
					form : {},
					master : {},
					slave : {}
			};
			var elements = $(form).find("[name]");
			$.each(elements, function(i, e){
				var idx = e.name.indexOf(".");
				if(idx < 0){
					if(e.name == "$formId")
						data.form.id = $(e).val();
					else
						data.master[e.name] = $(e).val();
				}
				else{
					var table = e.name.substring(0, idx);
					var name = e.name.substring(idx+1);
					
					var array = data.slave[table] || [];
					var sIdx = 0;
					for(var j=0;j<array.length;j++){
						var cArray = array[j] || [];
						if(cArray.length == 0) array.push(cArray);
						if(cArray[name] == undefined){
							sIdx = j;
						}else{
							sIdx = j+1;
						}
					}
					var cData = array[sIdx] || {};
					cData[name] = $(e).val();
					array[sIdx] = cData;
					
					data.slave[table] = array;
				}
			});
			ns.post(form.action, {data:JSON.stringify(data)}, function(success, data){
				if(success){
					alert("表单提交成功！");
				}else{
					alert(data.error);
				}
			});
		}
		return false;
	}
};