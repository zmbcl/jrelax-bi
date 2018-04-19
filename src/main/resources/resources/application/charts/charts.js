/**
 * 生成图表
 * 依赖jQuery-1.11+
 * Created by zengchao on 2016-12-03.
 */
if (!window.chartsOnLoad) {
    window.chartsOnLoad = true;
    var prefixUrl = "http://localhost:8080/jrelax-bi";
    var prefixChart = "chart";
    var prefixTip = "tip";
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
            }
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
