(function (a) {
    (jQuery.browser = jQuery.browser || {}).mobile =
        /(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i
            .test(a) ||
        /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i
            .test(a.substr(0, 4))
})(navigator.userAgent || navigator.vendor || window.opera);
Modernizr.addTest("retina", window.devicePixelRatio > 1);
Modernizr.addTest("webkit", navigator.userAgent.match(/AppleWebKit/i));
Modernizr.addTest("ipad", navigator.userAgent.match(/iPad/i));
Modernizr.addTest("iphone", navigator.userAgent.match(/iPhone/i));
Modernizr.addTest("ipod", navigator.userAgent.match(/iPod/i));
Modernizr.addTest("ios", Modernizr.ipad || Modernizr.ipod || Modernizr.iphone);
Modernizr.addTest("android", navigator.userAgent.match(/Android/i));
var offscreen = function () {
    var container = $(".app"), canvasDirection, direction;

    function hide() {
        container.removeClass("move-left move-right");
        canvasDirection = "";
        setTimeout(function () {
            container.removeClass("offscreen")
        }, 300)
    }

    function toggle(direction) {
        if (direction !== undefined && direction === "rtl") {
            container.addClass("offscreen move-right").removeClass("move-left");
            canvasDirection = "rtl"
        } else {
            container.addClass("offscreen move-left").removeClass("move-right");
            canvasDirection = "ltr"
        }
    }

    function fixSlimScroll() {
        if (!$.browser.mobile && !ns.view.checkBreakout()) {
            if (canvasDirection === "ltr") {
                if ($(".offscreen-left").find(".slimScrollDiv").length !== 0) {
                    $(".offscreen-left").find(".main-navigation, .slimscroll").slimScroll({height: "auto"})
                }
            }
            if (canvasDirection === "rtl") {
                if ($(".offscreen-right").find(".slimScrollDiv").length !== 0) {
                    $(".offscreen-right").find(".main-navigation, .slimscroll").slimScroll({height: "auto"})
                }
            }
        }
    }

    function events() {
        $("[data-toggle=offscreen]").on("click touchstart", function (e) {
            e.preventDefault();
            e.stopPropagation();
            direction = $(this).data("move");
            if (direction === canvasDirection) {
                hide();
                return
            }
            toggle(direction);
            fixSlimScroll()
        });
        $(".exit-offscreen").on("click touchstart", function (e) {
            e.preventDefault();
            e.stopPropagation();
            hide()
        })
    }

    return {
        hide: hide, init: function () {
            events()
        }
    }
}();
var ns = function () {
    var searchOpen = false,
        app = $(".app"),
        maxHeight = 0;

    function events() {
        $(".offscreen-left, .main-navigation").ontouchstart = function () {
        };
        $(".accordion > dd").hide();
        $(window).resize(function () {
            equalHeightWidgets();
            if (!$.browser.mobile && !checkBreakout()) {
                $(".no-touch .main-navigation").slimScroll({
                    height: "auto"
                });
                $(".no-touch .slimscroll").slimScroll({
                    height: "auto"
                });
                initFooterFix();
            }
            ns.view.initContentWrap();
            ns.view.initDropdownMenuDirection();
            //记录窗口大小变化量
            ns.resizeDiff = {
                width: $(document).width() - ns.lastDocumentWidth,
                height: $(document).height() - ns.lastDocumentHeight
            }
            ns.lastDocumentHeight = $(document).height();
            ns.lastDocumentWidth = $(document).width();
            //记录窗口大小变化量 END
        });
        $(document).mouseup(function () {
            if (searchOpen === true) {
                $(".toggle-search").click()
            }
        });
        $(".toggle-search").mouseup(function () {
            return false
        });
        $(".header-search").mouseup(function () {
            return false
        });
    }

    function checkBreakout() {//界面样式检测
        var state = false;
        if (app.hasClass("small-menu") || app.hasClass("fixed-scroll")) {
            state = true;
        }
        return state;
    }

    function initAnimationAPI() {//UI动画
        if (!$.browser.mobile && $.fn.appear) {
            $("[data-animation]").appear({interval: 100});
            $("[data-animation]").on("appear", function () {
                var elm = $(this),
                    animation = elm.data("animation") || "fadeIn",
                    delay = elm.data("delay") || 0;
                if (!elm.hasClass("done")) {
                    setTimeout(function () {
                        elm.addClass("animated " + animation + " done")
                    }, delay)
                }
            })
        } else {
            sh
            $("[data-animation]").each(function () {
                var elm = $(this),
                    animation = elm.data("animation") || "fadeIn";
                if (!elm.hasClass("done")) {
                    elm.addClass("animated " + animation + " done");
                }
            })
        }
    }

    function initAnimateProgressBars() {//进度条动画
        if (!$.browser.mobile && $.fn.appear) {
            $(".progress-bar").appear();
            $(".progress-bar").on("appear", function () {
                var elm = $(this),
                    percent = elm.data("percent");
                if (!elm.hasClass("done")) {
                    elm.addClass("done").css("width", Math.ceil(percent) + "%")
                }
            })
        } else {
            $(".progress-bar").each(function () {
                var elm = $(this),
                    percent = elm.data("percent");
                if (!elm.hasClass("done")) {
                    elm.addClass("done").css("width", Math.ceil(percent) + "%")
                }
            })
        }
    }

    function initBrowserFix() {//修复火狐样式
        if (navigator.userAgent.search("Firefox") >= 0) {
            $(".layout > aside, .layout > section").wrapInner(
                '<div class="fffix"/>')
        }
    }

    function initFuelUX() {//初始化
        if ($.isFunction($.fn.wizard)) {
            $(".wizard").wizard()
        }
        if ($.isFunction($.fn.pillbox)) {
            $(".pillbox").pillbox()
        }
        if ($.isFunction($.fn.spinner)) {
            $(".spinner").spinner()
        }
    }

    function equalHeightWidgets() {//计算高度
        $(".equal-height-widgets").each(function () {
            maxHeight = 0;
            $(this).find(".widget").each(function () {
                if ($(this).innerHeight() > maxHeight) {
                    maxHeight = $(this).innerHeight();
                }
            });
            $(this).find(".widget").each(function () {
                $(this).height(maxHeight);
            });
        });
    }

    function initPlacehoderFallback() {//初始化placeholder
        $("input, textarea").placeholder()
    }

    function initHeaderSearch() {//初始化头部搜索
        $(document).on("click", ".toggle-search", function () {
            if (!searchOpen) {
                $(".header-search").addClass("open");
                $(".search-container .search").focus();
                searchOpen = true
            } else {
                $(".header-search").removeClass("open");
                $(".search-container .search").focusout();
                searchOpen = false
            }
        });
    }

    function initMenuCollapse() {//初始化系统菜单
        $(document).on("click", ".main-navigation a", function (e) {
            var links = $(this).parents('li'),
                parentLink = $(this).closest("li"),
                otherLinks = $('.main-navigation li').not(links),
                subMenu = $(this).next();
            if (!subMenu.hasClass("sub-menu")) {
                offscreen.hide();
                return;
            }
            if (app.hasClass("small-menu") && parentLink.parent().hasClass("nav") && $(window).width() > 767) {
                return;
            }
            otherLinks.removeClass('open');
            otherLinks.find('.sub-menu').slideUp();
            if (subMenu.is("ul") && (!subMenu.is(":visible")) && (!app.hasClass("small-sidebar"))) {
                subMenu.slideDown();
                parentLink.addClass("open");
            } else if (subMenu.is("ul") && (subMenu.is(":visible")) && (!app.hasClass("small-sidebar"))) {
                parentLink.removeClass("open");
                subMenu.slideUp();
            }
            if ($(this).hasClass('active') === false) {
                $(this).parents("ul.dropdown-menu").find('a').removeClass('active');
                $(this).addClass('active');
            }
            if ($(this).attr('href') === '#') {
                e.preventDefault();
            }
            if (subMenu.is("ul")) {
                return false;
            }
            e.stopPropagation();
            return true;
        });
        $(".main-navigation > .nav > li.open").each(function () {
            $(".sub-menu").hide();
            $(this).children(".sub-menu").show();
            $(this).find("li.open").children(".sub-menu").show();
        });
        $(".no-touch .main-navigation, .no-touch .slimscroll").each(function () {
            if (checkBreakout() || app.hasClass("fixed-scroll") || $.browser.mobile) {
                return;
            }
            var data = $(this).data();
            $(this).slimScroll(data);
        });
        if (!$.browser.mobile) {
            //自动添加滚动条，除非有no-scroll样式
            // $(".notifications .dropdown-menu .panel .content,.content-wrap .wrapper").each(function () {
            //     if (!$(this).hasClass("no-scroll")) {
            //         $(this).slimScroll({
            //             alwaysVisible: false
            //         });
            //     }
            // });
        }

    }

    function initToggleActiveState() {//切换active样式
        $(document).on("click touchstart", ".toggle-active", function (e) {
            $(this).toggleClass("active");
            e.preventDefault();
            e.stopPropagation()
        })
    }

    function initToggleSidebar() {//展开/收缩菜单
        $(document).on("click touchstart", ".toggle-sidebar", function (e) {
            e.preventDefault();
            e.stopPropagation();
            if (app.hasClass("small-menu")) {
                app.removeClass("small-menu");
                if (!$.browser.mobile && !checkBreakout() && $.fn.slimScroll) {
                    $(".no-touch .main-navigation").each(function () {
                        var data = $(this).data();
                        $(this).slimScroll(data)
                    })
                }
            } else {
                if (!app.hasClass("small-menu")) {
                    app.addClass("small-menu");
                    $(".main-navigation").each(function () {
                        $(this).slimScroll({
                            destroy: true
                        }).removeAttr("style")
                    })
                }
            }
            var cls = $(".app").attr("class");
            cls = jQuery.trim(cls.replace("app", ""));
            ns.post(ns.getBasePath() + "/index/changelayout", {layout: cls});
            if (top.Tabs) {
                //Tabs自适应宽高
                setTimeout(function () {
                    top.Tabs.resize();
                }, 500);
            }
        })
    }

    function initToggleVertical() {// 切换菜单显示模式
        $(document).on("click touchstart", ".toggle-vertical", function (e) {
            app.toggleClass($(this).attr("layout"));
            e.preventDefault();
            e.stopPropagation();
            var cls = $(".app").attr("class");
            cls = jQuery.trim(cls.replace("app", ""));
            ns.post(ns.getBasePath() + "/index/changelayout", {layout: cls}, function () {
                window.location.reload()
            });
        });
        //初始化二级菜单显示
        $("ul.vertical li>ul>li a").hover(function (e) {
            $(this).parent().parent().find(".open:first").removeClass("open");
            if ($(this).attr("data-toggle")) {
                var submenu = $(this).next();
                submenu.css("left", submenu.width());
                submenu.css("top", $(this).offset().top - 52);
                $(this).parent().addClass("open");
            }
        }, function () {
        });
    }

    function initContentWrap() {//自适应高度
        $("aside, .main-content").each(function () {
            var height = $(document).height();
            height -= $(".app>header").height();
            //自适应高度
            if ($(this).find("header").length > 0) {
                height -= $(this).find("header").height();
            }
            if ($(this).find("footer").length > 0) {
                height -= $(this).find("footer").height();
            }

            $(this).find(".content-wrap .wrapper").css("minHeight", height);
            $(this).find(".content-wrap .wrapper").css("top", $(this).find("header").height());
        });
        //全屏
        $(".content-wrap .wrapper-full").css("minHeight", $(document).height());
    }

    function initFooterFix() {//footer底部固定
        $("footer").each(function () {
            var footerHeight = $(this).outerHeight();
            if ($(this).prev().hasClass("content-wrap")) {
                $(this).prev().find(".wrapper").css("bottom",
                    footerHeight)
            } else {
                if ($(this).prev().hasClass("slimScrollDiv")) {
                    $(this).prev().find(".main-navigation").css(
                        "padding-bottom", footerHeight)
                } else {
                    if ($(this).prev().hasClass("main-navigation")) {
                        $(this).prev().css("bottom", footerHeight)
                    }
                }
            }
        })
    }

    function initSlider() {
        if ($.isFunction($.fn.slider)) {
            $(".sliders input").slider()
        }
    }

    function initExtPrototype() {
        Array.prototype.contains = function (item) {
            return RegExp(item).test(this);
        };
        String.prototype.startsWith = function (str) {
            var reg = new RegExp("^" + str);
            return reg.test(this);
        };
        String.prototype.endsWith = function (str) {
            var reg = new RegExp(str + "$");
            return reg.test(this);
        };
        String.prototype.trim = function () {
            return this.replace(/(^\s*)|(\s*$)/g, "");
        };
        String.prototype.replaceAll = function (source, target) {
            var val = this;
            while (val.indexOf(source) > -1) {
                val = val.replace(source, target);
            }
            return val;
        };
        Array.prototype.remove = function (dx) {
            if (isNaN(dx) || dx > this.length) {
                return false;
            }
            for (var i = 0, n = 0; i < this.length; i++) {
                if (this[i] != this[dx]) {
                    this[n++] = this[i]
                }
            }
            this.length -= 1
        }
    }

    function initDropdownMenuDirection() {// 初始化下拉菜单方向，上下左右
        $(".btn-group>.dropdown-menu").each(function (i, n) {
            var w = $(this).width() + 15;//15为padding
            var h = $(this).height();
            var l = $(this).prev().offset().left;
            var t = $(this).prev().offset().top;
            var sw = $(document).width();
            var sh = $(document).height();

            if (w + l > sw) {//控制横向
                if (!$(this).hasClass("pull-right"))
                    $(this).addClass("pull-right");
            } else {
                $(this).removeClass("pull-right");
            }
            if (h + t + 15 > sh) {//控制纵向
                if (!$(this).parent().hasClass("dropup"))
                    $(this).parent().addClass("dropup");
            } else {
                $(this).parent().removeClass("dropup");
            }
            //控制子项
            if (w + l + 160 > sw) {
                $(this).find("li.dropdown-submenu").addClass("left");
            } else {
                $(this).find("li.dropdown-submenu").removeClass("left");
            }
        });
    }

    //选项卡链接
    function initTabsLink() {
        $("a[data-tabs-link], a.tabs-link").each(function (i, n) {
            $(n).unbind("click");
            $(n).bind("click", function () {
                var target = $(this);
                var link = target.attr("data-tabs-link") || target.attr("href");
                var title = target.attr("data-tabs-title") || target.attr("title") || target.text();
                var icon = target.attr("data-tabs-icon") || target.attr("icon") || "fa fa-file";

                if (top.Tabs) {
                    top.Tabs.add(link, title, icon);
                } else {
                    if (target.attr("target") == "_blank")
                        window.open(link);
                    else
                        window.location.href = link;
                }

            });
            var link = $(n).attr("data-tabs-link") || $(n).attr("href");
            $(n).attr("data-tabs-link", link);
            $(n).attr("href", "javascript:;");
            $(n).removeAttr("target");
        });
    }

    //box展开/收缩、关闭功能
    function initBoxTrigger() {
        $("[data-box-trigger='collapse']").on("click", function () {
            var a = $(this),
                c = $(this).parents(".box").first(),
                d = c.find("> .box-body, > .box-footer, > form  >.box-body, > form > .box-footer");
            c.hasClass("collapsed-box") ? (a.children(":first").removeClass("fa-plus").addClass("fa-minus"), d
                    .slideDown(500, function () {
                        c.removeClass("collapsed-box")
                    })) : (a.children(":first").removeClass("fa-minus").addClass("fa-plus"), d.slideUp(500, function () {
                    c.addClass("collapsed-box")
                }))
        });
        $("[data-box-trigger='remove']").on("click", function () {
            alert("123");
            $(this).parents(".box").remove()
        });
    }

    return {
        getBasePath: function () { //项目路径
            var path = $("#__basePath").val();
            if (path == undefined)
                path = "/nspms";
            return path;
        },
        readyEvents: [],
        checkBreakout: checkBreakout,
        initContentWrap: initContentWrap,
        initDropdownMenuDirection: initDropdownMenuDirection,//下拉菜单方向
        initTabsLink: initTabsLink,
        init: function () {
            events();
            initAnimationAPI();
            initAnimateProgressBars();
            initHeaderSearch();
            // initBrowserFix();
            initMenuCollapse();
            initToggleActiveState();
            initToggleSidebar();
            initToggleVertical();
            initContentWrap();
            initFooterFix();
            equalHeightWidgets();
            initFuelUX();
            initPlacehoderFallback();
            initSlider();
            initDropdownMenuDirection();//下拉菜单方向
            initTabsLink();
            initExtPrototype();
            initBoxTrigger();
        },
        initCustomControls: function () {//页面自定义组件初始化
            if (ns.view.initDropdownMenuDirection) ns.view.initDropdownMenuDirection();
            if (ns.view.initTabsLink) ns.view.initTabsLink();
            if (ns.form.initChosen) ns.form.initChosen();
            if (ns.form.initDatePicker) ns.form.initDatePicker();
            if (ns.form.initCheckbox) ns.form.initCheckbox();
        },
        initPreLoad: function () { //预加载
            if (typeof(top.swal) != "function") {//位置问题，页面加载完成后，预加载
                top.ns.requireCSS("/framework/plugins/sweetalert/sweetalert.css");
                top.ns.requireJS("/framework/plugins/sweetalert/sweetalert.min.js");
            }
        },
        showProgress: function (obj) { //显示等待
            obj = obj || top.$("body");
            obj.prepend(
                "<div class=\"gallery-loader\" style=\"background-color:transparent;\"><div class=\"loader\"></div></div>");

            setTimeout(function () {
                ns.closeProgress(obj);
            }, 5000);//5s后自动关闭
        },
        closeProgress: function (obj) { //显示关闭
            obj = obj || top.$("body");
            obj.find(".gallery-loader").fadeOut(function () {
                obj.find(".gallery-loader").remove();
            });
        },
        showProgressbar: function (title) {
            top.ns.requireJS("/framework/js/view/dialog.js");
            var id = "__divAlert" + new Date().getTime();
            var content = "<div class=\"progress progress-striped active\"> <div class=\"progress-bar progress-bar-info done\" style=\"width: 0%\"><span class=\"sr-only\">20% Complete</span> </div> </div>";
            var options = {
                id: id,
                title: title,
                content: "<div class='p10'>" + content + "</div>",
                showHeader: true
            };
            var interval;
            options.onShown = function (dialog, target) {
                var width = (5 + Math.random() * 30);
                interval = setInterval(function () {
                    width = width + 10;
                    if (width < 100) {
                        dialog.find(".progress-bar").width(width + "%");
                    } else {
                        dialog.find(".progress-bar").width("101%");
                        clearInterval(interval);
                    }
                }, 1000);
                $(".progress-bar").attr("interval", interval);
            }
            var modal = new top.ns.view.Dialog(options);
            var $obj = modal.show();

            $obj.close = function () {
                $(this).modal("hide");
                clearInterval(interval);
            };
            return $obj;
        },
        showLoadingbar: function (obj) { //显示顶部进度条
            var clz = "waiting";
            if (!obj) {
                clz += " full";
            }
            if (typeof (obj) == "string")
                obj = $(obj);
            obj = obj || $("body");
            obj.prepend("<div id=\"loadingbar\"></div>");
            $("#loadingbar").addClass(clz).append($("<dt/><dd/>"));
            var width = (15 + Math.random() * 30);
            $("#loadingbar").width(width + "%");
            var interval = setInterval(function () {
                width = width + 10;
                if (width < 100) {
                    $("#loadingbar").width(width + "%");
                } else {
                    $("#loadingbar").width("101%");
                    clearInterval(interval);
                }
            }, 1000);
            $("#loadingbar").attr("interval", interval);

            //超时自动隐藏
            setTimeout(function () {
                ns.closeLoadingbar(obj);
            }, 5000);
        },
        closeLoadingbar: function (obj) { //关闭顶部进度条
            if (typeof (obj) == "string")
                obj = $(obj);
            obj = obj || $("body");
            obj.find("#loadingbar").width("101%").delay(200).fadeOut(400, function () {
                var interval = $(this).attr("interval");
                clearInterval(interval);
                $("#loadingbar").remove();
            });
        },
        alert: function (content, ok) { //提示
            top.ns.requireJS("/framework/js/view/dialog.js");
            var id = "__divAlert" + new Date().getTime();
            var options = {
                id: id,
                content: "<div class='modal-alert col-lg-12 col-md-12 col-xs-12'>" + content + "</div>",
                showFooter: true
            };
            if (content.length <= 18)
                options.size = "modal-sm";

            options.onShown = function (dialog, target) {
                dialog.find("#ok").focus();
                dialog.find("#ok").click(function () {
                    dialog.modal("hide");
                    dialog.ok = true;
                });
            }
            options.onHidden = function (dialog, target) {
                if (dialog.ok && typeof (ok) == "function") {
                    ok();
                }
            }
            var modal = new top.ns.view.Dialog(options);
            return modal.show();
        },
        confirm: function (content, ok, cancel) { //确认框
            top.ns.requireJS("/framework/js/view/dialog.js");
            var id = "__divConfirm" + new Date().getTime();
            var options = {
                id: id,
                content: "<div class='modal-alert col-lg-12 col-md-12 col-xs-12'>" + content + "</div>",
                showFooter: true,
                showCancel: true
            };
            if (content.length <= 18)
                options.size = "modal-sm";

            options.onShown = function (dialog, target) {
                dialog.find("#ok").focus();
                dialog.find("#ok").click(function () {
                    dialog.ok = true;
                    dialog.modal("hide");
                });
                if (typeof (cancel) == "function") {
                    dialog.find("#cancel").bind("click", function () {
                        cancel()
                    });
                }
            }
            options.onHidden = function (dialog, target) {
                if (dialog.ok && typeof (ok) == "function") {
                    ok();
                }
            }
            var modal = new top.ns.view.Dialog(options);
            return modal.show();
        },
        prompt: function (title, ok, cancel) {
            top.ns.requireJS("/framework/js/view/dialog.js");
            var id = "__divPrompt" + new Date().getTime();
            var options = {
                id: id,
                title: title,
                content: "<div class='col-lg-12 col-md-12'><textarea class='form-control' autofocus></textarea></div>",
                showHeader: true,
                showFooter: true,
                showCancel: true
            };

            options.onShown = function (dialog, target) {
                dialog.find("textarea").focus();
                dialog.find("#ok").click(function () {
                    dialog.modal("hide");
                    dialog.ok = true;
                });
                if (typeof (cancel) == "function") {
                    dialog.cancel = true;
                }
            }
            options.onHidden = function (dialog, target) {
                if (dialog.ok && typeof(ok) == "function")
                    ok(dialog.find("textarea").val());
                if (dialog.cancel && typeof(cancel) == "function")
                    cancel();
            }
            var modal = new top.ns.view.Dialog(options);
            return modal.show();
        },
        success: function (title, msg, fun) {
            if (typeof(top.swal) != "function") {
                top.ns.requireCSS("/framework/plugins/sweetalert/sweetalert.css");
                top.ns.requireJS("/framework/plugins/sweetalert/sweetalert.min.js");
            }
            if ($.isFunction(msg)) {
                fun = msg;
                msg = "";
            }
            top.swal({
                title: title,
                text: msg,
                type: "success"
            }, fun)
        },
        error: function (title, msg, fun) {
            if (typeof(top.swal) != "function") {
                top.ns.requireCSS("/framework/plugins/sweetalert/sweetalert.css");
                top.ns.requireJS("/framework/plugins/sweetalert/sweetalert.min.js");
            }
            if ($.isFunction(msg)) {
                fun = msg;
                msg = "";
            }
            top.swal({
                title: title,
                text: msg,
                type: "error"
            }, fun)
        },
        __showImage: function (images) {
            top.ns.requireJS("/framework/js/view/dialog.js");
            var imgs = [];
            if (typeof(images) == "string") {
                imgs.push(images);
            } else {
                imgs = images;
            }
            var w = 4;
            if (imgs.length < 3)
                w = 12 / imgs.length;
            var content = "<div class='image-modal p10'>";
            for (var i = 0; i < imgs.length; i++) {
                content += "<div class='col-xs-" + w + "'><img class='m3' src='" + imgs[i] + "'/></div>";
            }
            content += "</div>";
            var id = "__divImageModal" + new Date().getTime();
            var options = {
                id: id,
                content: content,
                showFooter: true
            };

            options.onShown = function (dialog, target) {
                dialog.find("#ok").focus();
                dialog.find("#ok").click(function () {
                    dialog.modal("hide");
                });
            }
            var modal = new top.ns.view.Dialog(options);
            return modal.show();
        },
        __showModal: function (url, options) { //显示弹窗
            top.ns.requireJS("/framework/js/view/dialog.js");
            var id = "__divModal" + new Date().getTime();
            var _def = {
                id: id,
                remote: true,
                remoteUrl: url,
                size: "",
                border: false,
                theme: "",
                onShown: function () {
                },
                onHidden: function () {
                }
            };
            options = $.extend(_def, options);
            options.onLoaded = function (dialog, target) {
                // $(target).find("script[src]").each(function (i, n) {
                //     ns.requireJS($(n).attr("src"));
                // });
                top.ns.execReadyEvents();
                top.ns.initCustomControls();
            }
            var modal = new top.ns.view.Dialog(options);
            return modal.show();
        },
        __notify: function () {
            $.get(ns.getBasePath() + "/system/notify/header", {}, function (data) {
                var oNotify = $(".notifications ul");
                oNotify.html(data);
            });
            //移除点击方法
            //$(".notifications a:first").removeAttr("onclick");
        },
        __readNotify: function (id, obj) {
            $.post(ns.getBasePath() + "/system/notify/read", {
                id: id
            }, function (data) {
                $(obj).find("a").css("color", "#ccc");
                $(obj).removeAttr("onclick");

                // 提示数字减1
                var number = $(".notifications .badge span").text();
                number = parseInt(number);
                number = number - 1;
                if (number <= 0) {
                    $(".notifications .badge").hide();
                } else {
                    $(".notifications .badge span").text(number);
                }
            });
        },
        get: function (url, callback) {
            jQuery.ajax({
                type: "GET",
                url: url,
                success: function (data) {
                    if (typeof(callback) != "function") return;
                    var success = true;
                    if (data.success == false) {
                        success = false;
                    }
                    callback(success, data);
                },
                error: function (xhr, msg, e) {
                    if (typeof(callback) != "function") return;
                    var data = {success: false, error: "请求异常:" + xhr.status + " " + e};
                    callback(false, data);
                }
            });
        },
        /**
         * 异步提交 POST方式
         * @param 地址
         * @param 参数列表
         * @param 回调函数，成功时第一个参数为true，失败是false， 第二个参数为服务器返回的数据
         * @returns
         */
        post: function (url, param, callback) { //异步Post提交
            jQuery.ajax({
                type: "POST",
                url: url,
                data: param,
                success: function (data) {
                    if (typeof(callback) != "function") return;
                    var success = true;
                    if (data.success == false) {
                        success = false;
                    }
                    callback(success, data);
                },
                error: function (xhr, msg, e) {
                    if (typeof(callback) != "function") return;
                    var data = {success: false, error: "请求异常:" + xhr.status + " " + e};
                    callback(false, data);
                }
            });
        },
        syncGet: function (url, callback) {
            jQuery.ajax({
                type: "GET",
                url: url,
                cache: false,
                async: false,
                success: function (data) {
                    if (typeof(callback) != "function") return;
                    var success = true;
                    if (data.success == false) {
                        success = false;
                    }
                    callback(success, data);
                },
                error: function (xhr, msg, e) {
                    if (typeof(callback) != "function") return;
                    var data = {success: false, error: "请求异常:" + xhr.status + " " + e};
                    callback(false, data);
                }
            });
        },
        syncPost: function (url, param, callback) {
            jQuery.ajax({
                type: "POST",
                url: url,
                data: param,
                cache: false,
                async: false,
                success: function (data) {
                    if (typeof(callback) != "function") return;
                    var success = true;
                    if (data.success == false) {
                        success = false;
                    }
                    callback(success, data);
                },
                error: function (xhr, msg, e) {
                    if (typeof(callback) != "function") return;
                    var data = {success: false, error: "请求异常:" + xhr.status + " " + e};
                    callback(false, data);
                }
            });
        },
        load: function (elementId, url, param, callback) {
            if ($(elementId).length == 0) return ns.tip.alert("<i class='fa fa-close text-danger'></i> DOM对象不存在！");
            $(elementId).load(url, param, callback);
        },
        /**
         * 异步获取内容，并加载到页面上
         * @param 地址
         * @param 参数列表
         * @param 目标对象ID
         * @param 加载完成后的回调函数
         * @returns
         */
        asyncRequest: function (url, param, elementId, fn) {
            ns.showLoadingbar(".main-content");
            var timer = setTimeout(function () {
                $(elementId).html(ns.tip.progress.wave());
            }, 100);//延迟显示，提高网速顺畅时的浏览体验
            jQuery.post(url, param, function (data) {
                clearTimeout(timer);
                if (typeof(data) == "string") {
                    var idx = data.indexOf("<HTML".toLowerCase());
                    if (idx >= 0)
                        data = data.substring(data.indexOf("<HTML".toLowerCase()));
                    if (elementId) {
                        var content = idx >= 0 ? $(elementId, data).html() : data;
                        $(elementId).html(content);
                        if ($.support.pjax) {
                            $(elementId).pjax('a[data-pjax]', '.container', {
                                maxCacheLength: 0,
                                push: false,
                                replace: true,
                                fragment: '.container',
                                timeout: 8000
                            })
                        }
                        if (typeof (fn) == "function")
                            fn(true);
                    } else {
                        if (typeof (fn) == "function")
                            fn(false);
                    }
                    ns.execReadyEvents();
                    ns.initCustomControls();
                } else {
                    $(elementId).html("<i class='fa fa-close text-danger'></i> 请求地址返回数据格式不被支持！");
                }
                ns.closeLoadingbar(".main-content");
            });
        },
        /**
         * 获取form参数列表
         * @param form
         * @returns
         */
        formAttrs: function (form) {
            var attrs = {};
            if (typeof(form) == "string")
                form = $(form);
            var elements = form.find("*[name]");
            $.each(elements, function (i, e) {
                e = $(e);
                if (e.attr("type") == "radio" || e.attr("type") == "checkbox") {
                    if (e.is(":checked")) {
                        attrs[e.attr("name")] = e.val();
                    }
                } else {
                    attrs[e.attr("name")] = e.val();
                }
            });
            return attrs;
        },
        back: function (url, delay) { //延迟返回指定路径
            setTimeout(function () {
                window.location.href = url;
            }, delay);
        },
        requireJS: function (url) {//导入js
            var urls = [];
            if (typeof(url) == "string")
                urls.push(url);
            else
                urls = url;
            while (urls.length > 0) {
                url = urls.shift();
                if (url && url.startsWith("http")) {
                    url = url.substring(url.indexOf(ns.getBasePath()));
                }
                if (url && !url.startsWith(ns.getBasePath())) {
                    if (!url.startsWith("/"))
                        url = "/" + url;
                    url = ns.getBasePath() + url;
                }
                $("script[src='" + url + "']").remove();//删除重复
                $("body").append("<script src=\"" + url + "\"></script>");//重新引用
            }
            ns.execReadyEvents();
        },
        requireCSS: function (url) {//导入css
            var urls = [];
            if (typeof(url) == "string")
                urls.push(url);
            else
                urls = url;
            while (urls.length > 0) {
                url = urls.shift();
                if (url.startsWith("http")) {
                    url = url.substring(url.indexOf(ns.getBasePath()));
                }
                if (!url.startsWith(ns.getBasePath())) {
                    if (!url.startsWith("/"))
                        url = "/" + url;
                    url = ns.getBasePath() + url;
                }
                var isLoaded = false;
                $("link").each(function () {
                    var href = $(this).attr("href") + "";
                    if (href.endsWith(url)) {
                        isLoaded = true;
                        return false;
                    }
                });
                if (!isLoaded)
                    $("head").prepend("<link rel=\"stylesheet\" href=\"" + url + "\">");
            }
        },
        ready: function (fun) {
            if (typeof(fun) == "function") {
                top.ns.readyEvents.push(fun);
                // console.log("readyEvents:"+top.ns.readyEvents.length);
            }
        },
        clearReadyEvents: function () {
            top.ns.readyEvents = [];
        },
        execReadyEvents: function () {
            while (top.ns.readyEvents.length > 0) {
                try {
                    top.ns.readyEvents.shift()();
                } catch (e) {
                    alert("main:" + e);
                }
            }
            top.ns.clearReadyEvents();
        }
    }
}();
//添加到事件池中
ns.ready(function () {
    $.ajaxSetup({
        cache: true
    });
    ns.init();//页面加载完初始化
    ns.tip = { //提示组件
        alert: ns.alert,
        confirm: ns.confirm,
        prompt: ns.prompt,
        success: ns.success,
        error: ns.error,
        tooltip: {},
        toast: {},
        progress: {//进度提示
            wave: function () {
                var html = "<div class='sk-wave'>";
                for (var i = 0; i < 5; i++) html += "<div class='sk-rect sk-rect" + (i + 1) + "'></div>";
                return html + "</div>";
            },
            circle: function () {
                var html = "<div class='sk-circle'>";
                for (var i = 0; i < 12; i++) html += "<div class='sk-circle" + (i + 1) + " sk-child'></div>";
                return html + "</div>";
            }
        }
    };
    ns.view = { //视图组件
        checkBreakout: ns.checkBreakout,
        initContentWrap: ns.initContentWrap, //自适应高度
        initDropdownMenuDirection: ns.initDropdownMenuDirection,//自适应下拉菜单方向
        initTabsLink: ns.initTabsLink,//选项卡链接
        showProgress: ns.showProgress, //显示进度提示
        closeProgress: ns.closeProgress, //显示进度提示
        showProgressbar: ns.showProgressbar,//显示进度条
        showLoadingbar: ns.showLoadingbar, //显示顶部进度提示
        closeLoadingbar: ns.closeLoadingbar, //关闭顶部进度提示
        showModal: ns.__showModal,//显示模态窗口
        showImage: ns.__showImage,//显示图片
        tooltip: function (element, msg) {
            element.tooltip({title: msg});
            element.tooltip("show");
        },
        showSidebarStatic: function (elementId, options) {//显示页面上已有的侧边栏
            var _def = {
                width: "400px"
            };
            options = $.extend(_def, options);
            if ($.browser.mobile) {
                options.width = "300px";
            }
            var sidebar = $(elementId);
            var container = sidebar.find(".sidebar-panel-container");
            container.css("width", options.width);
            container.find(".sidebar-panel-content").css("height", container.height() - container.find(".sidebar-panel-header").height());
            if ($(".main-content>header").length == 0)
                sidebar.find(".sidebar-panel-container").css("marginTop", "0px");
            sidebar.unbind("click");
            sidebar.bind("click", function (event) {
                if ($(event.target).is('.sidebar-panel') || $(event.target).is('.sidebar-panel-close')) {
                    sidebar.removeClass('is-visible');
                    event.preventDefault();
                }
            });
            sidebar.find("header>a").bind("click", function () {
                sidebar.click();
            });
            sidebar.addClass('is-visible');
            sidebar.find("[autofocus]:first").focus();

            sidebar.hide = function () {
                this.removeClass("is-visible");
            }
            return sidebar;
        },
        showSidebarRemote: function (url, param, options) {//创建并加载远程侧边栏
            var _def = {
                direction: "right",//来源方向
                title: "标题",//标题
                width: "400px",
                callback: function () {
                }
            };
            options = $.extend(_def, options);

            var id = "sidebar-panel-" + (new Date()).getTime();
            var panel = "<div id=\"" + id + "\" class=\"sidebar-panel from-" + options.direction + "\">";
            panel += "<div class=\"sidebar-panel-container shadow\" style=\"width:" + options.width + "\">";
            panel += "<header class=\"sidebar-panel-header\"><h4>" + options.title + "</h4><a href=\"javascript:;\" class=\"sidebar-panel-close text-center\"><i class=\"ti-close\"></i> </a></header>";
            panel += "<div class=\"sidebar-panel-content\">";
            panel += ns.tip.progress.circle();
            panel += "</div></div></div>";

            $("body").append(panel);
            //延迟显示
            setTimeout(function () {
                $("#" + id + " header>a").bind("click", function () {
                    $("#" + id).click();
                    setTimeout(function () {
                        $("#" + id).remove();
                    }, 500);
                });
                ns.view.showSidebarStatic("#" + id, options);
            }, 100);

            ns.load("#" + id + " .sidebar-panel-content", url, param, options.callback);
            return $("#" + id);
        },
        animate: function (obj, animate) {//动画
            $(obj).addClass(animate + " animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
                $(this).removeClass(animate + " animate");
            });
        }
    };
    ns.form = { //form组件
        post: ns.post,
        asyncRequest: ns.asyncRequest,
        formAttrs: ns.formAttrs, //获取form表单中的参数，返回json
        check: function (target) {
        }/*checkbox选择、全选/反选，具体实现在form/checkbox.js中*/
    };
    ns.data = { //数据存储
        localStorage: {//本地存储，永久有效
            set: function (key, value) {
                if (window.localStorage) {
                    key = "ns$ls$" + key;
                    window.localStorage.removeItem(key);
                    window.localStorage.setItem(key, value);
                }
            },
            get: function (key) {
                if (window.localStorage) {
                    key = "ns$ls$" + key;
                    return window.localStorage.getItem(key);
                }
            },
            remove: function (key) {
                if (window.localStorage) {
                    key = "ns$ls$" + key;
                    window.localStorage.removeItem(key);
                }
            },
            clear: function () {
                if (window.localStorage) {
                    window.localStorage.clear();
                }
            }
        },
        sessionStorage: {//本地存储，会话有效
            set: function (key, value) {
                if (window.sessionStorage) {
                    key = "ns$ss$" + key;
                    window.sessionStorage.removeItem(key);
                    window.sessionStorage.setItem(key, value);
                }
            },
            get: function (key) {
                if (window.sessionStorage) {
                    key = "ns$ss$" + key;
                    return window.sessionStorage.getItem(key);
                }
            },
            remove: function (key) {
                if (window.sessionStorage) {
                    key = "ns$ss$" + key;
                    window.sessionStorage.removeItem(key);
                }
            },
            clear: function () {
                if (window.sessionStorage) {
                    window.sessionStorage.clear();
                }
            }
        },
        cookie: {
            _init: function () {
                if (typeof(setCookie) != "function") {
                    ns.requireJS("/framework/js/plugins/zframe.cookie.js")
                }
            },
            set: function (name, value, time) {
                ns.data.cookie._init();
                name = "ns$cookie$" + name;
                delCookie(name);
                setCookie(name, value, time);
                return true;
            },
            get: function (name) {
                ns.data.cookie._init();
                name = "ns$cookie$" + name;
                return getCookie(name);
            },
            remove: function (name) {
                ns.data.cookie._init();
                name = "ns$cookie$" + name;
                delCookie(name);
                return true;
            }
        },
        copy: function (data) {
            if (window.clipboardData) {
                window.clipboardData.setData("text", data);
                ns.tip.alert("复制成功！");
            } else {
                ns.tip.alert("您的浏览器不支持复制到粘贴板！");
            }
        }
    };
    ns.event = {// events
        move: function (target) {
            var header = target.find(".modal-header");
            header.css("cursor", "move");
            var move = false;//移动标记
            var _x, _y;//鼠标离控件左上角的相对位置
            header.bind("mousedown", function (e) {
                move = true;
                _x = e.pageX - parseInt(target.css("left"));
                _y = e.pageY - parseInt(target.css("top"));
            });
            header.bind("mouseup", function (e) {
                move = false;
            });
            header.bind("mousemove", function (e) {
                if (move) {
                    var x = e.pageX - _x;//控件左上角到屏幕左上角的相对位置
                    var y = e.pageY - _y;
                    target.css({"top": y, "left": x});
                }
            });
        }
    };
    ns.debug = { //debug
        each: function (obj) {
            $.each(obj, function (i, n) {
                alert(i + ":" + n);
            });
        }
    };
    ns.String = {
        //字符串格式化，占位符
        //str：字符串
        //params Array
        format : function(str, params){
            for(var i=0;i<params.length;i++){
                str = str.replace("%s", params[i])
            }
            return str;
        }
    }
    /**************业务相关**************/
    ns.userCenter = function () { //个人中心
        ns.__showModal(ns.getBasePath() + "/uc", {border: false});
    };
    ns.setting = function () { //设置
        ns.tip.alert("此功能暂未开放！");
    };
    ns.checkUpdate = function () {
        ns.tip.alert("当前无可用更新！");
    };
    ns.exit = function () {
        var exitObj = ns.tip.confirm("您确定要退出系统吗？", function () {
            window.location.href = ns.getBasePath() + "/signout";
        });
        var dialog = exitObj.find(".modal-dialog");
        dialog.addClass("modal-sm");
        dialog.css("padding-top", "200px");
    };
    var offset = $(".sub-menu li.active").offset();
    if (offset) {
        var top = offset.top;
        if (top > $(".sidebar").height() * 0.8) {
            $(".sidebar .main-navigation").animate({scrollTop: (top * 0.4) + 'px'}, 800, function () {
                if ($(document).width() > 1200)
                    $(this).slimScroll({scrollTo: (top * 0.4) + "px"});
            });
        }
    }
    ns.initCustomControls();
    setTimeout(ns.initPreLoad, 300)
    // $(".layout-v .vertical>li").hover(function () {
    //     $(".layout-v .vertical>li").removeClass("open");
    //     $(this).addClass("open");
    //     $(this).unbind("click");
    // });
});

//按顺序逐步加载
$(function () {
    offscreen.init();
    //记录窗口大小初始值
    ns.lastDocumentHeight = $(document).height();
    ns.lastDocumentWidth = $(document).width();
    ns.execReadyEvents();
});
