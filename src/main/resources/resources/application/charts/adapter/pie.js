/**
 * 折线图适配器
 * Created by Administrator on 2016-12-03.
 */
function PieAdapter(datasources) {
    ChartAdapter.call(this, datasources);
    this.def = $.extend({
        type: "pie",
        options: {
            legend: {
                display: true
            },
            animation: {
                animateScale: true
            }
        }
    }, this.def);

    this.getOptions = function () {
        var op = {
            type: "pie",
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
                backgroundColor: Charts.Utils.getBC(data.length),
                hoverBackgroundColor: Charts.Utils.getBC(data.length)
            };

            datasets.push(dataset);
        }
        return datasets;
    }
}