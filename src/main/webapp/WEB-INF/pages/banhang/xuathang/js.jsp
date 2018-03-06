<%-- 
    Document   : js
    Created on : Oct 8, 2017, 10:31:40 AM
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


    function onLazyLoad() {
        var options = {
            url: function (phrase) {
                return "<%=request.getContextPath()%>/products/getbycode?code=" + phrase;
            },
            ajaxSettings: {
                dataType: "json",
                method: "POST",
                contentType: "application/json; charset=utf-8",
                data: {
                    dataType: "json"
                }
            },
            requestDelay: 400,
            getValue: "name",
//            theme: "round",
            list: {
                onSelectItemEvent: function () {
//                    var selectedItemValue = $("#p_code").getSelectedItemData().id;
//                    alert(selectedItemValue);
                },
                onHideListEvent: function () {
                },
                onClickEvent: function () {
                    var selectedItemValue = $("#p_code").getSelectedItemData().name;
                    onPut(selectedItemValue);
                }
            },
            template: {
                type: "custom",
                method: function (value, item) {
                    return   value + '  ' + item.name2;
                }
            }
        };

        $("#p_code").easyAutocomplete(options);
        $('div.easy-autocomplete').removeAttr('style');
    }

    function onGoPage(elePage) {
        onSearch(elePage);
    }


    function onSearch(currPage) {
        var search = {};
        search["pageCurrent"] = currPage;
        search["fromDate"] = $('#fromDate').val().trim();
        search["toDate"] = $('#toDate').val().trim();
        search["customerCode"] = $('#code').val().trim();
        search["customerName"] = $('#name').val().trim();

        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/export/search"
        }).done(function (data) {
            $("#divTable").html(data);
            $('[data-toggle="tooltip"]').tooltip();
        });
    }

    function onDelete(id, no) {
        var content = "";
        content = 'Bạn chắc chắn muốn xóa phiếu nhập kho số <b>' + no + '</b>?';

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
                            url: "<%=request.getContextPath()%>/export/delete",
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

    function onDetail(id, cusId, address) {
        var search = {};
        search["id"] = id;
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/export/prepareAdd"
        }).done(function (data) {
            $("#divformAdd").html(data);
            onDisplayModal(false, cusId, address, id);
        });
    }

    function onDisplayModal(isCreate, cusId, address, id) {
        $('.selectpicker').selectpicker('show');
        if (isCreate) {
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
            $('#createDate').val(day + today);
            $("#customerId").prop('disabled', false);
            $('#add-id').val('');
        } else {
            var mess = $('#msg').val();
            $('#createDate').val(mess);
            $("#customerId").prop('disabled', true);
            $('#customerId').val(cusId + '*' + address).trigger('change');
            $('#address').val(address);
            $('#add-id').val(id);
        }
        onLazyLoad();
        $('#objectAdd').modal('show');
        $('#datepicker3').datepicker({
            autoclose: true,
            todayHighlight: true,
            format: 'dd/mm/yyyy',
            language: 'vi',
            todayBtn: true
        });
    }

    function fillAddress(idAddress) {
        if (idAddress.split("*")[0] != '-1') {
            $('#address').val(idAddress.split("*")[1]);
        } else {
            $('#address').val('');
        }
    }

    function calculatorTotal(total, discount) {
        var totals = $('#totalBefore').text().replace(/\./g, '').replace(/\,/g, '').trim();
        var total_last = totals - discount;
        $('#discount').val(numberWithCommas(discount));
        $('#total').text(numberWithCommas(total_last));
    }

    function changeCount(id, price, weight) {
        var totalRowOld = $('#total_' + id).html().trim().replace(/\./g, '').replace(/\,/g, '');
        var count = $('#count_' + id).html();
        price = $('#price_' + id).html().trim().replace(/\./g, '').replace(/\,/g, '');
        if(isNaN(count)){
           $('#count_' + id).html('0'); 
           count = 0;
        }
        $('#total_' + id).html(numberWithCommas(count * price));
        var total = $('#totalBefore').text().replace(/\./g, '').replace(/\,/g, '').trim();
        total = total - totalRowOld + count * price;
        $('#totalBefore').text(numberWithCommas(total));
        var discount = $('#discount').val().replace(/\./g, '').replace(/\,/g, '').trim();
        calculatorTotal(total, discount);
        $('#weight_' + id).html((count * weight).format(2));
    }

    function onPut(code) {
        var arr = [];
        $("table#tblProduct tbody tr").map(function () {
            var add = {};
            var i = 0;
            add["id"] = $(this).attr('title');
            var arrayOfThisRow = $(this).find('td').map(function () {
                var text_td = $(this).has('select').length ? $(this).find('select option:selected').text() : $(this).text();
                if (i == 1) {
                    add["code"] = text_td;
                } else if (i == 4) {
                    add["count"] = text_td;
                } else if (i == 5) {
                    add["price"] = text_td.replace(/\./g, '').replace(/\,/g, '').trim();
                }
                i++;
                return text_td;
            }).get();
            arr.push(add);
            return arrayOfThisRow;
        }).get();

        var customerId = $('#customerId').val();
        var totalBefore = $('#totalBefore').text().replace(/\./g, '').replace(/,/g, '').trim();
        var discount = $('#discount').val().replace(/\./g, '').replace(/,/g, '').trim();

        if (code.trim() == '') {
            showMessage("Hãy nhập mã sản phẩm!", "ERROR");
            $('#divSp').addClass("has-error");
        } else {
            $.ajax({
                type: "POST",
                crossDomain: true,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(arr),
                url: "<%=request.getContextPath()%>/export/put/" + code + "-0-" + totalBefore + "-" + discount
//                url: "<%=request.getContextPath()%>/export/put/" + code + "-" + customerId.split("*")[0] + "-" + totalBefore + "-" + discount
            }).done(function (data) {
                $("#divTbl2").html(data);
                var mess = $('#msg').val();
                if (mess != '') {
                    showMessage(mess, "ERROR");
                }
            });
        }
    }

    function onDel(id) {
        var arr = [];
        $("table#tblProduct tbody tr").map(function () {
            var add = {};
            var i = 0;
            add["id"] = $(this).attr('title');
            if (add["id"] != id) {
                var arrayOfThisRow = $(this).find('td').map(function () {
                    var text_td = $(this).has('select').length ? $(this).find('select option:selected').text() : $(this).text();
                    if (i == 1) {
                        add["code"] = text_td;
                    } else if (i == 4) {
                        add["count"] = text_td;
                    } else if (i == 5) {
                        add["price"] = text_td.replace(/\./g, '').replace(/,/g, '').trim();
                    }
                    i++;
                    return text_td;
                }).get();
                arr.push(add);
                return arrayOfThisRow;
            }
        }).get();
        var totalBefore = $('#totalBefore').text().replace(/\./g, '').trim();
        var discount = $('#discount').val().replace(/\./g, '').trim();
        var totalRowOld = $('#total_' + id).html().trim().replace(/\./g, '');
        $.ajax({
            type: "POST",
            crossDomain: true,
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(arr),
            url: "<%=request.getContextPath()%>/export/del/" + id + "_" + totalBefore + "_" + discount
        }).done(function (data) {
            $("#divTbl2").html(data);
            var mess = $('#msg').val();
            if (mess != '') {
                showMessage(mess, "ERROR");
            }
            var total = $('#totalBefore').text(numberWithCommas(totalBefore - totalRowOld));
            var discount = $('#discount').val().replace(/\./g, '').trim();
            calculatorTotal(total, discount);
        });
    }


    function prepareAdd() {
        var search = {};
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/export/prepareAdd"
        }).done(function (data) {
            $("#divformAdd").html(data);
            onDisplayModal(true, null, null);
        });
    }

    function onCreate() {
        var id = $('#add-id').val();
        var arr = [];
        $("table#tblProduct tbody tr").map(function () {
            var add = {};
            var i = 0;
            add["id"] = $(this).attr('title');
            add["exportDetailId"] = $(this).attr('id');
            var arrayOfThisRow = $(this).find('td').map(function () {
                if (i == 3) {
                    var unitId = $(this).attr('id').toString();
                    add["unitId"] = unitId.replace('unit_', '');
                }

                var text_td = $(this).has('select').length ? $(this).find('select option:selected').text() : $(this).text();
                if (i == 1) {
                    add["code"] = text_td;
                } else if (i == 4) {
                    add["count"] = text_td;
                } else if (i == 5) {
                    add["price"] = text_td.replace(/,/g, '').replace(/\./g, '').trim();
                } else if (i == 7) {
                    add["weight"] = text_td.trim();
                }
                i++;
                return text_td;
            }).get();
            arr.push(add);
            return arrayOfThisRow;
        }).get();
        var curr = $('#createDate').val().replace(/\//g, "-");
        var customerId = $('#customerId').val();
        var totalBefore = $('#totalBefore').text().replace(/\./g, '').trim();
        var totalAfter = $('#total').text().replace(/\./g, '').trim();
        var discount = $('#discount').val().replace(/\./g, '').trim();
//        var createDate = $('#createDate').val();
        if (customerId == '-1') {
            showMessage("Hãy chọn khách hàng", "ERROR");
            $('#customerId').addClass("has-error");
        } else {
            $.ajax({
                type: "POST",
                crossDomain: true,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(arr),
                url: "<%=request.getContextPath()%>/export/add/" + curr + "_" + customerId.split("*")[0] + "_" + totalAfter + "_" + discount + "_" + totalBefore + "_" + id
            }).done(function (data) {
                $("#divTable").html(data);
                var result = $('#message').val();
                if (result == 'SUCCESS') {
                    $('#objectAdd').modal('hide');
                    showMessage(result, "SUCCESS");
                } else {
                    showMessage(result, "ERROR");
                }
                onSearch(1);
            });
        }
    }


</script>