var zFileBrowser = {
		url : ns.getBasePath()+"/common/filebrowser",
		id : "__divFileBrowser"+(new Date().getTime()),
		$obj : null,
		path : "",//当前文件路径
		filter : "",//文件筛选
		autoclose : true,//自动关闭
		onSelect : null,
		init : function(){
			var oDiv = "<div id=\""+this.id+"\" class=\"modal fade bs-modal-sm\" tabindex=\"-3\" role=\"dialog\" aria-hidden=\"true\"><div class=\"modal-dialog modal-lg\"><div class=\"modal-content\"></div></div></div>";
			$("body").append(oDiv);
			$obj = $("#"+this.id);
		},
		open : function(options){
			this.init();
			var newUrl = this.url;
			if(options){
				if(options.filter){
					this.filter = options.filter;
					newUrl = this.url + "?filter="+options.filter;
				}
				if(options.onSelect)
					this.onSelect = options.onSelect;
				if(options.autoclose)
					this.autoclose = options.autoclose;
			}
			$obj.modal({show:true, remote:newUrl});
			//关闭窗口后
			$obj.on("hidden.bs.modal", function() {
			    $obj.remove();
			});
		},
		close : function(){
			$obj.modal("hide");
		},
		initNav : function(){
			//初始化返回上一级按钮
			if(this.path.length == 0){
				var btnPrev = $obj.find("#prev");
				btnPrev.attr("disabled","disabled");
				btnPrev.unbind("click");
			}else{
				var btnPrev = $obj.find("#prev");
				btnPrev.removeAttr("disabled");
				btnPrev.unbind("click");
				btnPrev.bind("click", function(){
					zFileBrowser.prev();
				});
			}
			//初始化导航
			var nav = "<li><i class=\"ti-home\"></i> <a href=\"javascript:;\" onclick=\"zFileBrowser.root()\">根目录</a></li>";
			if(this.path.length > 0){
				var folders = this.path.split("/");
				for(var i=0;i<folders.length-1;i++){
					var cPath = "";
					for(var j=0;j<=i;j++){
						cPath += "/"+folders[j];
					}
					cPath = cPath.substring(1);
					nav += "<li><a href=\"javascript:;\" onclick=\"zFileBrowser.load('"+cPath+"')\">"+folders[i]+"</a></li>";
				}
				nav += "<li class=\"active\">"+folders[folders.length-1]+"</li>";
			}
			$obj.find("#nav").html(nav);
		},
		load : function(path){
			this.path = path;
			$obj.find("table tbody").html("<tr><td colspan='4'><center>正在加载...</center></td></tr>");
			$.post(this.url+"/folder",{path:path,filter:this.filter},function(data){
				if(data.success == true){
					if(data.data.length == 0){
						$obj.find("table tbody").html("<tr><td colspan='4'><center>此文件夹是空的</center></td></tr>");
					}else{
						$obj.find("table tbody").html("");
						for(var i=0;i<data.data.length;i++){
							var file = data.data[i];
							var html = "<tr>";
							html += "<td style=\"word-break: break-all;\"><i class=\""+file.icon+"\"></i>&nbsp;&nbsp;";
							if(file.type == 1)//文件
								html += "<a href=\"javascript:;\" onclick=\"zFileBrowser.select('"+file.path+"')\">"+file.name+"</a></td>";
							else
								html += "<a href=\"javascript:;\" onclick=\"zFileBrowser.load('"+file.path+"')\">"+file.name+"</a></td>";
							html += "<td>"+file.size+"</td>";
							html += "<td>"+file.modifyTime+"</td>";
							html += "<td>";
							if(file.type == 1)//文件
								html += "<a href=\"javascript:;\" title=\"预览\" onclick=\"zFileBrowser.preview('"+file.path+"')\"><i class=\"fa fa-eye mr10\"></i></a>";
							html += "<a href=\"javascript:;\" title=\"选择\" onclick=\"zFileBrowser.select('"+file.path+"')\"><i class=\"fa fa-check\"></i></a>";
							html += "</td>";
							html += "</tr>";
							
							$obj.find("table tbody").append(html);
						}
					}
					zFileBrowser.initNav();
				}else{
					alert("加载失败,请稍后重试！");
				}
			});
		},
		reload : function(){
			this.load(this.path);
		},
		download : function(path){
			alert("暂不提供下载！");
		},
		preview : function(path){//文件预览
			var previewId = "__divFilePreview"+(new Date().getTime());
			var oDiv = "<div id=\""+previewId+"\" class=\"modal fade bs-modal-sm\" tabindex=\"2\" role=\"dialog\" aria-hidden=\"true\"><div class=\"modal-dialog\"><div class=\"modal-content\"></div></div></div>";
			$("body").append(oDiv);
			var preview = $("#"+previewId);
			$.post(ns.getBasePath()+"/common/filebrowser/preview", {path:path}, function(data){
				preview.find(".modal-content").html(data);
				preview.modal("show");
				//关闭窗口后
				preview.on("hidden.bs.modal", function() {
					preview.remove();
				});
			});
		},
		select : function(path){
			if(!path.startsWith("/"))
				path = "/" + path;
			if(this.onSelect)
				this.onSelect(path);
			if(this.autoclose == true)
				this.close();
		},
		prev : function(){
			var path = this.path;
			var idx = path.lastIndexOf("/");
			if(idx == -1)
				path = "";
			else
				path = path.substring(0, idx);
			this.load(path);
		},
		root : function(){
			if(this.path.length > 0){
				this.load("");
			}
		}
};
//与ns绑定
ns.ready(function(){
	ns.view.filebrowser = zFileBrowser;
});