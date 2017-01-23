/**
 * 报表
 * Created by zengchao on 2016-12-28.
 */
function BiReport(opt) {
    var _data = {};
    var _def = {
        dsTag : "ds",//数据源
        codeTag: "code",//数据字段
        arrowTag: "arrow",//展开方向
        formulaTag : "formula",//公式标签
        precisionTag : "precision",//精度标签
        conditionSymbolTag: "condition-symbo",
        conditionValueTag: "condition-value",
        conditionTargetTag: "condition-target",
        conditionTypeTag: "condition-type",
        conditionColorTag: "condition-color",
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

    this.render = function () {
        if (!opt.target) alert("target undefined");
        //重置
        this.reset();
        //加载数据
        this.loadData();

        //渲染
        this.renderGrid();
        this.renderFormual();
        this.renderPrecision();
        this.renderCondition();
    }

    //解析表格
    this.renderGrid = function(){
        //渲染列
        var codeEl = opt.target.find("[" + opt.codeTag + "][" + opt.arrowTag + "='right']");
        $.each(codeEl, function (i, n) {
            var el = $(n);

            var code = el.attr(opt.codeTag);
            var dsId = el.attr(opt.dsTag);
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
        codeEl = opt.target.find("[" + opt.codeTag + "][" + opt.arrowTag + "='down']");
        var maxTrIndex = 0, maxDataLength = 0;
        $.each(codeEl, function (i, n) {
            //找出处于最下方的列所在行行序号
            var el = $(n);
            var idx = el.parents("tr").index();
            if(idx > maxTrIndex) maxTrIndex = idx;
            //找出数据量最大的列
            var code = el.attr(opt.codeTag);
            var dsId = el.attr(opt.dsTag);
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

            var code = el.attr(opt.codeTag);
            var dsId = el.attr(opt.dsTag);
            var list = dataOfColumn(dsId, code);

            //需要复制的属性值
            var copyTags = ["style",
                opt.precisionTag,
                opt.conditionSymbolTag,
                opt.conditionValueTag,
                opt.conditionTargetTag,
                opt.conditionTypeTag,
                opt.conditionColorTag
            ]
            var copyTagValue = {};
            for(var i=0;i<copyTags.length;i++){
                var tag = copyTags[i];
                copyTagValue[tag] = el.attr(tag);
            }

            if (list.length > 0) {
                el.text(list[0]);
            }
            for (var j = 1; j < list.length; j++) {
                tr = tr.next();
                var td = tr.find("td,th").eq(idx).text(list[j]);
                for(var i=0;i<copyTags.length;i++){
                    var tag = copyTags[i];
                     td.attr(tag, copyTagValue[tag]);
                }
            }
        });
    }

    //解析公式，需要注意公式计算先后顺序问题
    this.renderFormual = function(){
        var rules = new BiReport.Formula().getRules();
        //解析计算公式
        var formulaEL = opt.target.find("["+opt.formulaTag+"]");
        $.each(formulaEL, function(i, n){
            var td = $(n);
            var formula = jQuery.trim(td.attr(opt.formulaTag));
            if(formula.length > 0){
                for(var i=0;i<rules.length;i++){
                    var rule = rules[i];
                    if(rule.regex.test(formula)){
                        var value = rule.fun(formula, opt.target);
                        td.text(value);
                        break;
                    }
                }
            }
        });
    }

    //设置精度
    this.renderPrecision = function(){
        var precisionEL = opt.target.find("["+opt.precisionTag+"]");
        $.each(precisionEL, function(i, n){
            var td = $(n);
            var precision = parseInt(td.attr(opt.precisionTag));
            var val = parseFloat(td.text()).toFixed(precision);
            td.text(val);
        });
    }

    //条件运算
    this.renderCondition = function(){
        var conditionEl = opt.target.find("["+opt.conditionSymbolTag+"]");
        $.each(conditionEl, function(i, n){
            var td = $(n);

            var conditionSymbol = td.attr(opt.conditionSymbolTag);
            var conditionValue = td.attr(opt.conditionValueTag);
            var conditionTarget = td.attr(opt.conditionTargetTag);
            var conditionType = td.attr(opt.conditionTypeTag);
            var conditionColor = td.attr(opt.conditionColorTag);

            if(isNumber(conditionValue)){
                var result = eval(td.text() + conditionSymbol + conditionValue);
                if(result){
                    if(!conditionTarget || conditionTarget == "cell")
                        td.css(conditionType, conditionColor);
                    else if(conditionTarget == "row")
                        td.parents("tr").css(conditionType, conditionColor);
                }
            }
        });
    }

    //重置
    this.reset = function () {
        opt.target.find("." + opt.nodeClass).remove();
        opt.target.find("[" + opt.codeTag + "]").text("");
    }
    this.getOptions = function(){
        return opt;
    }
    this.setDsOfCell = function (cell, ds) {
        cell.attr(opt.dsTag, ds);
    }
    this.setCodeOfCell = function(cell, code){
        cell.attr(opt.codeTag, code);
    }
    this.setArrowOfCell = function(cell, arrow){
        cell.attr(opt.arrowTag, arrow);
    }

    //加载数据
    this.loadData = function(){
        var tds = opt.target.find("td["+opt.dsTag+"]");
        var dsList = [];
        $.each(tds, function(i,n){
            var td = $(n);
            var dsId = td.attr(opt.dsTag);
            if(!dsList.contains(dsId)){
                var ds = new DataSource(dsId);
                ds.getData();
                _data[dsId] = ds;
            }
        });
    }

    //判断是否是数字（包含整数和浮点数）
    function isNumber(str){
        return /^(-?\d+)(\.\d+)?$/.test(str);
    }
}