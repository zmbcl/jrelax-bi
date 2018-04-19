/**
 * 柱状图适配器
 * Created by Administrator on 2016-12-01.
 */
function BarAdapter(datasources) {
    ChartAdapter.call(this, datasources);
    this.def = $.extend({
        type: "bar",
        options: {
            legend: {
                display: true,
                reverse: true
            }
        }
    }, this.def);

    this.getOptions = function () {
        var op = {
            type: "bar",
            datasource: datasources,
            charts: this.options
        };
        return op;
    }

    this.getLabels = function () {
        var labels = [];
        for (var i = 0; i < datasources.length; i++) {
            var config = datasources[i];
            var ds = this.dsArray[i];

            labels = jQuery.unique(labels.concat(ds.getDataOfColumn(config.xAxis)));
        }
        return labels;
    }

    this.getDataSets = function () {
        var labels = this.getLabels();
        var datasets = [];
        for (var i = 0; i < datasources.length; i++) {
            var config = datasources[i];
            var ds = this.dsArray[i];

            var data = ds.getDataOfColumn(config.xAxis, config.yAxis, labels);
            var dataset = {
                label: config.name,
                data: data,
                borderWidth: 1,
                backgroundColor: Charts.Utils.getBGC(data.length),
                borderColor: Charts.Utils.getBC(data.length)
            };

            datasets.push(dataset);
        }
        return datasets;
    }
}