function NSUploader() {
    var $url = ns.getBasePath() + "/common/upload";
    var $id = "__divUploader" + (new Date().getTime());
    var $modal = null;
    this.type = {
        image : "jpg, jpeg, png, gif, bmp",
        office : "doc, docx, xls, xlsx, ppt, pptx",
        video : "mp4, avi, mkv, mov, rm, wmv, flv"
    };
    var $options = {};
    var _def = {
        filter: "",// 文件类型过滤，传入 *.jpg,*.png
        autoclose: true, //上传完成后，自动关闭
        autoname: false, // 是否自动命名
        filepath: "",// 服务器端保存路径
        showfilename: false,
        showfilepath: false, //显示文件上次保存路径
        multiple: true,//多文件选择
        success: function () {
        },
        error: null
    }
    this.init = function () {
        var oDiv = "<div id=\"" + $id + "\" class=\"modal fade bs-modal-sm\" tabindex=\"-3\" role=\"dialog\" aria-hidden=\"true\"><div class=\"modal-dialog\"><div class=\"modal-content\"></div></div></div>";
        $("body").append(oDiv);
        $modal = $("#" + $id);
    };
    this.open = function (opt) {
        $options = $.extend(_def, opt);
        this.init();
        $modal.modal({show: true, remote: $url});
        //关闭窗口后
        $modal.on("hidden.bs.modal", function () {
            $modal.remove();
        });
        //远程加载完成后
        $modal.on("loaded.bs.modal", function () {
            checkZIndex();
            var $form = $modal.find("form");
            $form.ajaxForm({
                beforeSubmit: function (arr, $form, op) {
                    if ($options.filter.length > 0) {
                        var name = $form.find("input:file").val();
                        return checkFilter(name);
                    } else {
                        var name = $form.find("input:file").val();
                        if (name == "") {
                            showError("请先选择文件再点击上传");
                            return false;
                        }
                    }
                    $form.find("#ok").button("loading");
                },
                beforeSend: function () {
                    showProgressBar();
                },
                uploadProgress: function (event, postion, total, percentComplete) {
                    var procbar = $modal.find(".progress-bar");
                    $modal.find("#cur").text(sizeFormat(postion));
                    procbar.css("width", percentComplete + "%");
                },
                success: function (data, statusText, xhr, $form) {
                    onSuccess(data);
                    $form.find("#ok").button("reset");
                }
            });

            //自动获取名字
            if ($options.autoname == true) {
                $form.find("input:file").bind("change", function () {
                    var name = $(this).val();
                    name = name.substring(name.lastIndexOf("\\") + 1);
                    name = name.substring(name.lastIndexOf("/") + 1);
                    name = name.substring(0, name.lastIndexOf("."));
                    $form.find("input[name='filename']").val(name);
                });
            }
            //存放路径
            if ($options.filepath) {
                $form.find("input[name='filepath']").val($options.filepath);
            }
            //是否显示文件名
            if ($options.showfilename == true) {
                $form.find("input[name='filename']").parent().show();
            }
            //是否显示存放路径
            if ($options.showfilepath == true) {
                $form.find("input[name='filepath']").parent().show();
            }
            //文件选择框美化
            var input_file = $form.find("input[name='file']");
            //取消多文件选择
            if ($options.multiple == false) {
                input_file.removeAttr("multiple");
            }
            input_file.bind("change", function () {
                if (this.files) {
                    var path = this.value;
                    var dir = "";
                    if (path.indexOf("\\") >= 0) {
                        dir = path.substring(0, path.lastIndexOf("\\"));
                    } else {
                        dir = path.substring(0, path.lastIndexOf("/"));
                    }
                    var paths = [];
                    $.each(this.files, function (i, n) {
                        paths.push(dir + "/" + n.name);
                    });
                    input_file.next().find("input").val(paths.toString());
                } else {
                    input_file.next().find("input").val($(this).val());
                }
            });
            input_file.next().find(".btn").bind("click", function () {
                input_file.click();
            });

            enableDrop($form);
        });
    };

    //初始化拖拽上传功能
    function enableDrop($form) {
        $(document).on({
            //拖离
            dragleave: function (e) {e.preventDefault();},
            //拖后放
            drop: function (e) {e.preventDefault();},
            //拖进
            dragenter: function (e) {e.preventDefault();},
            //拖来拖去
            dragover: function (e) {e.preventDefault();}
        });
        var dropArea = $form.find("#dropArea")[0];
        var dropTip = $(dropArea).find("h3").text();
        dropArea.addEventListener("drop", function (e) {
            e.preventDefault();
            var fileList = e.dataTransfer.files; //获取文件对象

            if (fileList.length == 0) return false;

            var formData = new FormData($form[0]);
            for (var i = 0; i < fileList.length; i++) {
                var file = fileList[i];
                if (checkFilter(file.name)) {
                    formData.append('file', file);
                } else {
                    return;
                }
            }

            $form.find("#ok").button("loading");
            $.ajax({
                url: $form.attr("action"),
                type: "post",
                data: formData,
                processData: false,
                contentType: false,
                success: function (data) {
                    onSuccess(data);
                    $form.find("#ok").button("reset");
                }
            });
        });
        dropArea.addEventListener("dragover", function () {
            $(dropArea).addClass("bg-default");
            $(dropArea).find("h3").text("松开鼠标以上传");
        });
        dropArea.addEventListener("dragleave", function () {
            $(dropArea).removeClass("bg-default");
            $(dropArea).find("h3").text(dropTip);
        });
        dropArea.addEventListener("drop", function () {
            $(dropArea).removeClass("bg-default");
            $(dropArea).find("h3").text(dropTip);
        });
    }

    function checkZIndex() {
        //防止遮罩层重叠
        $modal.next().css("zIndex", parseInt($modal.css("zIndex")) + $(".modal").length * 2);
        $modal.css("zIndex", parseInt($modal.css("zIndex")) + $(".modal").length * 4);
    }

    function checkFilter(name) {
        if ($options.filter.length == 0) return true;
        try {
            var ext = name.substring(name.lastIndexOf(".") + 1).toLowerCase();
            var result = false;
            var filters = $options.filter.split(",");
            for (var i = 0; i < filters.length; i++) {
                if ($.trim(filters[i].toLowerCase()) == $.trim(ext)) {
                    result = true;
                    break;
                }
            }
            if (!result) {
                showError("文件类型限制为：" + $options.filter + "");
                return false;
            }
            return true;
        } catch (e) {
            showError("文件类型限制为：" + $options.filter + "");
            return false;
        }
    }

    function onSuccess(data) {
        if (data.success == true) {
            if (typeof($options.success) == "function") {
                var names = [];
                $.each(data.path.split(","), function (i, n) {
                    n = n.substring(n.lastIndexOf("/") + 1);

                    names.push(n);
                });
                $options.success(data.path, names.toString());
            }
        } else {
            if (typeof($options.error) == "function") {
                $options.error(data.error);
            } else {
                ns.tip.toast.error(data.error);
            }
        }
        //默认自动关闭
        if ($options.autoclose == true) {
            ns.form.uploader.close();
        }
    }

    this.close = function () {
        $modal.modal("hide");
    };
    function sizeFormat(size) {
        size = size / 1024;
        if (size < 1024) return parseFloat(size).toFixed(1) + "KB";
        size = size / 1024;
        if (size < 1024) return parseFloat(size).toFixed(1) + "MB";
        size = size / 1024;
        if (size < 1024) return parseFloat(size).toFixed(1) + "GB";
    };

    function showProgressBar() {
        //获取上传进度信息
        var procbar = $modal.find(".progress-bar");
        var files = $modal.find("input:file")[0].files;
        var size = 0;
        $.each(files, function (i, n) {
            size += n.size;
        });
        $modal.find("#total").text(sizeFormat(size));
        procbar.parents(".form-group").show();
    }

    function showError(msg){
        ns.tip.toast.errorCenter(msg);
    }
}
//与ns绑定
ns.ready(function () {
    ns.form.uploader = new NSUploader();
});