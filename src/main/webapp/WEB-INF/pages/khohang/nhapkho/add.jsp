<%-- 
    Document   : add
    Created on : Oct 2, 2017, 11:20:45 AM
    Author     : namph
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal fade" id="objectAdd" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-cus modal-lg" role="document">
        <div class="modal-content modal-content-cus">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="modalLabel"><label id="lblTitle" >Nhập kho thành phẩm-${maxNo}</label></h4>
            </div>
            <div class="modal-body">
                <div class="box box-info">
                    <div class="box-body">
                        <div class="col-md-2">
                            <div class="form-group" >
                                <label>Ngày nhập</label>
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
                                <label  class="control-label">Nhà cung cấp</label>
                                <select id="customerId" class="form-control selectpicker" style="width: 100%;"
                                        data-show-subtext="true" data-live-search="true"
                                        data-live-search-placeholder="Tìm kiếm">
                                    <option value="-1">--- Chọn nhà cung cấp ---</option>
                                    <c:forEach var="itemStatus" items="${lstCustomer}">
                                        <option value="${itemStatus.id}">${itemStatus.name}(${itemStatus.code}${itemStatus.level})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group" >
                                <label>Sản phẩm</label>
                                <div class="autocomplete-wrap">
                                    <input type="text" class="form-control" id="p_code" placeholder="Mã sản phẩm">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group" >
                                <label>Phí vận chuyển(AUD)</label>
                                <input type="text" class="form-control" id="fee_ship" placeholder="Phí vận chuyển (đô la Úc)">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group" >
                                <label>Tỷ giá</label>
                                <input type="text" class="form-control" id="rate" placeholder="Tỷ giá đô la Úc">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box box-danger table-responsive">
                    <div id="divTbl2">
                        <%@include file="table_detail.jsp" %>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="pull-right">
                    <button type="submit" id="btn-add" class="btn btn-primary" onclick="onCreate();">
                        <i class="fa fa-check-square-o">Lưu</i>
                    </button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times">Đóng</i></button>
                </div>	
            </div>
        </div>
        <div class="tab-pane" id="access-security1">content 0</div>
    </div>
</div>
