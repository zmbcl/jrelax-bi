/**
 * Created by Administrator on 2016-12-03.
 */
var Charts = {
    Utils: {//工具集
        //预设背景色
        _bgcArray: [
            'rgba(255, 99, 132, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(255, 206, 86, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(153, 102, 255, 0.2)',
            'rgba(255, 159, 64, 0.2)'
        ],
        //预设边框颜色
        _bcArray: [
            'rgba(255,99,132,1)',
            'rgba(54, 162, 235, 1)',
            'rgba(255, 206, 86, 1)',
            'rgba(75, 192, 192, 1)',
            'rgba(153, 102, 255, 1)',
            'rgba(255, 159, 64, 1)'
        ],
        getBGC: function (len) {
            var array = [];
            for (var i = 0; i < len; i++) {
                if (i < Charts.Utils._bgcArray.length) {
                    array.push(Charts.Utils._bgcArray[i]);
                } else {
                    array.push(Charts.Utils._bgcArray[i - Charts.Utils._bgcArray.length]);
                }
            }
            return array;
        },
        getBC: function (len) {
            var array = [];
            for (var i = 0; i < len; i++) {
                if (i < Charts.Utils._bcArray.length) {
                    array.push(Charts.Utils._bcArray[i]);
                } else {
                    array.push(Charts.Utils._bcArray[i - Charts.Utils._bcArray.length]);
                }
            }
            return array;
        },
        parseOpt: function (opt) {
            var options = {};
            $.each(opt, function (i, n) {
                Charts.Utils._parseOpt(options, i, n);
            })
            return options;
        },
        _parseOpt: function (obj, opt, v) {
            if (v == "true") v = true;
            if (v == "false") v = false;
            var idx = opt.indexOf(".");
            if (idx > 0) {
                var o = opt.substring(0, idx);
                if (!obj[o]) obj[o] = {};

                Charts.Utils._parseOpt(obj[o], opt.substring(idx + 1), v);
            } else {
                obj[opt] = v;
            }
            return obj;
        },
        createAdapter : function(type, datasource){
            if(type == "bar") return new BarAdapter(datasource);
            else if(type == "bubble") return new BubbleAdapter(datasource);
            else if(type == "doughnut") return new DoughnutAdapter(datasource);
            else if(type == "line") return new LineAdapter(datasource);
            else if(type == "pie") return new PieAdapter(datasource);
            else if(type == "polar-area") return new PolarAreaAdapter(datasource);
            else if(type == "radar") return new RadarAdapter(datasource);
        }

    }
}