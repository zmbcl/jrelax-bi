/**
 * 气泡图适配器
 * Created by zengchao on 2016-12-01.
 */
function BubbleAdapter(datasources){
    ChartAdapter.call(this, datasources);
    this.def = $.extend({
        type : "bubble",
        options : {
            legend : {
                display:true,
                reverse : true
            }
        }
    }, this.def);

    this.getOptions = function(){
        var op = {
            type : "bubble",
            datasource : datasources,
            charts : this.options
        };
        return op;
    }

    this.getLabels = function(){
        var labels = [];
        for(var i=0;i<datasources.length;i++){
            var config = datasources[i];
            var ds = this.dsArray[i];

            labels = jQuery.unique(labels.concat(ds.getDataOfColumn(config.xAxis)));
        }
        return labels;
    }

    this.getDataSets = function(){
        var labels = this.getLabels();
        var datasets = [];
        for(var i=0;i<datasources.length;i++){
            var config = datasources[i];
            var ds = this.dsArray[i];

            var data = [];
            var dsData = ds.getData();
            for(var j=0;j<dsData.length;j++){
                var d = dsData[j];

                data.push({
                    x : parseFloat(d[config.xAxis]),
                    y : parseFloat(d[config.yAxis]),
                    r : parseFloat(d[config.rAxis])
                });
            }
            var dataset = {
                label : config.name,
                data : data,
                // borderWidth: 1,
                backgroundColor : Charts.Utils.getBC(data.length)[0],
                hoverBackgroundColor : Charts.Utils.getBC(data.length)[0]
            };

            datasets.push(dataset);
        }
        return datasets;
    }
}