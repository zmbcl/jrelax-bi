/**
 * 数据源
 * Created by Administrator on 2016-11-30.
 */
function DataSource(id) {
    //同一个数据源，做缓存处理
    if(!window.DataSourcePool) window.DataSourcePool = {};
    if(window.DataSourcePool[id]) return window.DataSourcePool[id];
    else window.DataSourcePool[id] = this;
    var _data;//数据源数据
    var _columns;//数据源字段
    var _type = "json";


    //获取数据源数据，做缓存
    this.getData = function () {
        if (!_data)
            this.flush();
        return _data;
    }

    //刷新数据
    this.flush = function () {
        syncGet(getBasePath() + "/bi/ds/data/" + _type + "/" + id, function (success, response) {
            _data = response;

            _data = jQuery.parseJSON(_data);
        });
    }

    //获取列集合
    this.getColumns = function () {
        if (!_columns) {
            syncGet(getBasePath() + "/bi/ds/metadata/" + id, function (success, response) {
                _columns = eval(response);
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
                    if(d[x] == label){
                        data.push(d[y]);
                        has = true;
                    }
                }
                if(!has) data.push(0);
            }
        } else {
            for (var i = 0; i < _data.length; i++) {
                var d = _data[i];
                data.push(d[x]);
            }
        }
        return data;
    }

    function syncGet(url, callback){
        jQuery.ajax({
            type:"GET",
            url : url,
            cache : false,
            async : false,
            success : function(data){
                if (typeof(callback) != "function") return;
                var success = true;
                if (data.success == false) {
                    success = false;
                }
                callback(success, data);
            },
            error : function(xhr, msg, e){
                if (typeof(callback) != "function") return;
                var data = {success:false, error:"请求异常:"+xhr.status+" "+e};
                callback(false, data);
            }
        });
    }
    function getBasePath(){
        if(window.ns) return ns.getBasePath();
        return window.___path___;
    }
}