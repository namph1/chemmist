<%-- 
    Document   : js
    Created on : Sep 17, 2017, 1:54:39 PM
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

    function formatCurrent() {
        var money = $('#add-price').val().replace(/\./g, '').trim();
        $('#add-price').val(numberWithCommas(money));
    }

    function formatWeight() {
        var money = $('#add-weight').val().replace(/\./g, '').trim();
        $('#add-weight').val(numberWithCommas(money));
    }

    function onSearch(currPage) {
        var search = {};
        search["code"] = $('#code').val().trim();
        search["name"] = $('#name').val().trim();
        search["pageCurrent"] = currPage;
        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/products/search"
        }).done(function (data) {
            $("#divTable").html(data);
        });

    }

    function onCreate() {
        var id = $("#add-id").val();
        var add = {};
        if (null != id && id != '') {
            add["id"] = $("#add-id").val();
        }
        add["name"] = $("#add-name").val().trim();
        add["code"] = $("#add-code").val().trim();
        add["price"] = $("#add-price").val().trim().replace(/\./g, '');
        add["priceAu"] = $("#add-price-au").val().trim();//.replace(/\./g, '');
        add["unitId"] = $("#add-unit").val();
        add["note"] = $("#add-note").val().trim();
        add["weight"] = $("#add-weight").val().trim();
        add["typeId"] = $("#add-type").val();
        var image;
        var param = new FormData();
        if ($('#add-image')[0].files.length == 0) {
        } else {
            image = $('#add-image')[0].files[0];
            param.append('image', image);
        }
        param.append('detail', JSON.stringify(add));

        if ($("#add-type").val() == null || $("#add-type").val() == -1) {
            showMessage("Hãy chọn loại sản phẩm", "ERROR");
            return;
        } else if (add["code"] == '') {
            showMessage("Hãy nhập mã sản phẩm", "ERROR");
            return;
        } else if (add["name"] == '') {
            showMessage("Hãy nhập tên sản phẩm", "ERROR");
            return;
        } else if ($("#add-unit").val() == null || $("#add-unit").val() == -1) {
            showMessage("Hãy chọn đơn vị", "ERROR");
            return;
        } else if (add["price"] == '') {
            showMessage("Hãy nhập giá thành sản phẩm", "ERROR");
            $("#add-price").focus();
            return;
        } else if (!isFloat($("#add-weight").val().trim())) {
            showMessage("Hãy nhập khối lượng sản phẩm dạng số", "ERROR");
            $("#add-weight").focus();
            return;
        } else {

            $.ajax({
                url: '<%=request.getContextPath()%>/products/addNew',
                data: param,
                dataType: 'json',
                cache: false,
                contentType: false,
                processData: false,
                enctype: 'multipart/form-data;charset=utf-8',
                type: 'POST',
                success: function (data) {
                    $('#ojectAdd').modal('hide');
                    showMessage(data, "SUCCESS");
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
    }

    function lockUnlock(id, status, name) {
        var content = "";
        if (status == 1) {
            content = 'Bạn chắc chắn muốn <b>NGƯNG HOẠT ĐỘNG</b> sản phẩm <b>' + name + ' </b>?';
        } else {
            content = 'Bạn chắc chắn muốn sản phẩm ' + name + '<b> HOẠT ĐỘNG</b>?';
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
                            url: "<%=request.getContextPath()%>/products/update_status",
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

    function prepareEdit(id) {
        var search = {};
        search["id"] = id;
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/products/prepareEdit",
            data: JSON.stringify(search),
            dataType: 'json',
            timeout: 100000,
            success: function (data) {
                $("#add-id").val(data.id);
                $("#add-name").val(data.name);
                $("#add-code").val(data.code);
                $("#add-price").val(numberWithCommas(data.price));
                $("#add-price-au").val(data.priceAu);
                $("#add-unit").val(data.unitId);
                $("#add-weight").val(data.weight);
                $("#add-note").val(data.note.replaceAll('<br/>', '\r'));
                $("#add-type").val(data.typeId);
                $('#ojectAdd').modal('show');
                $('#lblTitle').text("Cập nhật sản phẩm");
            },
            error: function (e) {
                console.log("ERROR: ", e);
            },
            done: function (e) {
                console.log("DONE");
            }
        });
    }

    function prepareAdd() {
        $("#add-id").val('');
        $("#add-name").val('');
        $("#add-code").val('');
        $("#add-price").val('');
        $("#add-price-au").val('');
        $("#add-unit").val(-1);
        $("#add-note").val('');
        $("#add-type").val(-1);
        $("#add-weight").val('');
        $('#ojectAdd').modal('show');
    }

    function showImage(srcImage, name) {
        var modal = document.getElementById('myModal');
        var modalImg = document.getElementById("img01");
        var captionText = document.getElementById("caption");
        modal.style.display = "block";
        modalImg.src = srcImage;
        captionText.innerHTML = name;

        var span = document.getElementsByClassName("cus_close")[0];

        span.onclick = function () {
            modal.style.display = "none";
        };
    }

    function showAvatar(urlQR) {
        $.confirm({
            title: 'Ảnh đại diện',
            closeIcon: true,
            content:
                    '<img src="' + urlQR + '">',
            animation: 'scale',
            animationClose: 'top',
            buttons: {
                confirm: {
                    text: 'OK',
                    btnClass: 'btn-danger',
                    action: function () {
                    }
                }
            },
        });
    }

    function showPriAu(type, id, name) {
        var search = {};
        search["typeId"] = type;
        search["id"] = id;
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "<%=request.getContextPath()%>/products/getPriceHistory",
            data: JSON.stringify(search),
            dataType: 'json',
            timeout: 100000,
            success: function (data) {
                //name- name2
                var strTbl = '<table class="table table-bordered table-condensed table-striped" >';
                strTbl += '<thead><tr><th style="border: 1px solid silver;">Ngày</th><th style="border: 1px solid silver;">Giá</th></tr></thead>';
                for (var i = 0; i < data.length; i++) {
                    strTbl += '<tr><td style="border: 1px solid silver;">' + data[i].name + '</td><td style="border: 1px solid silver;">' + numberWithCommas(data[i].name2) + '</td></tr>';
                }
                strTbl += '</table>';

                $.dialog({
                    title: 'Lịch sử giá <b>' + name + '</b>',
                    content: strTbl,
                    animation: 'scale',
                    columnClass: 'small',
                    closeAnimation: 'scale',
                    backgroundDismiss: true,
                });
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
