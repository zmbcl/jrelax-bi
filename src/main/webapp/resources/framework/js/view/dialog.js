/**
 * 模态窗口
 * Created by zengc on 2016/8/19.
 */
ns.ready(function () {
    ns.view.Dialog = function (options) {
        var dialog = null;
        var _def = {
            id: "__divDialog" + new Date().getTime(),
            title: "",
            content: "",
            size: "",
            border: "",
            theme : "",//皮肤样式： modal-primary modal-danger modal-info modal-warning
            showHeader: false,
            showFooter: false,
            showOk: true,
            showCancel: false,
            showClose: true,
            remote: false,//远程访问
            remoteUrl: null,//远程URL
            onShown: function () {},
            onHidden: function () {},
            onLoaded: function () {}
        }

        options = $.extend(_def, options);
        if(!options.border) options.border = "no-b";
        else options.border = "bordered";
        var begin = "<div id='" + options.id + "' class='modal fade bs-" + options.size+" "+options.theme + "' role='dialog' aria-hidden='true'><div class='modal-dialog " + options.size + "'><div class='modal-content " + options.border + "'>";
        var end = "</div></div></div>";
        //模态窗头部
        var header = "<div class='modal-header no-b'>";
        if (options.showClose)
            header += "<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>";
        header += "<h4 class='modal-title'>" + options.title + "</h4>";
        header += "</div>";
        //模态窗主体
        var body = "<div class='modal-body'><div class='row'>" + options.content + "</div></div>";
        if (options.remote) {
            body = "<div class=\"modal-body\"><div class=\"row\"><div class=\"col-xs-12\"><center><img src='" + ns.getBasePath() + "/framework/img/refresh.gif'/>正在加载中...</center></div></div></div>";
        }
        //模态窗底部
        var footer = "<div class='modal-footer p10 no-b'>";
        if (options.showOk)
            footer += "<button id='ok' type='button' class='btn btn-primary' autofocus>确 定</button>";
        if (options.showCancel)
            footer += "<button id='cancel' type='button' class='btn btn-default btn-outline' data-dismiss='modal'>取 消</button>";
        footer += "</div>";

        this.setHeader = function (str) {
            header = str;
        }
        this.setFooter = function (str) {
            footer = str;
        }
        this.setBody = function (str) {
            body = str;
        }
        this.html = function () {
            var html = begin;
            if (options.showHeader) {
                html += header;
            }
            html += body;
            if (options.showFooter) {
                html += footer;
            }
            html += end;

            return html;
        }

        this.show = function () {
            $("body").append(this.html());
            //$(".app").addClass("blur");
            dialog = $("#" + options.id);
            dialog.on("loaded.bs.modal", function(e){
                options.onLoaded(dialog, this);
            });
            dialog.on("show.bs.modal", function(){
                //防止遮罩层重叠
                dialog.next().css("zIndex", parseInt(dialog.css("zIndex")) + $(".modal").length * 2);
                dialog.css("zIndex", parseInt(dialog.css("zIndex")) + $(".modal").length * 4);
            });
            dialog.on("shown.bs.modal", function () {
                //设置焦点
                $(this).find("[autofocus]:first").focus();
                options.onShown(dialog, this);
            });
            dialog.on("hidden.bs.modal", function () {
                $(this).remove();
                //$(".app").removeClass("blur");
                options.onHidden(dialog, this);
                delete top._openDialogs_[dialog.attr("id")];
            });
            dialog.close = function(){
                dialog.modal("hide");
            }
            if (options.remote) {
                dialog.modal({
                    show: true,
                    remote: options.remoteUrl
                });
            } else {
                dialog.modal("show");
            }
            if(!top._openDialogs_)
                top._openDialogs_ = {};

            top._openDialogs_[options.id] = dialog;
            return dialog;
        }
    }

    //获取当前窗口
    ns.view.Dialog.getCur = function(element){
        var modal = $(element).parents(".modal");
        if(modal.length>0){
            var id = modal.attr("id");
            return top._openDialogs_[id];
        }
        return undefined;
    }

    //关闭窗口，并传递参数
    ns.view.Dialog.close = function(element, options){
        var dialog = ns.view.Dialog.getCur(element);
        if(dialog){
            if(options){
                for(var op in options){
                    dialog[op] = options[op];
                }
            }
            dialog.close();
        }
    }
});
