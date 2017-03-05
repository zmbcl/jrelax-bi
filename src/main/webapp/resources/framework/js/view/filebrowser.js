function NSFileBrowser() {
    var $options = {};
    var $modal = null;
    var $url = ns.getBasePath() + "/common/filebrowser";
    var $id = "__divFileBrowser" + (new Date().getTime());
    var $path = "";//当前文件路径
    var _def = {
        filter: "",//文件筛选
        autoclose: true,//自动关闭
        onSelect: function () {
        } //选择事件
    }
    //过滤类型
    this.type = {
        image : "jpg, jpeg, png, gif, bmp",
        office : "doc, docx, xls, xlsx, ppt, pptx",
        video : "mp4, avi, mkv, mov, rm, wmv, flv"
    };
    this.createModal = function () {
        var oDiv = "<div id=\"" + $id + "\" class=\"modal fade bs-modal-sm\" tabindex=\"-3\" role=\"dialog\" aria-hidden=\"true\"><div class=\"modal-dialog modal-lg\"><div class=\"modal-content\"></div></div></div>";
        $("body").append(oDiv);
        $modal = $("#" + $id);
    }

    this.open = function (opt) {
        $options = $.extend(_def, opt);
        this.createModal();
        var url = $url;
        if ($options.filter) {
            url = $url + "?filter=" + $options.filter;
        }
        $modal.modal({show: true, remote: url});
        var instance = this;
        $modal.on("shown.bs.modal", function () {
            $.proxy(init, instance)();
        });
        //关闭窗口后
        $modal.on("hidden.bs.modal", function () {
            $modal.remove();
        });
    }
    this.close = function () {
        $modal.modal("hide");
    }
    this.load = function (selectPath) {
        $path = selectPath;
        $modal.find("table tbody").html("<tr><td colspan='4'><center>正在加载...</center></td></tr>");
        var instance = this;
        $.post($url + "/folder", {path: $path, filter: this.filter}, function (data) {
            if (data.success == true) {
                if (data.data.length == 0) {
                    $modal.find("table tbody").html("<tr><td colspan='4'><center>此文件夹是空的</center></td></tr>");
                } else {
                    $modal.find("table tbody").html("");
                    for (var i = 0; i < data.data.length; i++) {
                        var file = data.data[i];
                        var html = "<tr>";
                        html += "<td style=\"word-break: break-all;\"><i class=\"" + file.icon + "\"></i>&nbsp;&nbsp;";
                        if (file.type == 1)//文件
                            html += "<a href=\"javascript:;\" data-type='select' data-path=\"" + file.path + "\">" + file.name + "</a></td>";
                        else
                            html += "<a href=\"javascript:;\" data-type='load' data-path=\"" + file.path + "\">" + file.name + "</a></td>";
                        html += "<td>" + file.size + "</td>";
                        html += "<td>" + file.modifyTime + "</td>";
                        html += "<td>";
                        if (file.type == 1)//文件
                            html += "<a href=\"javascript:;\" title=\"预览\" data-type='preview' data-path=\"" + file.path + "\"><i class=\"fa fa-eye mr10\"></i></a>";
                        html += "<a href=\"javascript:;\" title=\"选择\" data-type='select' data-path=\"" + file.path + "\"><i class=\"fa fa-check\"></i></a>";
                        html += "</td>";
                        html += "</tr>";

                        $modal.find("table tbody").append(html);
                    }
                }
                $.proxy(init, instance)();
            } else {
                alert("加载失败,请稍后重试！");
            }
        });
    }
    this.reload = function () {
        this.load($path);
    }
    this.download = function (path) {
        alert("暂不提供下载！");
    }
    this.preview = function (path) {//文件预览
        var previewId = "__divFilePreview" + (new Date().getTime());
        var oDiv = "<div id=\"" + previewId + "\" class=\"modal fade bs-modal-sm\" tabindex=\"2\" role=\"dialog\" aria-hidden=\"true\"><div class=\"modal-dialog\"><div class=\"modal-content\"></div></div></div>";
        $("body").append(oDiv);
        var preview = $("#" + previewId);
        $.post(ns.getBasePath() + "/common/filebrowser/preview", {path: path}, function (data) {
            preview.find(".modal-content").html(data);
            preview.modal("show");
            //关闭窗口后
            preview.on("hidden.bs.modal", function () {
                preview.remove();
            });
        });
    };
    this.select = function (path) {
        if (!path.startsWith("/"))
            path = "/" + path;
        $options.onSelect(path);
        if ($options.autoclose == true)
            this.close();
    };
    this.prev = function () {
        var path = $path;
        var idx = path.lastIndexOf("/");
        if (idx == -1)
            path = "";
        else
            path = path.substring(0, idx);
        this.load(path);
    };
    this.root = function () {
        if ($path.length > 0) {
            this.load("");
        }
    }

    function init() {
        initNav(this);
        initEvents(this);
    }

    function initEvents(instance) {
        //select
        $modal.find("[data-type='select']").on("click", function(){
            var path = $(this).data("path");
            instance.select(path);
        });
        //preview
        $modal.find("[data-type='preview']").on("click", function(){
            var path = $(this).data("path");
            instance.preview(path);
        });
        //load
        $modal.find("[data-type='load']").on("click", function(){
            var path = $(this).data("path");
            instance.load(path);
        });
        //reload
        $modal.find("[data-type='reload']").on("click", function(){
            instance.reload();
        });
        //root
        $modal.find("[data-type='root']").on("click", function(){
            instance.root();
        });
    }

    function initNav(instance) {
        //初始化返回上一级按钮
        if ($path.length == 0) {
            var btnPrev = $modal.find("#prev");
            btnPrev.attr("disabled", "disabled");
            btnPrev.unbind("click");
        } else {
            var btnPrev = $modal.find("#prev");
            btnPrev.removeAttr("disabled");
            btnPrev.unbind("click");
            btnPrev.bind("click", function () {
                instance.prev();
            });
        }
        //初始化导航
        var nav = "<li><i class=\"ti-home\"></i> <a href=\"javascript:;\" data-type='root'>根目录</a></li>";
        if ($path.length > 0) {
            var folders = $path.split("/");
            for (var i = 0; i < folders.length - 1; i++) {
                var cPath = "";
                for (var j = 0; j <= i; j++) {
                    cPath += "/" + folders[j];
                }
                cPath = cPath.substring(1);
                nav += "<li><a href=\"javascript:;\" data-type='load' data-path=\"" + cPath + "\">" + folders[i] + "</a></li>";
            }
            nav += "<li class=\"active\">" + folders[folders.length - 1] + "</li>";
        }
        $modal.find("#nav").html(nav);
    }
}
//与ns绑定
ns.ready(function () {
    ns.view.filebrowser = new NSFileBrowser();
});