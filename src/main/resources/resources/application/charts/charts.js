/**
 * 生成图表
 * 依赖jQuery-1.11+
 * Created by zengchao on 2016-12-03.
 */
if (!window.chartsOnLoad) {
    window.chartsOnLoad = true;
    const prefixUrl = "http://localhost:8080/jrelax-bi";
    const prefixChart = "chart";
    const prefixTip = "tip";
    window.BasePath = prefixUrl;
    //加载必须JS
    if (!window.$)
        document.write("<script src='" + prefixUrl + "/framework/plugins/jquery-1.11.1.min.js'></script>");
    if (!window.Chart)
        document.write("<script src='" + prefixUrl + "/framework/plugins/charts/chartjs/Chart.min.js'></script>");
    if (!window.DataSource)
        document.write("<script src='" + prefixUrl + "/app/datasource/datasource.js'></script>");
    if (!window.Charts){
        document.write("<script src='" + prefixUrl + "/app/charts/adapter.js'></script>");
        document.write("<script src='" + prefixUrl + "/app/charts/utils.js'></script>");
    }

    if (!window.JChart) {
        function JChart(id, timespan) {
            this.init = function () {
                if (!window.JChartPool) window.JChartPool = {};
                if (window.JChartPool[id]) {
                    display(window.JChartPool[id]);
                } else {
                    $.get(prefixUrl + "/bi/charts/detail", {id: id}, function (data) {
                        window.JChartPool[id] = data;
                        display(data);
                    });
                }
            };
            function display(data) {
                if (data.type) {
                    $("body").append("<script src='" + prefixUrl + "/app/charts/adapter/" + data.type + ".js'></script>");
                    var adapter = Charts.Utils.createAdapter(data.type, data.configs.datasource);
                    adapter.init($("#" + getId(prefixChart, id, timespan))[0], data.configs.charts);
                    $("#" + getId(prefixTip, id, timespan)).remove();
                } else {
                    $("#" + getId(prefixTip, id, timespan)).text("初始化失败：图表未找到");
                }
            }
        }

        function getId(prefix, id, timespan) {
            return prefix + "_" + id + "_" + timespan;
        }
    }
    window.onload = function () {
        var valid = true;
        //验证前缀地址是否可以访问
        $.ajax({
            url : prefixUrl,
            async : false,
            cache : false,
            error : function(){
                valid = false;
            }
        });
        if(!valid) {
            console.log("===================看这里，看这里=======================");
            console.log("1. prefixUrl地址应该设置为http://地址:端口/项目名（项目名可以为空），确保配置的prefix地址可以访问。");
            console.log("2. 配置文件路径：src/main/resources/resources/application/charts/charts.js");
            console.log("===================没有了，去改吧=======================");
            alert("图表配置错误，错误信息请查看浏览器控制台。");
            alert("不是IDE的控制台，是浏览器控制台哦！是浏览器控制台哦！");
            alert("最后一句：通常是按F12打开，选中Console标签就能显示")
        }
        $("script[data-bi-chart]").each(function (i, n) {
            var target = $(n);
            var id = target.attr("data-bi-chart");
            if (id.length > 0) {
                target.parent().append("<div id='" + getId(prefixTip, id, i) + "'>正在初始化，请稍后...</div>");
                target.parent().append("<canvas id='" + getId(prefixChart, id, i) + "' style='width: 100%'></canvas>")
                //依次加载，防止卡顿
                setTimeout(function(){
                    new JChart(id, i).init();
                }, i * 1200);
            }
        });
    }
}
