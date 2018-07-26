/**
 * 数据源
 * Created by Administrator on 2016-11-30.
 */
function DataSource(id, opt) {
    var _data;//数据源数据
    var _columns;//数据源字段
    var _name;//数据源名称
    //默认配置
    var _def = {
        type : "json",//数据格式
        async : false,//是否异步执行，默认为非异步
        onBefore : function(){},
        onLoaded : function(){}
    }
    opt = $.extend(_def, opt);

    this.getId = function(){
        return id;
    }
    //加载数据，立即返回数据（同步请求）
    this.getData = function (params) {
        if (!_data || params)
            this.flush(params);
        return _data;
    }
    //获取数据源名称
    this.getName = function(){
        return _name;
    }

    //加载数据，不返回数据（异步请求）
    this.load = function (params) {
        if (!_data || params)
            this.flush(params);
    }

    //刷新数据
    this.flush = function (params) {
        opt.onBefore();
        loadRemoteData(getBasePath() + "/bi/datasource/data/" + opt.type + "/" + id, params, function (success, response) {
            _data = response;
            _data = jQuery.parseJSON(_data);
            opt.onLoaded(_data);
        });
    }

    //获取列集合
    this.getColumns = function () {
        if (!_columns) {
            loadRemoteData(getBasePath() + "/bi/datasource/metadata/" + id, {}, function (success, response) {
                var data = eval(response);
                _columns = data.columns;
                _name = data.name;
            });
        }
        return _columns;
    }

    //获取莫一列数据集合
    this.getDataOfColumn = function (x, y, labels) {
        if (!_data) {
            throw "必须先执行flush方法加载数据";
        }
        var data = [];
        if (y && labels) {

            for (var i = 0; i < labels.length; i++) {
                var label = labels[i];
                var has = false;
                for (var j = 0; j < _data.length; j++) {
                    var d = _data[j];
                    if (d[x] == label) {
                        data.push(d[y]);
                        has = true;
                    }
                }
                if (!has) data.push(0);
            }
        } else {
            for (var i = 0; i < _data.length; i++) {
                var d = _data[i];
                data.push(d[x]);
            }
        }
        return data;
    }

    function loadRemoteData(url, params, callback) {
        jQuery.ajax({
            type: "POST",
            url: url,
            cache: false,
            async: opt.async,
            data: params,
            success: function (data) {
                if (typeof(callback) != "function") return;
                var success = true;
                if (data.success == false) {
                    success = false;
                }
                callback(success, data);
            },
            error: function (xhr, msg, e) {
                if (typeof(callback) != "function") return;
                var data = {success: false, error: "请求异常:" + xhr.status + " " + e};
                callback(false, data);
            }
        });
    }

    function getBasePath() {
        if (window.ns) return ns.getBasePath();
        return window.BasePath;
    }
}