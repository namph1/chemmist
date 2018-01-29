<%-- 
    Document   : js
    Created on : Oct 23, 2017, 9:51:26 AM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
    $(document).ready(function () {
        var today = new Date();
        var mm = today.getMonth() + 1; //Month starts from 0
        var yyyy = today.getFullYear();
        var day = today.getDate();
        if (mm < 10) {
            mm = '0' + mm;
        }
        if (day < 10) {
            day = '0' + day;
        }
        today = mm + '/' + yyyy;
        $('#fromDate').val(today);
        $('#datepicker1').datepicker({
            autoclose: true,
            todayHighlight: true,
            format: 'mm/yyyy',
            language: 'vi',
            todayBtn: true
        });
        onSearch(1);
    });

    function onGoPage(elePage) {
        onSearch(elePage);
    }


    function onSearch(currPage) {
        var search = {};
        search["pageCurrent"] = currPage;
        search["from"] = $('#fromDate').val().trim();
        search["customerCode"] = $('#code').val().trim();
        search["type"] = $('#type').val().trim();

        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/debit/search"
        }).done(function (data) {
            $("#divTable").html(data);
            $('[data-toggle="tooltip"]').tooltip();
        });
    }

    function onDetail(id, name, type) {
        var search = {};
        search["customerId"] = id;
        search["from"] = $('#fromDate').val().trim();
        search["type"] = type;
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/debit/onDetail"
        }).done(function (data) {
            $("#divConfig").html(data);
            $('#ojectAdd').modal('show');
            $('#lblTitle').html("Chi tiết công nợ " + name);
        });

    }
    
    function onExport() {
        var from = $('#fromDate').val().trim();
        var code = $('#code').val().trim();
        var type = $('#type').val().trim();

        location.href = "<%=request.getContextPath()%>/debit/exportExcel?code=" + code + "&from=" + from + "&type=" + type;
    }
    
    function onRefresh() {
        $.confirm({
            title: 'Chọn tháng- năm để chốt sổ.',
            content: '' +
                    '<form action="" class="formName">' +
                    '<div class="form-group">' +
                    '<div class="input-group date" id="datepicker4">' +
                    ' <input type="text" class="form-control pull-right" id="monthOfYear" >' +
                    ' <div class="input-group-addon">' +
                    ' <i class="fa fa-th"></i>' +
                    ' </div>' +
                    ' </div>' +
                    '</div>' +
                    '</form>',
            buttons: {
                confirm: {
                    text: 'Chốt tồn',
                    btnClass: 'btn-blue',
                    action: function () {
                        var month = $('#monthOfYear').val();
                        if (!month) {
                            showMessage("Chọn tháng-năm","ERROR");
                            return false;
                        }
                        var search = {};
                        search["fromDate"] = month;
                        $.ajax({
                            type: "POST",
                            contentType: "application/json",
                            url: "<%=request.getContextPath()%>/debit/chotso",
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
                            }
                        });
                    }
                },
                cancel:{text: 'Hủy',
                    btnClass: 'btn-red'}
            },
            onContentReady: function () {
                // bind to events
                $('#datepicker4').datepicker({
                    autoclose: true,
                    todayHighlight: true,
                    format: 'mm/yyyy',
                    language: 'vi',
                    todayBtn: true
                });
            }
        });
    }
</script>
