<%-- 
    Document   : js
    Created on : Sep 20, 2017, 2:37:54 PM
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
        search["name"] = $('#name').val().trim();
        search["phone"] = $('#phone').val().trim();
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/customer/search"
        }).done(function (data) {
            $("#divTable").html(data);
        });
    }

    function lockUnlock(id, status, name) {
        var content = "";
        if (status == 1) {
            content = 'Bạn chắc chắn muốn <b>NGƯNG HOẠT ĐỘNG</b> khách hàng: <b>' + name + ' </b>?';
        } else {
            content = 'Bạn chắc chắn muốn khách hàng: ' + name + '<b> HOẠT ĐỘNG</b>?';
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
                        search["status"] = status;
                        $.ajax({
                            type: "POST",
                            contentType: "application/json",
                            url: "<%=request.getContextPath()%>/customer/lockUnlock",
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


    function prepareAdd() {
        $("#add-id").val('');
        $("#add-name").val('');
        $("#add-phone").val('');
        $("#add-address").val('');
        $("#add-fb").val('');
        $('#lblTitle').html("Thêm mới đại lý- khách hàng");
        $('#ojectAdd').modal('show');
    }


    function onCreate() {
        var id = $("#add-id").val();

        var add = {};
        if (null != id && id != '') {
            add["id"] = $("#add-id").val();
        }
        add["name"] = $("#add-name").val();
        add["phone"] = $("#add-phone").val();
        add["address"] = $("#add-address").val();
        add["facebook"] = $("#add-fb").val();
         
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/customer/add",
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

    function prepareEdit(id, name, address, code, phone,fb) {
        $("#add-id").val(id);
        $("#add-name").val(ucword(name));
        $("#add-phone").val(phone);
        $("#add-address").val(address);
        $("#add-fb").val(fb);
        $('#lblTitle').html("Cập nhật đại lý- khách hàng: " + code);
        $('#ojectAdd').modal('show');
    }

    function changeFormatUpper(val) {
        $("#add-name").val(ucword($("#add-name").val()));

    }

</script>