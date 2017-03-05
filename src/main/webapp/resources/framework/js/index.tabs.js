/**
 * 首页Tab相关
 * Created by zengchao on 2016-09-21.
 */
var Tabs;
function createFrame(src) {
    return "<iframe src=\"" + src + "\" width=\"100%\" height=\"100%\" frameborder=\"0\"></iframe>"
}
$(function () {
    Tabs = new TabPanel({
        renderTo: 'tab',
        width: "100%",
        height: $(".wrapper").height(),
        border: 'none',
        autoResizable: true,
        widthResizable: true,
        active: 0,
        items: [{
            id: 'index',
            icon2: "<i class='glyphicon glyphicon-home'></i>",
            title: "仪表板",
            html: createFrame(ns.getBasePath() + "/welcome"),
            closable: false
        }],
        onActive: function (pos) {
            if (Tabs){
                if(Tabs.setWindowHash)
                    Tabs.setWindowHash();
                if(Tabs.setActiveMenu){
                    if(Tabs.getActiveTab().url)
                        Tabs.setActiveMenu(Tabs.getActiveTab().url);
                }
            }
        }
    });
    Tabs.toggle = function () {
        $(".tabpanel_tab_content").toggle("display");
        Tabs.resize();
    }
    Tabs.hash = function (str) {//计算hash值
        var hash = 0;
        if (str.length == 0) return hash;
        for (i = 0; i < str.length; i++) {
            char = str.charCodeAt(i);
            hash = ((hash << 5) - hash) + char;
            hash = hash & hash; // Convert to 32bit integer
        }
        return Math.abs(hash);
    }
    //增加Tab
    Tabs.add = function (url, title, icon) {
        Tabs.addTab({
            id: "tab_" + Tabs.hash(url),
            icon2: "<i class='" + icon + "'></i>",
            title: title,
            html: createFrame(url),
            closable: true,
            url: url
        });
        Tabs.bindContextMenu();
        Tabs.setActiveMenu(url);
        Tabs.setWindowHash();
        return Tabs.getActiveIndex();
    }
    //定位显示当前菜单
    Tabs.setActiveMenu = function(url){
        //纵向菜单
        var sidebar = $(".sidebar a[data-tabs-link='" + url + "']");
        if (sidebar.length > 0) {
            sidebar.parents("nav").find("li.active").removeClass("active");
            sidebar.parent().addClass("active");
        }
        //横向菜单
        sidebar = $(".nav.vertical a[data-tabs-link='" + url + "']");
        if (sidebar.length > 0) {
            sidebar.parents(".nav").find("li.active").removeClass("active");
            sidebar.parent().addClass("active");
            sidebar.parents(".nav").find("li[data-first-res].selected").removeClass("selected");
            sidebar.parents("li[data-first-res]").addClass("selected");
        }
    }
    Tabs.setWindowHash = function () {
        var tab = Tabs.getActiveTab();
        if (tab && tab.url)
            window.location.hash = tab.url.replace(ns.getBasePath(), "");
    }
    var contextMenu = $("#tab_context_menu");
    Tabs.bindContextMenu = function () {//右键菜单
        var tab_control = $(".tabpanel_tab_content .tabpanel_mover>li");
        tab_control.unbind("contextmenu");
        tab_control.bind("contextmenu", function (e) {
            var pageX = e.pageX;
            var pageY = e.pageY;

            contextMenu.css("position", "absolute");
            contextMenu.css("left", pageX).css("top", pageY);

            contextMenu.fadeIn("fast");

            Tabs.curIndex = $(this).index();
            Tabs.cur = $(this);

            if (Tabs.curIndex == 0) {
                contextMenu.find("li:first").addClass("disabled");
            } else {
                contextMenu.find("li:first").removeClass("disabled");
            }

            return false;
        });

        $(document).on("click", function () {
            contextMenu.fadeOut("fast");
        });
    }
    Tabs.bindContextMenu();
    // $(".app a[data-pjax]").each(function (i, n) {
    //     var a = $(n);
    //     var href = a.attr("href");
    //     if (href != "javascript:;" && a.attr("target") != "_blank") {
    //         a.bind("click", function () {
    //             var url = a.attr("url");
    //             if (url == ns.getBasePath() + "/index") {
    //                 this.show("index", false);
    //                 return;
    //             }
    //             var title = a.attr("title");
    //             var icon = a.attr("icon");
    //             if (icon == "") icon = "fa fa-file";
    //             Tabs.add(url, title, icon);
    //         });
    //         a.attr("href", "javascript:;");
    //         a.attr("url", href);
    //     }
    // });
    ns.view.initTabsLink();
    //关闭当前
    Tabs.closeCur = function () {
        if (Tabs.curIndex != 0)
            Tabs.kill(Tabs.curIndex);
    }
    //全部关闭
    Tabs.closeAll = function () {
        var len = Tabs.tabs.length;
        for (var i = 1; i < len; i++) Tabs.kill(1);
    }
    //关闭其他
    Tabs.closeOther = function () {
        Tabs.closeLeft();
        Tabs.curIndex = Tabs.cur.index();
        Tabs.closeRight();
    }
    //关闭左侧
    Tabs.closeLeft = function () {
        for (var i = 1; i < Tabs.curIndex; i++) Tabs.kill(1);
        Tabs.curIndex = Tabs.cur.index();
        Tabs.show(Tabs.curIndex);
    }
    //关闭右侧
    Tabs.closeRight = function () {
        var len = Tabs.tabs.length;
        for (var i = Tabs.curIndex + 1; i < len; i++) Tabs.kill(Tabs.curIndex + 1);
        Tabs.curIndex = Tabs.cur.index();
        Tabs.show(Tabs.curIndex);
    }
    //重新加载
    Tabs.reload = function (position) {
        var iframe = this.tabs[position].content.find('iframe');
        if (iframe.length > 0) iframe.attr("src", iframe.attr("src"));
    }
    //重新加载当前
    Tabs.reloadCur = function () {
        Tabs.reload(Tabs.curIndex);
    }
    //添加到快捷菜单
    Tabs.addToQuickMenu = function(){
        ns.view.showModal(ns.getBasePath() + "/uc/quickmenu/add", {
            onShown : function(dialog){
                var context = Tabs.cur;
                var iframe = Tabs.tabs[context.index()].content.find('iframe')[0];
                if(iframe){
                    var name = context.text();
                    var url = iframe.contentWindow.location.href;

                    dialog.find("input[name='name']").val(name);
                    dialog.find("input[name='url']").val(url);
                }
            },
            onHidden : function(dialog, obj){

            }
        });
    }

    //获取hash
    var h = window.location.hash;
    if (h.length > 1) {
        h = h.substring(1);
        var sidea = $(".sidebar a[data-tabs-link='" + ns.getBasePath() + h + "'],.nav.vertical a[data-tabs-link='" + ns.getBasePath() + h + "']");
        if (sidea.length > 0) {
            Tabs.add(sidea.attr("data-tabs-link"), sidea.attr("title"), sidea.attr("icon"));
        }
    }

});