<%-- 
    Document   : js
    Created on : Oct 13, 2017, 2:36:26 PM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
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
        today = '/' + mm + '/' + yyyy;
        $('#fromDate').val('01' + today);
        $('#toDate').val(day + today);
        $('#datepicker1').datepicker({
            autoclose: true,
            todayHighlight: true,
            format: 'dd/mm/yyyy',
            language: 'vi',
            todayBtn: true
        });
        $('#datepicker2').datepicker({
            autoclose: true,
            todayHighlight: true,
            format: 'dd/mm/yyyy',
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
        search["fromDate"] = $('#fromDate').val().trim();
        search["toDate"] = $('#toDate').val().trim();
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/tonkho/search"
        }).done(function (data) {
            $("#divTable").html(data);
        });
    }

    function onExport() {
        var from = $('#fromDate').val().trim();
        var to = $('#toDate').val().trim();

        location.href = "<%=request.getContextPath()%>/tonkho/exportExcel?from=" + from + "&to=" + to;
    }

    function onRefresh() {
        $.confirm({
            title: 'Chọn tháng- năm để chốt tồn kho.',
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
                            url: "<%=request.getContextPath()%>/tonkho/chotton",
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
