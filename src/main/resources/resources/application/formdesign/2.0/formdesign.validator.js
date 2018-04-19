fd.run.validator = {
	test : function(value, rules, view){
		if(rules){
			rules = rules.split(",");
			var result = true;
			var tip = "";
			$.each(rules, function(i, rule){
				var valid = fd.run.validator[rule];
				if(valid){
					if(typeof(valid.regex) == "object"){
						if(result)
							result = valid.regex.test(value);
						tip += valid.tip + " ";
					}else if(typeof(valid.regex) == "function"){
						if(result)
							result = valid.regex(value, view);
						tip += valid.tip + " ";
					}
				}
			});
		}
		return {pass:result, tip:tip};
	},
	ip : {
		regex : /^([0-9]{1,3}\.{1}){3}[0-9]{1,3}$/,
		tip : "IP地址不正确",
		placeholder : "请输入符合规范ip地址"
	},
	english : {
		regex : /^[a-zA-Z]+$/,
		tip : "只能输入英文字母",
		placeholder : ""
	},
	integer : {
		regex : /^(0|[1-9]\d*)$/,
		tip : "只能输入整数",
		placeHolder : ""
	},
	englishAndNum : {
		regex : /^[a-zA-Z0-9]+$/,
		tip : "只能输入英文字母",
		placeHolder : ""
	},
	chinese : {
		regex : /^[\u4E00-\u9FA5]+$/,
		tip : "只能输入中文",
		placeHolder : ""
	},
	number : {
		regex : /-{1}\d+$/,
		tip : "数字格式不正确",
		placeHolder : ""
	},
	number2 : {
		regex : /^[1-9]+\d*$/,
		tip : "数字格式不正确",
		placeHolder : ""
	},
	qq : {
		regex : /^[1-9]*[1-9][0-9]*$/,
		tip : "QQ号码格式不正确",
		placeHolder : ""
	},
	email : {
		regex : /^\w+([-+.]\w+)*@\w+([-.]\w+)*.\w+([-.]\w+)*$/,
		tip : "邮件地址格式不正确",
		placeHolder : ""
	},
	mobile : {
		regex : /^1[3|4|5|8][0-9]\d{4,8}$/,
		tip : "手机号码格式不正确",
		placeHolder : ""
	},
	id : {
		regex : /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
		tip : "身份证格式不正确",
		placeHolder : ""
	},
	money : {
		regex : /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/,
		tip : "金额格式不正确",
		placeHolder : ""
	}
};