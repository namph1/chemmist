<%-- 
    Document   : js
    Created on : Jan 13, 2018, 2:47:07 PM
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
        search["from"] = $('#fromDate').val().trim();
        search["to"] = $('#toDate').val().trim();
        search["provinceId"] = $('#provinceId').val().trim();
//        search["areaId"] = $('#areaId').val().trim();

        $.ajax({
            type: "POST",
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify(search),
            url: "<%=request.getContextPath()%>/report/search_area"
        }).done(function (data) {
            $("#divTable").html(data);
            $('[data-toggle="tooltip"]').tooltip();
        });
    }
    
    function loadArea(idProvince) {
        if (idProvince == -1) {
             showMessage("Hãy chọn tỉnh- thành phố", "ERROR");
             return false;
        } else {
            var add = {};
            add["provinceId"] = idProvince;
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "<%=request.getContextPath()%>/customer/loadArea",
                data: JSON.stringify(add),
                dataType: 'json',
                timeout: 100000,
                success: function (data) {
                    $('#areaId').html('');
                    $('#areaId').val(-1).trigger('change');
                    if(data.length > 0){
                        var obj = $('#areaId');
                        for(var i= 0;i< data.length;i++){
                            obj.append('<option value="'+data[i].id+'">'+data[i].name+'</option>');
                        }
                        obj.selectpicker('refresh');
                    }else{
                        $('#areaId').append('<option value="-1">Lựa chọn vùng</option>').selectpicker('refresh');
                    }
                },
                error: function (e) {
                    console.log("ERROR: ", e);
                },
                done: function (e) {
                    console.log("DONE");
                }
            });
        }
    }
    
    function showHide(ele) {
        var id = ele.id.replace("detail_", "");
        if ($('#i' + id).hasClass('fa fa-chevron-down')) {
            $('#i' + id).removeClass('fa fa-chevron-down');
            $('#i' + id).addClass('fa fa-chevron-up');
             var search = {};
             search["from"] = $('#fromDate').val().trim();
             search["to"] = $('#toDate').val().trim();
             search["provinceId"] = id;
            $.ajax({
                type: "POST",
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify(search),
                url: "<%=request.getContextPath()%>/report/detais"
            }).done(function (data) {
                $("#col" + id).html(data);

            });
        } else {
            $('#i' + id).removeClass('fa fa-chevron-up');
            $('#i' + id).addClass('fa fa-chevron-down');
        }

    }
</script>