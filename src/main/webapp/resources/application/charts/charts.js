/**
 * 生成图表
 * 依赖jQuery-1.11+
 * Created by zengchao on 2016-12-03.
 */
var  ___path___, __prefix__ = "chart_";
if(!window.JChart){
    function JChart(id, timespan){
        this.init = function(){
            if(!window.JChartPool) window.JChartPool = {};
            if(window.JChartPool[id]){
                display(window.JChartPool[id]);
            }else{
                $.get(___path___+"/bi/charts/detail", {id:id}, function(data){
                    window.JChartPool[id] = data;
                    display(data);
                });
            }
        }
        function display(data){
            $("body").append("<script src='"+___path___+"/app/charts/adapter/"+data.type+".js'></script>");
            adapter = Charts.Utils.createAdapter(data.type, data.configs.datasource);
            adapter.init($("#"+__prefix__+id+"_"+timespan)[0], data.configs.charts);
            $("#___tip___"+id).remove();
        }
    }
}
function __init__(){
    var id;
    var patten = new RegExp("(\\S+)/app/charts/charts\\.js\\?id=(\\S+)");
    var scripts = document.getElementsByTagName("script");
    //获取最后一个script标签
    var url = scripts[scripts.length-1].src;
    if(patten.test(url)){
        var match = url.match(patten);
        ___path___ = match[1]
        id = match[2];
    }
    document.write("<div id='___tip___"+id+"'>正在初始化，请稍后...</div>");
    if(!window.$)
        document.write("<script src='"+___path___+"/framework/plugins/jquery-1.11.1.min.js'></script>");
    if(!window.Chart)
        document.write("<script src='"+___path___+"/framework/plugins/charts/chartjs/Chart.min.js'></script>");
    if(!window.DataSource)
        document.write("<script src='"+___path___+"/app/charts/datasource.js'></script>");
    if(!window.Charts)
        document.write("<script src='"+___path___+"/app/charts/utils.js'></script>");
    var timespan = new Date().getTime();
    document.write("<canvas id='"+__prefix__+id+"_"+timespan+"' style='width: 100%'></canvas>")

    setTimeout(function(){
        new JChart(id, timespan).init();
    }, 500);
}
__init__();
