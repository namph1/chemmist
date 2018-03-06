<%-- 
    Document   : js
    Created on : Sep 25, 2017, 1:50:09 PM
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
        $('#r2').on('ifChecked', function (event) {
            $('.collapse').collapse('show');
        });
        $('#r2').on('ifUnchecked', function (event) {
            $('.collapse').collapse('hide');
        });
    });

    function onGoPage(elePage) {
        onSearch(elePage);
    }

    function changeFormatUpper(val) {
        $("#add-name").val(ucword($("#add-name").val()));

    }

    function onSearch(currPage) {
        var search = {};
        search["parentId"] = $('#leaderId').val();
        search["name"] = $('#name').val();
        search["code"] = $('#code').val();
        search["pageCurrent"] = currPage;
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/employee/search"
        }).done(function (data) {
            $("#divTable").html(data);
            $('[data-toggle="tooltip"]').tooltip();
        });
    }

    function lockUnlock(id, status, name) {
        var content = "";
        if (status == 1) {
            content = 'Bạn chắc chắn muốn <b>NGƯNG HOẠT ĐỘNG</b> nhân viên: <b>' + name + ' </b>?';
        } else {
            content = 'Bạn chắc chắn muốn nhân viên: ' + name + '<b> HOẠT ĐỘNG</b>?';
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
                            url: "<%=request.getContextPath()%>/employee/lockUnlock",
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
        $('#leader').val(-1);
        $('#lblTitle').html("Thêm mới nhân viên");
        $('#ojectAdd').modal('show');
        $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass: 'iradio_minimal-blue'
        });
        $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
            checkboxClass: 'icheckbox_flat-blue',
            radioClass: 'iradio_flat-blue'
        });
        $('#r1').iCheck('check');
        $('.collapse').collapse('hide');
        $('#r2').on('ifChecked', function (event) {
            $('.collapse').collapse('show');
        });
        $('#r2').on('ifUnchecked', function (event) {
            $('.collapse').collapse('hide');
        });
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
        var is_check = $('#r2').prop('checked');
        if (is_check) {
            add["levels"] = 0;
            add["parentId"] = $('#leader').val();
            if ($('#leader').val() == null || $('#leader').val() == -1) {
                showMessage("Là thành viên! Hãy chọn nhóm trưởng!", "ERROR");
                return;
            }
        } else if ($('#r1').prop('checked')) {
            add["levels"] = 1;
        }

        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/employee/add",
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

    function prepareEdit(id, name, address, phone, isParent, parentId) {
        $("#add-id").val(id);
        $("#add-name").val(name);
        $("#add-phone").val(phone);
        $("#add-address").val(address);
        $('#lblTitle').html("Cập nhật nhân viên");
        $('#ojectAdd').modal('show');
        $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
            checkboxClass: 'icheckbox_flat-blue',
            radioClass: 'iradio_flat-blue'
        });
        if (isParent == 1) {
            $('#r1').iCheck('check');
            $('.collapse').collapse('hide');
        } else if (isParent == 0) {
            $('#r2').iCheck('check');
            $('.collapse').collapse('show');
            $('#leader').val(parentId);
        }
        $('#r2').on('ifChecked', function (event) {
            $('.collapse').collapse('show');
        });
        $('#r2').on('ifUnchecked', function (event) {
            $('.collapse').collapse('hide');
        });
    }

    function prepareAssign(id, name) {
        var search = {};
        search["id"] = id;
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/employee/prepareConfig"
        }).done(function (data) {
            $("#divConfig").html(data);
            $('#objectConfig').modal('show');
            $('#empId').val(id);
            $('#lblTitleAss').html("Gán đại lý vào tiếp thị - " + name);
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
        var arrCusId = $('#selectAss').val();
        var add = {};
        add["strCusId"] = arrCusId.toString();
        add["id"] = $('#empId').val();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/employee/ass",
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
