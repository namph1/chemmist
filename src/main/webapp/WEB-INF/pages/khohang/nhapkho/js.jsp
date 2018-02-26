<%-- 
    Document   : js
    Created on : Sep 29, 2017, 1:36:41 PM
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
        $('#datepicker3').datepicker({
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
            url: "<%=request.getContextPath()%>/import/search"
        }).done(function (data) {
            $("#divTable").html(data);
        });
    }

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
            list: {
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

    function prepareAdd() {
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

        onLazyLoad();
        var search = {};
        search["strCreateDate"] = "01" + today;
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/import/prepareAdd"
        }).done(function (data) {
            $("#divTbl2").html(data);
            $('#createDate').val(day + today);
            $('#objectAdd').modal('show');
        });
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
                } else if (i == 6) {
                    add["weight"] = text_td.replace(/\./g, '').replace(/\,/g, '').trim();
                } else if (i == 3) {
                    add["count"] = text_td.replace(/\./g, '').replace(/\,/g, '').trim();
                } else if (i == 4) {
                    add["price"] = text_td.replace(/\,/g, '.').trim();
                }
                i++;
                return text_td;
            }).get();
            arr.push(add);
            return arrayOfThisRow;
        }).get();

        if (code.trim() == '') {
            showMessage("Hãy nhập mã sản phẩm!", "ERROR");
            $('#divSp').addClass("has-error");
        } else {
            $.ajax({
                type: "POST",
                crossDomain: true,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(arr),
                url: "<%=request.getContextPath()%>/import/put/" + code
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
                    } else if (i == 6) {
                        add["weight"] = text_td.replace(/\./g, '').replace(/\,/g, '').trim();
                    } else if (i == 3) {
                        add["count"] = text_td.replace(/\./g, '').replace(/\,/g, '').trim();
                    } else if (i == 4) {
                        add["price"] = text_td.replace(/\,/g, '.').trim();
                    }
                    i++;
                    return text_td;
                }).get();
                arr.push(add);
                return arrayOfThisRow;
            }
        }).get();
        $.ajax({
            type: "POST",
            crossDomain: true,
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(arr),
            url: "<%=request.getContextPath()%>/import/del/" + id
        }).done(function (data) {
            $("#divTbl2").html(data);
            var mess = $('#msg').val();
            if (mess != '') {
                showMessage(mess, "ERROR");
            }
        });
    }

    function onCreate() {
        var cusId = $('#customerId').val();
        if (cusId > -1) {
            var feeship = $('#fee_ship').val();
            var rate = $('#rate').val();
            var arr = [];
            $("table#tblProduct tbody tr").map(function () {
                var add = {};
                var i = 0;
                add["id"] = $(this).attr('title');
                var arrayOfThisRow = $(this).find('td').map(function () {
                    var text_td = $(this).has('select').length ? $(this).find('select option:selected').text() : $(this).text();
                    if (i == 1) {
                        add["code"] = text_td;
                    } else if (i == 6) {
                        add["weight"] = text_td.trim();
                    } else if (i == 3) {
                        add["count"] = text_td.replace(/\./g, '').replace(/\,/g, '').trim();
                    } else if (i == 4) {
                        add["price"] = text_td.replace(/\,/g, '.').trim();
                    } else if (i == 2) {
                        add["userId"] = cusId;
                    } else if (i == 5) {
                        add["total"] = feeship;
                        add["priceAu"] = rate;
                    }
                    i++;
                    return text_td;
                }).get();
                arr.push(add);
                return arrayOfThisRow;
            }).get();
            var curr = $('#createDate').val().replace(/\//g, "-");

            $.ajax({
                type: "POST",
                crossDomain: true,
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(arr),
                url: "<%=request.getContextPath()%>/import/add/" + curr + '-' + cusId
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
        } else {
            showMessage('Hãy chọn nhà cung cấp.', "ERROR");
        }
    }

    function onDetail(id, fee, rate) {
        var search = {};
        search["id"] = id;
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/import/prepareAdd"
        }).done(function (data) {
            $("#divTbl2").html(data);
            var mess = $('#msg').val();
            $('#fee_ship').val(fee);
            $('#rate').val(rate);
            $('#createDate').val(mess);
            $('#objectAdd').modal('show');
            $('#code').val('');
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
//                        search["status"] = status;
                        $.ajax({
                            type: "POST",
                            contentType: "application/json",
                            url: "<%=request.getContextPath()%>/import/delete",
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


    function changeCount(id, price, weight) {
        var count = $('#count_' + id).html();
        price = $('#price_' + id).html().trim().replace(/\,/g, '.');
        if (isNaN(count)) {
            $('#count_' + id).html('0');
            count = 0;
        }
        $('#total_' + id).html((count * price).format(2).toString().replace(/\./g, ','));
        $('#weight_' + id).html((count * weight).format(2).toString().replace(/\./g, ','));

        var totalCount = 0;
        var totalWeight = 0;
        var totalPrice = 0;
        $("table#tblProduct tbody tr").map(function () {
            var i = 0;
            var arrayOfThisRow = $(this).find('td').map(function () {
                var text_td = $(this).has('select').length ? $(this).find('select option:selected').text() : $(this).text();
                if (i == 3) {
                    totalCount += parseInt(text_td.trim());
                } else if (i == 7) {
                    totalWeight += parseFloat(text_td.replace(/\,/g, '.').trim());
                } else if (i == 8) {
                    totalPrice += parseFloat(text_td.replace(/\,/g, '.').trim());
                }
                i++;
                return text_td;
            }).get();
            return arrayOfThisRow;
        }).get();
        $('#total_count').html(parseInt(totalCount));
        $('#total_weight').html((totalWeight).format(2));
        $('#total_price').html((totalPrice).format(2));
    }

</script>