/**
 * 报表
 * Created by zengchao on 2016-12-28.
 */
function BiReport(opt) {
    var _data = {};
    var _def = {
        datasource : "ds",//数据源
        code: "code",//数据字段
        arrow: "arrow",//展开方向
        nodeClass: "bi-node",
        target: undefined
    };
    opt = $.extend(opt, _def);

    function create(tag) {
        var el = "<" + tag + "></" + tag + ">";
        return $(el).addClass(opt.nodeClass);
    }

    function createTr(td_count) {
        var tr = $("<tr></tr>");
        for (var i = 0; i < td_count; i++) {
            tr.append(create("td"));
        }
        return tr.addClass(opt.nodeClass);
    }

    function dataOfColumn(dsId, col) {
        var list = [];
        var ds = _data[dsId];
        if(ds){
            var data = ds.getData();
            for (var i = 0; i < data.length; i++) {
                list.push(data[i][col]);
            }
        }
        return list;
    }

    this.setTarget = function (target) {
        opt.target = target;
    }

    this.getTarget = function () {
        return opt.target;
    }

    this.render = function (data) {
        if (!opt.target) alert("target undefined");
        //重置
        this.reset();
        //加载数据
        this.loadData();
        //渲染列
        var codeEl = opt.target.find("[" + opt.code + "][" + opt.arrow + "='right']");
        $.each(codeEl, function (i, n) {
            var el = $(n);

            var code = el.attr(opt.code);
            var dsId = el.attr(opt.datasource);
            var list = dataOfColumn(dsId, code);

            if (list.length > 0) {
                el.text(list[0]);
            }
            for (var j = 1; j < list.length; j++) {
                create(el[0].tagName).insertAfter(el);
                el = el.next();//移动列指针
                el.text(list[j]);
            }
        });

        //渲染行
        codeEl = opt.target.find("[" + opt.code + "][" + opt.arrow + "='down']");
        var maxTrIndex = 0, maxDataLength = 0;
        $.each(codeEl, function (i, n) {
            //找出处于最下方的列所在行行序号
            var el = $(n);
            var idx = el.parents("tr").index();
            if(idx > maxTrIndex) maxTrIndex = idx;
            //找出数据量最大的列
            var code = el.attr(opt.code);
            var dsId = el.attr(opt.datasource);
            var list = dataOfColumn(dsId, code);
            if(list.length > maxDataLength) maxDataLength = list.length;
        });
        //创建新行
        var maxTr = opt.target.find("tr").eq(maxTrIndex);
        var maxTrOfTdCount = maxTr.find("td").length;
        for(var i=1;i<maxDataLength;i++){
            var newTr = createTr(maxTrOfTdCount);
            newTr.insertAfter(maxTr);
        }

        $.each(codeEl, function (i, n) {
            var el = $(n), tr = el.parents("tr"), idx = el.index(), count = tr.find(n.tagName).length;

            var code = el.attr(opt.code);
            var dsId = el.attr(opt.datasource);
            var list = dataOfColumn(dsId, code);
            var style = el.attr("style");//复制样式

            if (list.length > 0) {
                el.text(list[0]);
            }
            for (var j = 1; j < list.length; j++) {
                tr = tr.next();
                tr.find("td,th").eq(idx).text(list[j]).attr("style", style);
            }
        });
    }

    //重置
    this.reset = function () {
        opt.target.find("." + opt.nodeClass).remove();
        opt.target.find("[" + opt.code + "]").text("");
    }
    this.getOptions = function(){
        return opt;
    }
    this.setDsOfCell = function (cell, ds) {
        cell.attr(opt.datasource, ds);
    }
    this.setCodeOfCell = function(cell, code){
        cell.attr(opt.code, code);
    }
    this.setArrowOfCell = function(cell, arrow){
        cell.attr(opt.arrow, arrow);
    }

    //加载数据
    this.loadData = function(){
        var tds = opt.target.find("td["+opt.datasource+"]");
        var dsList = [];
        $.each(tds, function(i,n){
            var td = $(n);
            var dsId = td.attr(opt.datasource);
            if(!dsList.contains(dsId)){
                var ds = new DataSource(dsId);
                ds.load();
                _data[dsId] = ds;
            }
        });
    }
}