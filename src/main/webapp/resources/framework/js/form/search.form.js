/** 搜索表单
 * Created by zengc on 2016-12-18.
 */
$.fn.searchForm = function (options) {
    var _def = {
        ajax : true, //是否异步提交
        loadingText : "正在查询...",
        trigger: {
            select: false, //是否切换下拉框后自动提交
            input: false //是否输入、切换按钮时自动提交
        },
        target : { //搜索目标对象
            type : "none",//类型
            handler : function(){//对象
                return options.onSearch;
            }
        },
        onSearch: function () {}
    };
    var _target = {
        "none" : function(handler, params, btn){
            if(handler && $.isFunction(handler)){
                handler()(params);
            }
            _delayReset(btn);
        },
        "jqgrid" : function(grid, params, btn){
            if(grid){
                grid.reload(params);

                _delayReset(btn);
            }
        }
    };
    options = $.extend(_def, options);

    function _delayReset(btn){
        setTimeout(function(){
            btn.button("reset");
        }, 300);
    }
    //异步提交表单
    function _ajaxSubmitForm(form){
        var btnSubmit = form.find("button[type='submit'], input[type='submit']");
        var target = _target[options.target.type];
        if(target && $.isFunction(target)){
            btnSubmit.attr("data-loading-text", options.loadingText);
            btnSubmit.button("loading");
            target(options.target.handler, ns.form.serialize(form), btnSubmit);
        }
    }
    $(this).each(function (i, n) {
        var form = $(n);

        if (form.is("[data-parsley-validate]")) {
            form.on("submit", function () {
                return false;
            });
            form.parsley().on("form:submit", function () {
                _ajaxSubmitForm(form);
                return false;
            });
        } else {
            form.on("submit", function () {
                if(options.ajax){
                    _ajaxSubmitForm(form);
                    return false;
                }else{
                    return true;
                }
            });
        }

        if(options.trigger.select){
            form.find("select").on("change", function(){
                form.submit();
            });
        }
        if(options.trigger.input){
            form.find("input[type='text'],input[type='radio'],input[type='checkbox']").on("change", function(){
                form.submit();
            });
        }
    });

    return this;
}