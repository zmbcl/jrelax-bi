/**
 * 雷达图适配器
 * Created by Administrator on 2016-12-03.
 */
function RadarAdapter(datasources) {
    ChartAdapter.call(this, datasources);
    this.def = $.extend({
        type: "radar",
        options: {
            legend: {
                display: false
            },
            animation: {
                animateScale: true
            }
        }
    }, this.def);


    this.getOptions = function () {
        var op = {
            type: "radar",
            datasource: datasources,
            charts: this.options
        };
        return op;
    }

    this.getLabels = function() {
        var labels = [];
        for (var i = 0; i < datasources.length; i++) {
            var config = datasources[i];
            var ds = this.dsArray[i];

            labels = jQuery.unique(labels.concat(ds.getDataOfColumn(config.xAxis)));
        }
        return labels;
    }

    this.getDataSets = function() {
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
                backgroundColor: Charts.Utils.getBGC(data.length)[i],
                borderColor: Charts.Utils.getBC(data.length)[i],
                borderWidth: 2,
                pointBackgroundColor: Charts.Utils.getBGC(data.length)[i],
                pointBorderColor: "#fff",
                pointHoverBackgroundColor: "#fff",
                pointHoverBorderColor: Charts.Utils.getBGC(data.length)[i],
            };

            datasets.push(dataset);
        }
        return datasets;
    }
}