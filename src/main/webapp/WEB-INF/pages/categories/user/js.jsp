<%-- 
    Document   : js
    Created on : Jan 30, 2018, 9:28:47 AM
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
        search["fullName"] = $('#fullName').val().trim();
        search["name"] = $('#name').val().trim();
        search["phone"] = $('#phone').val().trim();
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/system/user/search"
        }).done(function (data) {
            $("#divTable").html(data);
        });
    }

    function prepareAdd() {
        $("#add-id").val('');
        $("#add-name").val('');
        $("#add-username").val('');
        $("#add-pass").val('');
        $("#add-phone").val('');
        $("#add-email").val('');
        $('#lblTitle').html("Thêm mới người dùng");
        $('#ojectAdd').modal('show');
    }

    function onCreate() {
        var id = $("#add-id").val();

        var add = {};
        if (null != id && id != '') {
            add["userId"] = $("#add-id").val();
        } else {
            add["password"] = $("#add-pass").val();
        }
        add["name"] = $("#add-username").val();
        add["fullName"] = $("#add-name").val();
        add["phone"] = $("#add-phone").val();
        add["email"] = $("#add-email").val();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/system/user/add",
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

    function prepareEdit(id, name, email, phone, fullName) {
        $("#add-id").val(id);
        $("#add-name").val(fullName);
        $("#add-username").val(name);
        $("#add-phone").val(phone);
        $("#add-email").val(email);
        $('#lblTitle').html("Thay đổi thông tin người dùng");
        $('#ojectAdd').modal('show');
        $('#div-pass').hide();
    }
    
     function prepareAssign(id, name) {
        var search = {};
        search["userId"] = id;
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/system/user/prepareConfig"
        }).done(function (data) {
            $("#divConfig").html(data);
            $('#objectConfig').modal('show');
            $('#userId').val(id);
            $('#lblTitleAss').html("Gán nhóm quyền vào người dùng - " + name);
            $('.moveall i').removeClass("glyphicon glyphicon-arrow-right");
            $('.moveall i').addClass("fa fa-angle-double-right");
            $('.move i').removeClass("glyphicon glyphicon-arrow-right");
            $('.move i').addClass("fa fa-angle-double-right");
            $('.remove i').removeClass("glyphicon glyphicon-arrow-left");
            $('.remove i').addClass("fa fa-angle-double-left");
            $('.removeall i').removeClass("glyphicon glyphicon-arrow-left");
            $('.removeall i').addClass("fa fa-angle-double-left");
        });
    }
    
    function onAssign() {
        var arrRoleID = $('#selectAss').val();
        var add = {};
        add["strRoleId"] = arrRoleID.toString();
        add["userId"] = $('#userId').val();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/system/user/ass",
            data: JSON.stringify(add),
            dataType: 'json',
            timeout: 100000,
            success: function (data) {
                $('#objectConfig').modal('hide');
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
