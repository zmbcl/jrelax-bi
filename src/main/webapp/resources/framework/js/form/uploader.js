var zUploader = {
		url : ns.getBasePath()+"/common/upload",
		id : "__divUploader"+(new Date().getTime()),
		$obj : null,
		init : function(){
			var oDiv = "<div id=\""+this.id+"\" class=\"modal fade bs-modal-sm\" tabindex=\"-3\" role=\"dialog\" aria-hidden=\"true\"><div class=\"modal-dialog\"><div class=\"modal-content\"></div></div></div>";
			$("body").append(oDiv);
			$obj = $("#"+this.id);
		},
		open : function(options){
			var _def = {
				filter : "",// 文件类型过滤，传入 *.jpg,*.png
				autoclose : true, //上传完成后，自动关闭
				autoname : false, // 是否自动命名
				filepath : "",// 服务器端保存路径
				showfilename : false,
				showfilepath : false, //显示文件上次保存路径
				multiple : true,//多文件选择
				success : function(){},
				error : null
			}
			options = $.extend(_def, options);
			this.init();
			$obj.modal({show:true, remote:this.url});
			//关闭窗口后
			$obj.on("hidden.bs.modal", function() {
			    $obj.remove();
			});
			//远程加载完成后
			$obj.on("loaded.bs.modal", function() {
				//防止遮罩层重叠
				$obj.next().css("zIndex", parseInt($obj.css("zIndex")) + $(".modal").length * 2);
				$obj.css("zIndex", parseInt($obj.css("zIndex")) + $(".modal").length * 4);
				var $form = $obj.find("form");
				$form.ajaxForm({
					beforeSubmit:function(arr, $form, op){
						if(options.filter.length > 0){
							try{
								var name = $form.find("input:file").val();
								var ext = name.substring(name.lastIndexOf(".")+1).toLowerCase();
								var result = false;
								var filters = options.filter.split(",");
								for(var i=0;i<filters.length;i++){
									if(filters[i].toLowerCase() == ext){
										result = true;
										break;
									}
								}
								if(!result) {
									ns.alert("文件类型错误，请上传后缀名为"+options.filter+"的文件！");
									return false;
								}
							}catch(e){
								ns.alert("文件类型错误，请上传后缀名为"+options.filter+"的文件！");
								return false;
							}
							
						}else{
							var name = $form.find("input:file").val();
							if(name == ""){
								ns.alert("请先选择文件后再点击上传！");
								return false;
							}
						}
			            $form.find("#ok").button("loading");
					},
					beforeSend : function(){
						zUploader.showProgressBar();
					},
					uploadProgress:function(event, postion, total, percentComplete){
						var procbar = $obj.find(".progress-bar");
		            	$obj.find("#cur").text(zUploader.sizeFormat(postion));
		            	procbar.css("width", percentComplete+"%");
					},
					success : function(data, statusText, xhr, $form) {
						if(data.success == true){
							if(typeof(options.success) == "function") {
								var names = [];
								$.each(data.path.split(","), function (i, n) {
									n = n.substring(n.lastIndexOf("/") + 1);

									names.push(n);
								});
								options.success(data.path, names.toString());
							}
						}else{
							if(typeof(options.error) == "function"){
								options.error(data.error);
							}else{
								ns.tip.toast.error(data.error);
							}
						}
						//默认自动关闭
						if(options.autoclose == true){
							zUploader.close();
						}
			            $form.find("#ok").button("reset");
		        	}
				});
				//自动获取名字
				if(options.autoname == true){
					$form.find("input:file").bind("change",function(){
						var name = $(this).val();
						name = name.substring(name.lastIndexOf("\\")+1);
						name = name.substring(name.lastIndexOf("/")+1);
						name = name.substring(0,name.lastIndexOf("."));
						$form.find("input[name='filename']").val(name);
					});
				}
				//存放路径
				if(options.filepath){
					$form.find("input[name='filepath']").val(options.filepath);
				}
				//是否显示文件名
				if(options.showfilename == true){
					$form.find("input[name='filename']").parent().show();
				}
				//是否显示存放路径
				if(options.showfilepath == true){
					$form.find("input[name='filepath']").parent().show();
				}
				//文件选择框美化
				var input_file = $form.find("input[name='file']");
				//取消多文件选择
				if(options.multiple == false){
					input_file.removeAttr("multiple");
				}
				input_file.bind("change", function(){
					if(this.files){
						var path = this.value;
						var dir = "";
						if(path.indexOf("\\") >= 0){
							dir = path.substring(0, path.lastIndexOf("\\"));
						}else{
							dir = path.substring(0, path.lastIndexOf("/"));
						}
						var paths = [];
						$.each(this.files, function(i,n){
							paths.push(dir+"/"+n.name);
						});
						input_file.next().find("input").val(paths.toString());
					}else{
						input_file.next().find("input").val($(this).val());
					}
				});
				input_file.next().find(".btn").bind("click", function(){
					input_file.click();
				});
			});
		},
		close : function(){
			$obj.modal("hide");
		},
		sizeFormat : function(size){
			size = size / 1024;
			if(size < 1024) return parseFloat(size).toFixed(1)+"KB";
			size = size / 1024;
			if(size < 1024) return parseFloat(size).toFixed(1)+"MB";
			size = size / 1024;
			if(size < 1024) return parseFloat(size).toFixed(1)+"GB";
		},
		showProgressBar : function(){
			//获取上传进度信息
			var procbar = $obj.find(".progress-bar");
			var files = $obj.find("input:file")[0].files;
			var size = 0;
			$.each(files, function(i,n){
				size += n.size;
			});
			$obj.find("#total").text(zUploader.sizeFormat(size));
			procbar.parents(".form-group").show();
		}
};
//与ns绑定
ns.ready(function(){
	ns.form.uploader = zUploader;
});