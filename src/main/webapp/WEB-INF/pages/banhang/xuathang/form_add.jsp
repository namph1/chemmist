<%-- 
    Document   : form_add
    Created on : Oct 8, 2017, 3:09:47 PM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="box box-info">
    <div class="box-body">
        <div class="row">
            <div class="col-md-2">
                <div class="form-group" >
                    <label>Ngày xuất</label>
                    <div class="input-group date" id="datepicker3">
                        <input type="text" class="form-control pull-right" id="createDate" >
                        <div class="input-group-addon">
                            <i class="fa fa-th"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group" >
                    <label  class="control-label">Khách hàng</label>
                    <select id="customerId" class="form-control selectpicker" style="width: 100%;"
                            onchange="fillAddress(this.value);"
                            data-show-subtext="true" data-live-search="true"
                            data-live-search-placeholder="Tìm kiếm">
                        <option value="-1">--- Chọn khách hàng ---</option>
                        <c:forEach var="itemStatus" items="${lstCustomer}">
                            <option value="${itemStatus.id}*${itemStatus.address}">${itemStatus.name}(${itemStatus.code}${itemStatus.level})</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group" >
                    <label>Địa chỉ</label>
                    <input type="text" class="form-control" id="address" disabled>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group" >
                    <label>Sản phẩm</label>
                    <div class="autocomplete-wrap">
                        <input type="text" class="form-control" id="p_code" placeholder="Mã sản phẩm">
                        <!--<button type="button" onclick="onPut()" class="btn btn-info btn-flat">Thêm</button>-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="box box-danger table-responsive">
    <div id="divTbl2">
        <%@include file="table_detail.jsp" %>
    </div>
</div>