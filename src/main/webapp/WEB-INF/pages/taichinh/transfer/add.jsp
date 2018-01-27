<%-- 
    Document   : add
    Created on : Oct 14, 2017, 10:21:02 AM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal fade" id="ojectAdd" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="modalLabel"><label id="lblTitle" ></label></h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="add-id"/>
                <input type="hidden" id="add-type"/>
                <div class="form-group row" >
                    <label for="name" class="col-md-3 control-label required" >Khách hàng</label>
                    <div class="col-md-9">
                        <select id="add-customerId" data-show-subtext="true" data-live-search="true"
                                 data-live-search-placeholder="Tìm kiếm"
                                 class="form-control selectpicker" style="width: 100%;">
                           <c:forEach var="itemCus" items="${lstCust}">
                                <option value="C${itemCus.id}">${itemCus.code}${itemCus.level}-${itemCus.name}</option>
                            </c:forEach>
                            <c:forEach var="itemEmp" items="${lstEmp}">
                                <option value="E${itemEmp.id}">${itemEmp.code}${itemEmp.orders}-${itemEmp.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group row" >
                    <label for="name" class="col-md-3 control-label required" >Ngân hàng</label>
                    <div class="col-md-9">
                        <select id="add-bankId" data-show-subtext="true" data-live-search="true"
                                 data-live-search-placeholder="Tìm kiếm"
                                 class="form-control selectpicker" style="width: 100%;">
                            <c:forEach var="itemStatus" items="${lstBank}">
                                <option value="${itemStatus.id}">${itemStatus.name}-${itemStatus.no}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group row" >
                    <label for="no" class="col-md-3 control-label required">Số tiền</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" id="add-total" onkeyup="formatCurrent();"
                               name="no" maxlength="300">
                    </div>
                </div>
                <div class="form-group row" >
                    <label for="address" class="col-md-3 control-label">Ghi chú</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" id="add-note"
                               name="address" maxlength="300">
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <div class="pull-left">
                    <label class="col-md-3 control-label required" ></label> Bắt buộc
                </div>	
                <div class="pull-right">
                    <button type="submit" id="btn-add" class="btn btn-primary" onclick="onCreate();">
                        <i class="fa fa-check-square-o">Lưu</i>
                    </button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">
                        <i class="fa fa-times">Đóng</i>
                    </button>
                </div>	

            </div>
        </div>
        <div class="tab-pane" id="access-security">content 0</div>
    </div>
</div>
