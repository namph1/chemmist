<%-- 
    Document   : js
    Created on : Oct 14, 2017, 8:59:21 AM
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
        search["status"] = $('#status').val().trim();
        search["code"] = $('#code').val().trim();
        search["type"] = 2;

        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/transfer/search"
        }).done(function (data) {
            $("#divTable").html(data);
            $('[data-toggle="tooltip"]').tooltip();
        });
    }

    function prepareAdd(type) {
        if (type == 0) {
            $('#lblTitle').text('Thu chuyển khoản');
        } else {
            $('#lblTitle').text('Chi chuyển khoản');
        }
        
        $("#add-id").val('');
        $("#add-total").val('');
        $('#add-note').val('');
        $('#add-type').val(type);
        $('#ojectAdd').modal('show');
    }

    function formatCurrent() {
        var money = $('#add-total').val().replace(/\./g, '').trim();
        $('#add-total').val(numberWithCommas(money));
    }
    
    function onCreate() {
        var id = $("#add-id").val();

        var add = {};
        if (null != id && id != '') {
            add["id"] = $("#add-id").val();
        }
        var objectId = $("#add-customerId").val();
        if (objectId != null) {
            if (objectId.toString().includes("E")) {
                add["employeeId"] = parseInt(objectId.replace('E', ''));
                add["customerId"] = null;
            } else if (objectId.toString().includes("C")) {
                add["customerId"] = parseInt(objectId.replace('C', ''));
                add["employeeId"] = null;
            }
        }
        add["bankId"] = $("#add-bankId").val();
        add["total"] = $("#add-total").val().replace(/\./g, '').trim();
        add["note"] = $("#add-note").val();
        add["status"] = $("#add-type").val();
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/transfer/add",
            data: JSON.stringify(add),
            dataType: 'json',
            timeout: 100000,
            success: function (data) {
                $('#ojectAdd').modal('hide');
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
    }
    
    
    function onDelete(id) {
        var content = "";
        content = 'Bạn chắc chắn muốn xóa chứng từ chuyển khoản này?';

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
                        $.ajax({
                            type: "POST",
                            contentType: "application/json",
                            url: "<%=request.getContextPath()%>/cash/delete",
                            data: JSON.stringify(search),
                            dataType: 'json',
                            timeout: 100000,
                            success: function (data) {
                                var currPage = $('#page').val();
                                if (data == '1') {
                                    showMessage("Xóa thành công", "SUCCESS");
                                    var totalRows = $('#totalRows').val() - 1;
                                    var pageSize = $('#pageSize').val();
                                    if (totalRows % pageSize == 0) {
                                        currPage = totalRows / pageSize;
                                    }
                                    onSearch(currPage);
                                } else {
                                    showMessage("Xóa thất bại", "ERROR");
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
    
    function prepareDetail(status, id, customerId, bankId, total, note) {
        if (status == 0) {
            $('#lblTitle').text('Thu chuyển khoản');
        } else {
            $('#lblTitle').text('Chi chuyển khoản');
        }
        
        $("#add-id").val(id);
        $("#add-customerId").val(customerId).trigger('change');
        $("#add-bankId").val(bankId).trigger('change');
        $("#add-total").val(numberWithCommas(total));
        $('#add-type').val(status);
        $('#add-note').val(note);
        
        $('#ojectAdd').modal('show');
    }
    
    
</script>
