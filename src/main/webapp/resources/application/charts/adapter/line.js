/**
 * 折线图适配器
 * Created by Administrator on 2016-12-03.
 */
function LineAdapter(configs){
    var _dsArray = [], _ctx, _chart, _options;
    var _def = {
        type : "line",
        options : {
            legend : {
                display:false
            },
            elements : {
                line : {
                    fill : false
                },
                point : {
                    radius : 3
                }
            }
        }
    };
    this.getData = function(){
        for(var i=0;i<configs.length;i++){
            var config = configs[i];
            var ds = new DataSource(config.id);
            ds.getData();
            _dsArray.push(ds);
        }
        var data = {
            labels: this.getLabels(),
            datasets : this.getDataSets()
        };
        return data;
    }

    this.getLabels = function(){
        var labels = [];
        for(var i=0;i<configs.length;i++){
            var config = configs[i];
            var ds = _dsArray[i];

            labels = jQuery.unique(labels.concat(ds.getDataOfColumn(config.xAxis)));
        }
        return labels;
    }

    this.getDataSets = function(){
        var labels = this.getLabels();
        var datasets = [];
        for(var i=0;i<configs.length;i++){
            var config = configs[i];
            var ds = _dsArray[i];

            var data = ds.getDataOfColumn(config.xAxis, config.yAxis, labels);
            var dataset = {
                label : config.name,
                data : data,
                borderWidth: 1,
                backgroundColor : Charts.Utils.getBGC(data.length)[i],
                borderColor : Charts.Utils.getBC(data.length)[i]
            };

            datasets.push(dataset);
        }
        return datasets;
    }
    this.init = function(ctx, opt){
        var opt = opt || _def;
        opt.data = this.getData();
        var options = $.extend(false, {}, opt);
        _options = $.extend(false, {}, options);//复制配置
        _ctx = ctx;
        _chart = new Chart(_ctx, options);
        return _chart;
    }

    this.update = function(opt){
        opt = Charts.Utils.parseOpt(opt);
        var options = $.extend(false, _def, opt);
        _options = $.extend(false, {}, options);//复制配置
        _chart.destroy();
        _chart = new Chart(_ctx, options);
        return _chart;
    }

    this.getOptions = function(){
        var op = {
            type : "line",
            datasource : configs,
            charts : _options
        };
        return op;
    }
}