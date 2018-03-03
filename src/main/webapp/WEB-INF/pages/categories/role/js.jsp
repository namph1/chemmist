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
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/system/role/search"
        }).done(function (data) {
            $("#divTable").html(data);
        });
    }

    function prepareAdd() {
        $("#add-id").val('');
        $("#add-name").val('');
        $("#add-note").val('');
        $('#lblTitle').html("Thêm mới nhóm quyền");
        $('#ojectAdd').modal('show');
    }

    function onCreate() {
        var id = $("#add-id").val();

        var add = {};
        if (null != id && id != '') {
            add["roleId"] = $("#add-id").val();
        }
        add["name"] = $("#add-name").val().toUpperCase();
        add["note"] = $("#add-note").val();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/system/role/add",
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

    function prepareEdit(id, name, note) {
        $("#add-id").val(id);
        $("#add-name").val(name);
        $("#add-note").val(note);
        $('#lblTitle').html("Thay đổi nhóm quyền");
        $('#ojectAdd').modal('show');
        $('#div-pass').hide();
    }

    function prepareAssign(id, name) {
        var search = {};
        search["roleId"] = id;

        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/system/role/prepareConfig"
        }).done(function (data) {
            $("#divConfig").html(data);
            $('#lblTitleAss').html("Quyền truy cập menu của nhóm quyền - " + name);
            $('#objectConfig').modal('show');
            $('#roleId').val(id);
            $("#treeview").hummingbird();
            $.fn.hummingbird.defaults.checkDoubles= true; 
            var ids = JSON.parse($('#ids').val());
            var idsAct = JSON.parse($('#idsAct').val());
            if (idsAct.length > 0) {
                for (var i in idsAct) {
                    $("#treeview").hummingbird("checkNode", {
                        attr: "id",
                        name: idsAct[i]
                    });
                }
            }

        });
    }

    function onAssign() {
        var list = [];
        $("#treeview").hummingbird("getChecked", {
            attr: "id",
            list: list,
            onlyEndNodes: false
        });
        var add = {};
        add["lstIdsMenu"] = list;
        add["roleId"] = $('#roleId').val();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/system/role/ass",
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
