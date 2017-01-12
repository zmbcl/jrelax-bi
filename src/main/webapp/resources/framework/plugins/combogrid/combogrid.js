/**
 * Created by zengc on 2016-09-01.
 */
(function ($) {
    $.fn.combogrid = function (options) {
        options = options || {};
        return $(this).each(function () {
            var settings = $.extend(jQuery.fn.combogrid.defaults, options);
            var element = $(this);
            var width = element.outerWidth();
            element.hide();

            var parent = element.parent();
            var id = "combogrid-grid-" + (new Date().getTime());
            var html = "<div class='input-group combogrid-controls'>";
            html += "<input class='form-control combotree-input'>";
            html += "<span class='input-group-btn'> <button class='btn btn-default' type='button'><span class='caret'></span></button></span>";
            html += "</div>";
            html += "<div id='" + id + "' class='combogrid-gridview' style='display:none;'><table id='" + id + "-table'></table><div class='combogrid-gridview-pager' id='" + id + "-pager'></div></div>";

            parent.append(html);

            if(settings.text){//初始化显示
                parent.find(".combotree-input").val(settings.text);
            }

            var gridview = parent.find("#" + id);
            var controls = parent.find(".combogrid-controls input,.combogrid-controls button");

            //设置样式
            gridview.css("height", settings.height);
            if (settings.width == "auto")
                settings.width = width;
            gridview.css("width", settings.width);

            var grid = gridview.find("#" + id + "-table");
            var _options = {
                url: settings.url,
                colModel: settings.columns,
                rownumbers: true,
                autowidth: false,
                viewrecords: settings.width < 450 ? false : true,
                width: settings.width - 1,
                height: settings.height - 80,
                pager: gridview.find("#" + id + "-pager"),
                onSelectRow: function (rowid, status, e) {
                    var data = grid.getRowData(rowid);

                    element.val(data[settings.idField]);
                    $(controls[0]).val(data[settings.textField]);
                    if (!settings.multiple) gridview.hide();

                    grid.selected = rowid;

                    settings.onSelected(data);
                },
                loadComplete: function () {
                    //重新加载数据之后，选中行保持选中状态
                    if (grid.selected) {
                        grid.setSelection(grid.selected, false);
                    }
                },
                gridComplete: function () {
                    gridview.find("#" + id + "-pager_center").remove();
                    grid.inited = true;
                }
            };

            //初始化事件
            controls.on("click", function () {
                if(!grid.inited){
                    grid.jqGrid(_options);
                }
                if (!gridview.is(":visible"))
                    gridview.show();
            });

            $(document).on("mouseup", function (e) {
                if (gridview.is(e.target) || controls.is(e.target) || gridview.has(e.target).length > 0) return;
                gridview.hide();
            });
        });
    }
    $.fn.combogrid.defaults = {
        url: "",
        columns: [],
        width: "auto",
        height: 200,
        multiple: false, // 支持多选
        idField: "id",//值字段
        textField: "text",//显示字段
        text : undefined,//显示值
        onSelected: function (data) {
        }
    }
}(jQuery));
