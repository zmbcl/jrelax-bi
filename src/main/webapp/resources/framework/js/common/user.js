/**
 * 用户选择组件
 * 依赖main.js
 * Created by zengc on 2016-06-02.
 */
if(!ns.common){
    ns.common = {};
}
ns.common.user = {
    select : function(options){
        var _def = {
            multi:false,
            callback : function(data){}
        };
        options = $.extend(options, _def);

        var modal = ns.view.showModal(ns.getBasePath()+"/common/user/select?multi="+options.multi,{onShown:function(){
            var sBtn = modal.find("#btnSearch");
            sBtn.bind("click", function(){
                var sText = modal.find("#searchText").val();
                var oForm = modal.find("#userSelectForm");
                oForm.find("input:hidden[name='key']").val(sText);
                var hash = oForm.attr("pager_hash");
                eval("pager_"+hash+".reload()");
            });

            //ok按钮
            var btnOk = modal.find("#ok");
            btnOk.bind("click", function(){
                var ids = ns.form.check('#userSelectForm').getChecks();
                var data = [];

                $.each(ids, function(i, id){
                    var obj = {};
                    obj.id = id;
                    obj.username = modal.find("#"+id+"_un").text();
                    obj.realname = modal.find("#"+id+"_rn").text();
                    obj.mobile = modal.find("#"+id+"_mb").text();

                    data.push(obj);
                });

                options.callback(data);
                modal.close();
            });
        }});
    },
    selectByUnit : function(options){
        var _def = {
            multi:false,
            callback : function(data){}
        };
        options = $.extend(options, _def);

        var modal = ns.view.showModal(ns.getBasePath()+"/common/user/select-unit?multi="+options.multi,{onShown:function(){
            //ok按钮
            var btnOk = modal.find("#ok");
            btnOk.bind("click", function(){
                var ids = ns.form.check('#userSelectByUnitForm').getChecks();
                var data = [];

                $.each(ids, function(i, id){
                    var obj = {};
                    obj.id = id;
                    obj.username = modal.find("#"+id+"_un").text();
                    obj.realname = modal.find("#"+id+"_rn").text();
                    obj.mobile = modal.find("#"+id+"_mb").text();

                    data.push(obj);
                });

                options.callback(data);
                modal.close();
            });
        }});
    },
    selectByUnitAndRole : function(options){
        var _def = {
            multi:false,
            callback : function(data){}
        };
        options = $.extend(options, _def);

        var modal = ns.view.showModal(ns.getBasePath()+"/common/user/select-unit-role?multi="+options.multi,{size:"modal-lg",onShown:function(){
            //ok按钮
            var btnOk = modal.find("#ok");
            btnOk.bind("click", function(){
                var ids = ns.form.check('#userSelectByUnitAndRoleForm').getChecks();
                var data = [];

                $.each(ids, function(i, id){
                    var obj = {};
                    obj.id = id;
                    obj.username = modal.find("#"+id+"_un").text();
                    obj.realname = modal.find("#"+id+"_rn").text();
                    obj.mobile = modal.find("#"+id+"_mb").text();

                    data.push(obj);
                });

                options.callback(data);
                modal.close();
            });
        }});
    }
}
