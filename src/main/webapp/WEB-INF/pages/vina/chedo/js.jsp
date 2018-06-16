<%-- 
    Document   : js
    Created on : Jun 11, 2018, 8:16:02 AM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
    $(document).ready(function () {
        onSearch(1);
    });

    function onGoPage(elePage) {
        onSearch(elePage);
    }

    function onSearch(currPage) {
        var search = {};
        search["pageCurrent"] = currPage;
        search["code"] = $('#code').val().trim();
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/vina/chedo/search"
        }).done(function (data) {
            $("#divTable").html(data);
        });
    }

    function importExcel() {
        $.confirm({
            title: 'Chọn file excel.',
            closeIcon: true,
            closeIconClass: 'fa fa-close',
            columnClass: 'col-md-5 col-md-offset-4',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group ">' +
                    '<label class="control-label required">File excel</label>' +
                    '<input type="file" placeholder="Nhập họ và tên" id="excelfile" name="file" class="excelfile form-control"/>' +
                    '</div>' +
                    '</form>',
            buttons: {
                formSubmit: {
                    text: 'Lưu',
                    btnClass: 'btn-blue',
                    action: function () {
                        var file = $('#excelfile')[0].files[0];
                        var param = new FormData();
                        param.append('file', file);
                        $.ajax({
                            url: '<%=request.getContextPath()%>/vina/chedo/upload',
                            data: param,
                            cache: false,
                            contentType: false,
                            processData: false,
                            enctype: 'multipart/form-data',
                            type: 'POST',
                            success: function (data) {
                            },
                            error: function (e) {
                                showError('Có lỗi xảy ra');
                            },
                            done: function (e) {
                                console.log("DONE");
                            }
                        });
                    }
                },
                cancel: {
                    text: 'Hủy bỏ',
                    btnClass: 'btn-danger'
                },
            }
        });
    }

    function prepareAdd() {
        $("#add-id").val('');
        $("#add-code").val('');
        $("#add-name").val('');
        $("#add-money").val('');
        $("#add-content").val('');
        $('#lblTitle').html("Thêm mới chế độ");
        $('#ojectAdd').modal('show');
    }
    function prepareEdit(id, code, name, money, content) {
        $("#add-id").val(id);
        $("#add-code").val(code);
        $("#add-name").val(name);
        $("#add-money").val(numberWithCommas(money));
        $("#add-content").val(content);
        $('#lblTitle').html("Cập nhật");
        $('#ojectAdd').modal('show');
    }
    
    function lockUnlock(id, status, name) {
        var content = "";
        if (status == 1) {
            content = 'Bạn chắc chắn muốn <b>NGƯNG SỬ DỤNG</b> chế độ của : <b>' + name + ' </b>?';
        } else {
            content = 'Bạn chắc chắn muốn chế độ khách hàng: ' + name + '<b> HOẠT ĐỘNG</b>?';
        }

        $.confirm({
            theme: 'material',
            animationSpeed: 200,
            animationBounce: 1.5,
            title: 'Cảnh báo!',
            content: content,
            buttons: {
                confirm: {text: 'Đồng ý',
                    btnClass: 'btn-blue',
                    action: function () {
                        var search = {};
                        search["id"] = id;
                        search["status"] = 1 - status;
                        $.ajax({
                            type: "POST",
                            contentType: "application/json",
                            url: "<%=request.getContextPath()%>/vina/chedo/lockUnlock",
                            data: JSON.stringify(search),
                            dataType: 'json',
                            timeout: 100000,
                            success: function (data) {
                                showMessage(data, "SUCCESS");
                                onSearch(1);
                            },
                            error: function (e) {
                                console.log("ERROR: ", e);
                            },
                            done: function (e) {
                                console.log("DONE");
                            }
                        });
                    }},
                cancel: {text: 'Hủy',
                    btnClass: 'btn-red'}
            }
        });
    }
    
    function onCreate() {
        var id = $("#add-id").val();

        var add = {};
        if (null != id && id != '') {
            add["id"] = $("#add-id").val();
        }
        add["code"] = $("#add-code").val();
        add["name"] = $("#add-name").val();
        add["money"] = $("#add-money").val().replace(/\./g, '').replace(/\,/g, '').trim();
        add["content"] = $("#add-content").val();
         
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/vina/chedo/add",
            data: JSON.stringify(add),
            dataType: 'json',
            timeout: 100000,
            success: function (data) {
                $('#ojectAdd').modal('hide');
                showMessage("", "SUCCESS");
                onSearch(1);
            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        });
    }
</script>
