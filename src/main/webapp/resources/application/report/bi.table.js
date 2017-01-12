/**
 * 动态表格
 * Created by zengchao on 2016-12-28.
 */
$.fn.BiTable = function (options) {
    var _def = {
        drag: false, //启用拖曳选择,
        selectedClass: "selected", //选中样式
        leftTag: "left",
        rightTag: "right",
        topTag: "top",
        bottomTag: "bottom",
        rowTag: "rowspan",
        colTag: "colspan",
        rowClass: "rownum",
        colClass: "colnum",
        showHeader: false,//显示表头，类似于Excel形式 A1 A2 B1 B2
        onSelectCell: function () {
        }//当选中单元格时
    }
    options = $.extend(_def, options);
    var $table = this;
    var selectMode = false;
    var startPos, endPos, curPos = {x: 0, y: 0}, curRange;

    function _init() {
        initEvents();
        if (options.showHeader) {
            initHeader();
        }
    }

    //显示表头
    function initHeader() {
        //行
        var firstTr = $table.find("tr").eq(0);
        if (firstTr.length > 0) {//存在行
            firstTr.find("td:gt(0)").each(function (i, n) {
                var td = $(n);
                td.attr("contenteditable", false);
                td.attr("class", options.colClass);
                td.text(String.fromCharCode(65 + i));
            });
        } else {
            createNewTr(1);
        }
        //列
        $table.find("tr").each(function (i, n) {
            var tr = $(n);
            var firstTd = tr.find("td").eq(0);
            firstTd.attr("contenteditable", false);
            firstTd.attr("class", options.rowClass);
            if(i>0)
                firstTd.text(i);
        });

    }

    function initEvents() {
        var tds = $table.find("td");
        if (options.drag) {
            tds.off("mouseup");
            tds.off("mousedown");
            tds.off("mouseover");
            tds.on("mouseup", function () {
                selectMode = false;
                recordPosition($(this));
            });
            tds.on("mousedown", function () {
                table.unSelectAll();
                selectMode = true;
                startPos = {x: $(this).index(), y: $(this).parent().index()};
            });

            tds.on("mouseover", function () {
                if (selectMode) {
                    endPos = {x: $(this).index(), y: $(this).parent().index()};
                    selected();
                }
            });
        } else {
            tds.on("click", function () {
                recordPosition($(this));
                table.unSelectAll();
                select($(this));
            });
        }
    }

    //记录当前编辑位置
    function recordPosition(element) {
        curPos = {x: element.index(), y: element.parent().index()};
        //获取编辑区光标位置
        curRange = getSelection().getRangeAt(0);
    }

    //选中
    function selected() {
        table.unSelectAll();

        var sX = startPos.x > endPos.x ? endPos.x : startPos.x;
        var sY = startPos.y > endPos.y ? endPos.y : startPos.y;
        var eX = startPos.x > endPos.x ? startPos.x : endPos.x;
        var eY = startPos.y > endPos.y ? startPos.y : endPos.y;

        // for (var i = sY; i <= eY; i++) {
        //     var tr = $table.find("tr").eq(i);
        //     for (var j = sX; j <= eX; j++) {
        //         var td = tr.find("td").eq(j);
        //         if (td) $(td).addClass("selected");
        //     }
        // }

        var sTd = findTd(sX, sY);
        var eTd = findTd(eX, eY);

        var top = sTd.offset().top;
        var bottom = eTd.offset().top + eTd.height();
        var left = sTd.offset().left;
        var right = eTd.offset().left + eTd.width();

        $table.find("td").each(function (i, n) {
            var td = $(n);

            var offset = {
                top: td.offset().top,
                bottom: td.offset().top + td.height(),
                left: td.offset().left,
                right: td.offset().left + td.width()
            }

            if (offset.top >= top && offset.bottom <= bottom && offset.left >= left && offset.right <= right) {
                td.addClass(options.selectedClass);
            }
        });
    }

    function select(td) {
        //不选中行标识
        if (td.hasClass(options.colClass) || td.hasClass(options.rowClass)) return;
        td.addClass(options.selectedClass);
        options.onSelectCell(td, $table);
    }

    //全选
    this.selectAll = function () {
        $table.find("td").addClass(options.selectedClass);
    }

    //全不选
    this.unSelectAll = function () {
        $table.find("td").removeClass(options.selectedClass);
    }

    //寻找行
    function findTr(y) {
        y = !isUndefined(y) ? y : curPos.y;
        return $table.find("tr").eq(y);
    }

    //寻找单元格
    function findTd(x, y) {
        x = !isUndefined(x) ? x : curPos.x;
        y = !isUndefined(y) ? y : curPos.y;
        return $table.find("tr").eq(y).find("td").eq(x);
    }

    //创建一行
    function createNewTr(tdLen) {
        var tr = $("<tr></tr>");
        for (var i = 0; i < tdLen; i++) {
            tr.append(createNewTd());
        }
        return tr;
    }

    //创建一个单元格
    function createNewTd() {
        var td = $("<td></td>");
        td.append("<br/>");
        return td;
    }

    function setSelectionRange(range) {
        getSelection().removeAllRanges();
        getSelection().addRange(range);
    }

    function removeTr(idx) {
        idx = idx || curPos.y;
        findTr(idx).remove();
    }

    function removeTd(x, y) {
        findTd(x, y).remove();
    }

    function getTrCount() {
        return $table.find("tr").length;
    }

    function getTdCount(tr) {
        return tr.find("td").length;
    }

    function isUndefined(val) {
        if (typeof(val) == "undefined") {
            return true;
        }
        return false;
    }

    //删除表格
    this.removeTable = function () {
        $table.remove();
    }

    //删除一行
    this.removeRow = function (idx) {
        removeTr(idx);
        this.update();
    }

    //删除一列
    this.removeCol = function (idx) {
        idx = !isUndefined(idx) ? idx : curPos.x;
        var len = getTrCount();
        for (var i = 0; i < len; i++) {
            removeTd(idx, i);
        }
        this.update();
    }

    this.update = function () {
        initEvents();
        if (curRange)
            setSelectionRange(curRange);
        if (options.showHeader) {
            initHeader();
        }
    }

    //插入行
    this.insertRow = function (arrow) {
        var curTr = findTr();
        var tr = createNewTr(curTr.find("td").length);
        if (arrow == options.topTag) { //向上插入一行
            tr.insertBefore(curTr);
        } else if (arrow == options.bottomTag) {//向下插入一行
            tr.insertAfter(curTr);
        }
        this.update();
    }

    //插入列
    this.insertCol = function (arrow) {
        var x = curPos.x;
        var trCount = getTrCount();
        if (arrow == options.leftTag) {
            // if (x <= 0) return;
            for (var i = 0; i < trCount; i++) {
                var td = findTd(x, i);
                createNewTd().insertBefore(td);
            }
        } else if (arrow == options.rightTag) {
            // if (x >= trCount - 1) return;
            for (var i = 0; i < trCount; i++) {
                var td = findTd(x, i);
                createNewTd().insertAfter(td);
            }
        }

        this.update();
    }

    //合并单元格
    this.merge = function (arrow) {
        var curTd = findTd();
        var curTdColspan = curTd.attr(options.colTag);
        var curTdRowspan = curTd.attr(options.rowTag);
        if (arrow == options.leftTag) {//向左合并
            if (curPos.x <= 0) return;
            var td = curTd.prev()
            var colspan = getColspan(curTd, td);
            curTd.remove();
            td.attr(options.colTag, colspan);
        } else if (arrow == options.rightTag) {//向右合并
            if (curPos.x >= getTdCount(findTr(curPos.y)) - 1) return;
            var td = curTd.next()
            var colspan = getColspan(curTd, td);
            td.remove();
            curTd.attr(options.colTag, colspan);
        } else if (arrow == options.topTag) {//向上合并
            if (curPos.y <= 0) return;
            var td = findTd(curPos.x, curPos.y - 1);
            var rowspan = getRowspan(curTd, td);
            curTd.remove();
            td.attr(options.rowTag, rowspan);
        } else if (arrow == options.bottomTag) {//向下合并
            if (curPos.y >= getTrCount() - 1) return;
            var td = findTd(curPos.x, curPos.y + 1);
            if (curTdRowspan) {
                td = findTd(curPos.x, curPos.y + parseInt(curTdRowspan));
            }
            var rowspan = getRowspan(curTd, td);
            td.remove();
            curTd.attr(options.rowTag, rowspan);
        }
        this.update();
        this.clear();
    }

    function getColspan(td1, td2) {
        var colspan = 0;
        if (td1.attr(options.colTag)) {
            colspan += parseInt(td1.attr(options.colTag))
        } else {
            colspan += 1;
        }
        if (td2.attr(options.colTag)) {
            colspan += parseInt(td2.attr(options.colTag))
        } else {
            colspan += 1;
        }
        return colspan;
    }

    function getRowspan(td1, td2) {
        var rowspan = 0;
        if (td1.attr(options.rowTag)) {
            rowspan += parseInt(td1.attr(options.rowTag))
        } else {
            rowspan += 1;
        }
        if (td2.attr(options.rowTag)) {
            rowspan += parseInt(td2.attr(options.rowTag))
        } else {
            rowspan += 1;
        }
        return rowspan;
    }

    //合并选中单元格
    this.mergeSelected = function () {
        var tds = $table.find(".selected");
        if (tds.length == 0) return;

        for (var i = 1; i < tds.length; i++) {
            $(tds[i]).remove();
        }
        var sX = startPos.x > endPos.x ? endPos.x : startPos.x;
        var eX = startPos.x > endPos.x ? startPos.x : endPos.x;
        var sY = startPos.y > endPos.y ? endPos.y : startPos.y;
        var eY = startPos.y > endPos.y ? startPos.y : endPos.y;

        if (eX > sX) {
            var td = $(tds[0]);
            var colspan = td.attr(options.colTag);
            if (colspan) {
                colspan = parseInt(colspan);
            } else {
                colspan = 1;
            }
            colspan += eX - sX;
            td.attr(options.colTag, colspan);
        }
        if (eY > sY) {
            var td = $(tds[0]);
            var rowspan = td.attr(options.rowTag);
            if (rowspan) {
                rowspan = parseInt(rowspan);
            } else {
                rowspan = 1;
            }
            rowspan += eY - sY;
            td.attr(options.rowTag, rowspan);
        }

        this.update();
        this.clear();
    }

    //全部拆分
    this.split = function () {
        var tds = $table.find("td[rowspan]");
        $.each(tds, function (i, n) {
            var td = $(n);

            curPos = {
                x: td.index(),
                y: td.parents("tr").index()
            }

            $table.splitToRows();
        });

        tds = $table.find("td[colspan]");
        $.each(tds, function (i, n) {
            var td = $(n);

            curPos = {
                x: td.index(),
                y: td.parents("tr").index()
            }

            $table.splitToCols();
        });

        curPos = {x: 0, y: 0};
        curRange = undefined;
    }
    //拆分成行
    this.splitToRows = function () {
        var curTd = findTd();
        var rowspan = curTd.attr(options.rowTag);
        if (rowspan) {
            curTd.removeAttr(options.rowTag);
            console.log(curPos);
            for (var i = 1; i < rowspan; i++) {
                var tr = findTr(curPos.y + i);
                console.log(tr.index());
                if (!tr[0]) {
                    tr = createNewTr(0);
                    tr.insertAfter(findTr());
                }
                var td = tr.find("td").eq(curPos.x);
                if (td[0]) {
                    curTd.clone().insertBefore(td);
                } else {
                    tr.append(curTd.clone());
                }
            }

            this.update();
        }
    }

    //拆分成列
    this.splitToCols = function () {
        var curTd = findTd();
        var colspan = curTd.attr(options.colTag);
        if (colspan) {
            curTd.removeAttr(options.colTag);

            for (var i = 1; i < colspan; i++) {
                curTd.clone().insertAfter(curTd);
            }

            this.update();
        }
    }

    this.clear = function () {
        //清理空tr
        var trs = $table.find("tr");
        $.each(trs, function (i, n) {
            var tr = $(n);
            if (tr.find("td").length == 0)
                tr.remove();
        });
    }
    //获取选中单元格
    this.getSelectedCell = function () {
        return $table.find("td." + options.selectedClass);
    }

    //获取选中行
    this.getSelectedRow = function () {
        return this.getSelectedCell().parents("tr");
    }

    this.bold = function(){
        var cell = this.getSelectedCell();
        if(cell[0]){
            if(cell.css("fontWeight") != "bold"){
                cell.css("fontWeight", "bold");
            }else{
                cell.css("fontWeight", "normal");
            }
        }
    }

    this.italic = function(){
        var cell = this.getSelectedCell();
        if(cell[0]){
            if(cell.css("fontStyle") != "italic"){
                cell.css("fontStyle", "italic");
            }else{
                cell.css("fontStyle", "normal");
            }
        }
    }
    
    this.alignLeft = function(){
        document.execCommand('justifyLeft');
    }
    
    this.alignCenter = function(){
        document.execCommand('justifyCenter');
    }
    
    this.alignRight = function(){
        document.execCommand('justifyRight');
    }

    this.underline = function(){
        var cell = this.getSelectedCell();
        if(cell[0]){
            if(cell.css("textDecoration") != "underline"){
                cell.css("textDecoration", "underline");
            }else{
                cell.css("textDecoration", "none");
            }
        }
    }

    this.lineThrough = function(){
        var cell = this.getSelectedCell();
        if(cell[0]){
            if(cell.css("textDecoration") != "line-through"){
                cell.css("textDecoration", "line-through");
            }else{
                cell.css("textDecoration", "none");
            }
        }
    }

    _init();
    return this;
}