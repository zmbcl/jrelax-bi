/**
 * 报表公式运算
 * Created by zengc on 2017-01-10.
 */
BiReport.Formula = function () {
    //单元格编号正则表达式
    var cellNoRxp = /\b\w[1-9]+/ig
    //规则
    this.getRules = function () {
        return [
            {regex: /sum\s*\((.*)\)/, fun: this.sum},
            {regex: /avg\s*\((.*)\)/, fun: this.avg},
            {regex: /max\s*\((.*)\)/, fun: this.max},
            {regex: /count\s*\((.*)\)/, fun: this.count},
            {regex: /[+\-*\/%]/, fun: this.calc}
        ];
    };

    function charToNum(c) {
        return c.charCodeAt(0) - 64;
    }

    function numToChar(c) {
        return String.fromCharCode(c + 64);
    }

    function getCellNo(cell) {
        var colnum = cell.substring(0, 1);
        var rownum = cell.substring(1);

        if (/\w/.test(colnum)) {
            colnum = colnum.toUpperCase();
            colnum = charToNum(colnum);
        }

        if (/[1-9]+/.test(rownum)) {
            rownum = parseInt(rownum);
        }
        return {col: colnum, row: rownum};
    }

    //获取单元格的值
    function getCellValueToNumeric(cell, table) {
        var cellText = getCellValueToText(cell, table);
        if(cellText){
            var v = parseFloat(cellText);
            if (!isNaN(v)) {
                return v;
            }
        }
        return 0;
    }

    function getCellValueToText(cell, table){
        var cellNo = getCellNo(cell);
        var colnum = cellNo.col;
        var rownum = cellNo.row;

        var cell = table.find("tr").eq(rownum - 1).find("td").eq(colnum - 1);
        if (cell[0]) {
            return $.trim(cell.text());
        }
        return null;
    }

    function isEmptyCell(cell, table){
        var cellNo = getCellNo(cell);
        var colnum = cellNo.col;
        var rownum = cellNo.row;

        var cell = table.find("tr").eq(rownum - 1).find("td").eq(colnum - 1);
        if(cell[0]){
            var text = $.trim(cell.text());
            if(text.length>0) return false;
        }
        return true;
    }

    function findTr(table, row) {
        return table.find("tr").eq(row);
    }

    function findTd(table, row, col) {
        return table.find("tr").eq(row).find("td").eq(col);
    }

    //解析表达式
    function parseExp(exp) {
        return exp.match(cellNoRxp);
    }

    //表达式类型：
    //1. A1,A2
    //2. A1:A2
    //3. A1+
    //4. A1-
    //5. 单个值
    function parseExpType(exp) {
        if (exp.indexOf(",") > 0) return 1;
        if (exp.indexOf(":") > 0) return 2;
        if (exp.indexOf("+") > 0) return 3;
        if (exp.indexOf("-") > 0) return 4;
        return 5;
    }

    //将表达式解析为单元格
    function parseExpToCells(exp, table) {
        var cells = [];
        var type = parseExpType(exp);
        var arr, cellNo, td;
        switch (type) {
            case 1:
                arr = exp.split(",");
                for (var i = 0; i < arr.length; i++)
                    cells.push($.trim(arr[i]));
                break;
            case 2:
                arr = exp.split(":");
                var startCellNo = getCellNo($.trim(arr[0]));
                var endCellNo = getCellNo($.trim(arr[1]));
                //如果方向，则调换位置。如A1:B2 写为 B2:A1
                if (startCellNo.row > endCellNo.row) {
                    var temp = startCellNo;
                    startCellNo = endCellNo;
                    endCellNo = temp;
                }
                for (var i = startCellNo.row; i <= endCellNo.row; i++) {
                    for (var j = startCellNo.col; j <= endCellNo.col; j++) {
                        cells.push(numToChar(j) + i);
                    }
                }
                break;
            case 3:
                arr = exp.split("+");
                cellNo = getCellNo($.trim(arr[0]));
                while (true) {
                    td = findTd(table, cellNo.row - 1, cellNo.col - 1);
                    if (!td[0]) break;
                    cells.push(numToChar(cellNo.col) + cellNo.row);
                    cellNo.row++;
                }
                break;
            case 4:
                arr = exp.split("-");
                cellNo = getCellNo($.trim(arr[0]));
                while (true) {
                    td = findTd(table, cellNo.row - 1, cellNo.col - 1);
                    if (!td[0]) break;
                    cells.push(numToChar(cellNo.col) + cellNo.row);
                    cellNo.col++;
                }
                break;
            case 5:
                cells.push($.trim(exp));
                break;
        }
        return cells;
    }

    //普通计算
    this.calc = function (exp, table) {
        var cells = parseExp(exp);
        if (cells) {
            for (var i = 0; i < cells.length; i++) {
                var cell = cells[i];
                exp = exp.replace(new RegExp(cell), getCellValueToNumeric(cell, table));
            }
            try {
                return eval(exp);
            } catch (e) {
                return 0;
            }
        }
        return 0;
    };
    //求和
    this.sum = function (exp, table) {
        if (/sum\s*\((.*)\)/.exec(exp))
            exp = RegExp.$1;
        else return 0;
        var cells = parseExpToCells(exp, table);
        if (cells) {
            var sumVal = 0;
            for (var i = 0; i < cells.length; i++) {
                sumVal += parseFloat(getCellValueToNumeric(cells[i], table));
            }
            return sumVal;
        }
        return 0;
    };
    //平均值
    this.avg = function (exp, table) {
        if (/avg\s*\((.*)\)/.exec(exp))
            exp = RegExp.$1;
        else return 0;
        var cells = parseExpToCells(exp, table);
        if (cells) {
            var sumVal = 0, c = 0;
            for (var i = 0; i < cells.length; i++) {
                if(!isEmptyCell(cells[i], table)){
                    sumVal += parseFloat(getCellValueToNumeric(cells[i], table));
                    c++;
                }
            }
            return sumVal / cells.length;
        }
        return 0;
    };
    //最大值
    this.max = function (exp, table) {
        if (/max\s*\((.*)\)/.exec(exp))
            exp = RegExp.$1;
        else return 0;
        var cells = parseExpToCells(exp, table);
        if (cells) {
            var maxVal = 0;
            for (var i = 0; i < cells.length; i++) {
                var val = parseFloat(getCellValueToNumeric(cells[i], table));
                maxVal = val > maxVal ? val : maxVal;
            }
            return maxVal;
        }
        return 0;
    };
    //计数
    this.count = function (exp, table) {
        if (/count\s*\((.*)\)/.exec(exp))
            exp = RegExp.$1;
        else return 0;
        var cells = parseExpToCells(exp, table);
        if (cells) {
            var c = 0;
            for (var i = 0; i < cells.length; i++) {
                if(!isEmptyCell(cells[i], table)) c++;
            }
            return c;
        }
        return 0;
    };
}

