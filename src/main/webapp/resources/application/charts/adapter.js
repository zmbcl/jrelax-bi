/**
 * 图表适配器
 */

function ChartAdapter(datasources) {
    this.dsArray = [];//已加载的数据源集合
    this.context = null;//上下文对象
    this.chart = null;//图表对象
    this.options = null;//当前配置
    this.def = {//默认配置

    };
    this.getLabels = function () {//获取标签
    }
    this.getDataSets = function () {//获取数据集
    }
    //异步加载数据
    this.loadData = function (onLoaded) {
        var count = 0, obj = this;
        for (var i = 0; i < datasources.length; i++) {
            var config = datasources[i];
            var ds = new DataSource(config.id, {
                async: true,
                onLoaded: function (data) {
                    count++;
                    obj.dsArray.push(ds);
                    if (count == datasources.length) {
                        var data = {
                            labels: obj.getLabels(),
                            datasets: obj.getDataSets()
                        };
                        onLoaded(data);
                    }
                }
            });
            ds.load();
        }
    }

    //初始化
    this.init = function (ctx, opt, onBeforeLoad) {
        var opt = $.extend(opt, this.def);
        var obj = this;
        this.loadData(function (data) {
            if(onBeforeLoad) onBeforeLoad();
            opt.data = data;
            var options = $.extend(false, {}, opt);
            obj.options = $.extend(false, {}, options);//复制配置
            obj.context = ctx;

            obj.chart = new Chart(obj.context, options);
        });
    }

    //更新
    this.update = function (opt) {
        opt = Charts.Utils.parseOpt(opt);
        var options = $.extend(false, this.def, opt);
        this.options = $.extend(false, {}, options);//复制配置
        this.chart.destroy();
        this.chart = new Chart(this.context, options);
        return this.chart;
    }
}