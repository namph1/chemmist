<%-- 
    Document   : js
    Created on : Sep 20, 2017, 11:21:32 AM
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
        search["name"] = $('#name').val();
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/unit/search"
        }).done(function (data) {
            $("#divTable").html(data);
        });
    }

    function prepareAdd() {
        $("#add-id").val('');
        $("#add-name").val('');
        $("#add-note").val('');
        $('#ojectAdd').modal('show');
        $('#lblTitle').text("Thêm mới đơn vị");
    }

    function prepareEdit(id, name,  note) {
        $("#add-id").val(id);
        $("#add-name").val(name);
        $("#add-note").val(note);
        $('#ojectAdd').modal('show');
        $('#lblTitle').text("Cập nhật đơn vị");
    }

    function onCreate() {
        var id = $("#add-id").val();
        var add = {};
        if (null != id && id != '') {
            add["id"] = $("#add-id").val();
        }
        add["name"] = $("#add-name").val().trim();
        add["note"] = $("#add-note").val().trim();

        if ($("#add-name").val() == null || $("#add-name").val().trim() == '') {
            showMessage("Hãy nhập tên đơn vị", "ERROR");
             $("#add-name").focus();
            return;
        }

        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/unit/add",
            data: JSON.stringify(add),
            dataType: 'json',
            timeout: 100000,
            success: function (data) {
                $('#ojectAdd').modal('hide');
                showMessage("", "SUCCESS");
                onSearch(1);
            },
            error: function (e) {
                showMessage(e, "ERROR");
            },
            done: function (e) {
                console.log("DONE");
            }
        });
    }
</script>