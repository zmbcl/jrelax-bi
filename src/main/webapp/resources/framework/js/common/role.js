/**
 * 角色选择组件
 * 依赖main.js
 * Created by zengc on 2016-06-02.
 */

if(!ns.common){
    ns.common = {};
}
ns.common.role = {
    select: function (options) {
        var _def = {
            multi: false,
            callback: function (data) {
                //alert(JSON.stringify(data));
            }
        };
        options = $.extend(options, _def);

        var modal = ns.view.showModal(ns.getBasePath() + "/common/role/select?multi=" + options.multi, {
            onShown: function () {
                //ok按钮
                var btnOk = modal.find("#ok");
                btnOk.bind("click", function () {
                    var tree = $.jstree.reference(modal.find("#__jsTreeRole"));
                    var nodes = tree.get_selected();

                    var data = [];

                    $.each(nodes, function (i, node) {
                        var obj = {};
                        obj.id = node;
                        obj.name = tree.get_text(node);
                        data.push(obj);
                    });

                    options.callback(data);
                    modal.close();
                });
            }
        });
    }
}