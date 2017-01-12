/**
 * 基于JqGrid的DataGrid组件
 * 修改JqGird.js 中的sidx为sort、sort为order
 */
ns.ready(function(){
	if(ns.view.datagrid) return;
	ns.view.datagrid = {
		opClickEvents : {},//操作栏事件
		counter : 0,
		offsetHeight : 55,
		init : function(){
			//引入必要的样式+JS文件
			ns.requireCSS("/framework/plugins/jqgrid/ui.jqgrid-bootstrap.css");
			ns.requireJS("/framework/plugins/jqgrid/grid.locale-zh_CN.js");
			ns.requireJS("/framework/plugins/jqgrid/jquery.jqGrid.min.js");
			$.jgrid.extend({
				reload : function(params){//从当前页
					var dg = $(this);
					if(params){
						dg = dg.setGridParam({
							datatype : 'json',
							postData : params
						});
					}
					dg.trigger("reloadGrid");
				},
				reloadFirst : function(params){//从第一页
					var dg = $(this);
					if(params){
						dg = dg.setGridParam({
							datatype : 'json',
							postData : params, //发送数据
							page : 1
						});
					}
					dg.trigger("reloadGrid");
				}
			});
			$.jgrid.styleUI.Bootstrap.base.headerTable = "table";
			$.jgrid.styleUI.Bootstrap.base.rowTable = "table table-striped table-hover";
			$.jgrid.styleUI.Bootstrap.base.footerTable = "table";
			$.jgrid.styleUI.Bootstrap.base.pagerTable = "table table-condensed";
			// $.jgrid.styleUI.Bootstrap.base.pgInput = "form-control bg-default";
			// $.jgrid.styleUI.Bootstrap.base.pgSelectBox = "form-control bg-default";
			$.jgrid.defaults = $.extend($.jgrid.defaults, {
				mtype : "POST",
				datatype: "json",
				styleUI : 'Bootstrap',
				viewrecords: true,
				autowidth:true,
				forceFit:true,
				shrinkToFit:true,
				pagerpos:'right',
				recordpos:'left',
				rowNum: 20,
				rowList:[10,20,50,100],
				loadui:"disable",
				beforeRequest : function(){
					ns.showLoadingbar();
				},
				gridComplete : function(){
					ns.closeLoadingbar();
					//下拉菜单位置
					if (ns.view.initDropdownMenuDirection)ns.view.initDropdownMenuDirection();
				}
			});
			//自适应宽度
			$(window).resize(function(){
				$(".ui-jqgrid").each(function(){
					var grid = $(this);
					var id = grid.attr("id").replace("gbox_", "");

					var target = $("#"+id);
					if(target.getGridParam("autowidth")){//设置为自动计算宽度 才生效
						//自适应宽度
						target.setGridWidth(grid.parent().width());
						target.width(target.width()-2);
						//自适应高度
						target.setGridHeight(grid.height() + ns.resizeDiff.height - ns.view.datagrid.offsetHeight);
					}
				})
			});

			ns.view.datagrid.inited = true;
		},
		renderEditable : function(title, classname, val, pk, placement){// 标题 样式名 显示值 主键值 显示方向
			placement = placement || "right";
			return "<a data-type=\"text\" data-title=\""+title+"\" data-pk=\""+pk+"\" data-placement=\""+placement+"\" class=\""+classname+"\">"+val+"</a>"
		},
		renderEnabled : function(val){//启用，禁用
			if(val)
				return "<i class=\"fa fa-circle text-success ml5\">";
			else
				return "<i class=\"fa fa-circle text-danger ml5\">";
		},
		renderYesOrNo : function(val){//是否
			if(val) return "是";
			else return "否";
		},
		renderOp : function(ops){//操作菜单
			/**
			 * ops包含
			 * divider 分隔线，如果设置了分割线，其他参数会被忽略
			 * onclick 执行的代码
			 * url 跳转的链接地址
			 * target target属性
			 * @type {string}
			 */
			var html = "<div class=\"btn-group\">" +
				"<button type=\"button\" class=\"btn btn-default btn-xs dropdown-toggle\" data-toggle=\"dropdown\">" +
				"<i class=\"ti-settings\"></i>" +
				" <span class=\"ti-angle-down\"></span>" +
				"</button>";
			html += "<ul class=\"dropdown-menu\" role=\"menu\">";
			if(ops && ops.length>0){
				for(var i=0;i<ops.length;i++){
					var id = "jqgrid-op-"+ns.view.datagrid.counter+"-"+i;
					var op = ops[i];
					if(op.divider){//分割线
						html += "<li class=\"divider\"></li>";
					}else{
						if(op.onclick){
							ns.view.datagrid.opClickEvents[id] = op.onclick;
							html += "<li><a href=\"javascript:;\" onclick=\"ns.view.datagrid._opFun('"+id+"')\">"+op.title+"</a></li>";
						}else if(op.url){
							html += "<li><a href=\""+op.url+"\"";
							if(op.target)
								html += " target='"+op.target+"'";
							html += ">"+op.title+"</a></li>";
						}else{
							html += "<li><a href=\"javascript:;\">"+op.title+"</a></li>";
						}
					}

					ns.view.datagrid.counter++;
				}
			}
			html += "</ul></div>";
			return html;
		},
		_opFun : function(id){//操作菜单方法执行
			var fun = ns.view.datagrid.opClickEvents[id];
			if(fun)fun();
		}
	};
	try{
		ns.view.datagrid.init();
	}catch(e){
		alert("请引入JQGrid组件！");
	}
});
