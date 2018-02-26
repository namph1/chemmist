<%-- 
    Document   : js
    Created on : Sep 17, 2017, 1:54:39 PM
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
        search["name"] = $('#name').val().trim();
        search["pageCurrent"] = currPage;
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/g_product/search"
        }).done(function (data) {
            $("#divTable").html(data);
        });

    }

    function onCreate() {
        var id = $("#add-id").val();

        var add = {};
        if (null != id && id != '') {
            add["id"] = $("#add-id").val();
        }
        add["name"] = $("#add-name").val().trim();
        add["note"] = $("#add-note").val().trim();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/g_product/add",
            data: JSON.stringify(add),
            dataType: 'json',
            timeout: 100000,
            success: function (data) {
                if (data > 0) {
                    $('#ojectAdd').modal('hide');
                    showMessage("Thành công", "SUCCESS");
                    onSearch(1);
                }
            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        });
    }

    function lockUnlock(id, name) {
        var content = "";
        content = 'Bạn chắc chắn muốn <b>xóa</b> nhóm sản phẩm ' + name;

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
                        search["status"] = status;
                        $.ajax({
                            type: "POST",
                            contentType: "application/json",
                            url: "<%=request.getContextPath()%>/g_product/del",
                            data: JSON.stringify(search),
                            dataType: 'json',
                            timeout: 100000,
                            success: function (data) {
                                if (data > 0) {
                                    showMessage("Thành công", "SUCCESS");
                                    onSearch(1);
                                } else {
                                    showMessage("Thất bại", "ERROR");
                                }
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

    function prepareEdit(id, name, note) {
        $("#add-id").val(id);
        $("#add-name").val(name);
        $("#add-note").val(note);
        $('#lblTitle').text("Cập nhật nhóm sản phẩm");
        $('#ojectAdd').modal('show');
    }

    function prepareAdd() {
        $("#add-id").val('');
        $("#add-name").val('');
        $("#add-note").val('');
        $('#lblTitle').text("Thêm mới nhóm sản phẩm");
        $('#ojectAdd').modal('show');
    }



</script>
