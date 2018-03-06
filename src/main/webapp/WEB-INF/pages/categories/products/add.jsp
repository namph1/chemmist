<%-- 
    Document   : add
    Created on : Sep 18, 2017, 10:37:36 AM
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
                <h4 class="modal-title" id="modalLabel"><label id="lblTitle">${lblTitle}</label></h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="add-id"/>
                 <div class="form-group row" >
                    <label for="type" class="col-md-3 control-label required">Loại sản phẩm</label>
                    <div class="col-md-9">
                        <select id="add-type" 
                                class="form-control" style="width: 100%;">
                            <option value="-1">--Lựa chọn--</option>
                            <c:forEach var="itemStatus" items="${lstType}">
                                <option value="${itemStatus.id}">${itemStatus.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <div class="form-group row" >
                    <label for="code" class="col-md-3 control-label required" >Mã sản phẩm</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" id="add-code"
                               name="code" maxlength="20" required="required">
                    </div>
                </div>
                <div class="form-group row" >
                    <label for="name" class="col-md-3 control-label required" >Tên sản phẩm</label>
                    <div class="col-md-9">
                        <input type="text" class="form-control" id="add-name"
                               name="name" maxlength="300" required="required">
                    </div>
                </div>
                <div class="form-group row" >
                    <label for="unit" class="col-md-3 control-label required">Đơn vị</label>
                    <div class="col-md-9">
                        <select id="add-unit" 
                                class="form-control" style="width: 100%;">
                             <option value="-1">--Lựa chọn--</option>
                            <c:forEach var="itemStatus" items="${lstUnit}">
                                <option value="${itemStatus.id}">${itemStatus.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="form-group row" >
                    <label for="price" class="col-md-3 control-label required">Giá bán(VNĐ)</label>
                    <div class="col-md-9">
                        <input name="price" onkeyup="formatCurrent();"
                               class="form-control" id="add-price" />
                    </div>
                </div>
                <div class="form-group row" >
                    <label for="price" class="col-md-3 control-label required">Giá gốc(AUD)</label>
                    <div class="col-md-9">
                        <input name="price" 
                               class="form-control" id="add-price-au" />
                    </div>
                </div>
                <div class="form-group row" >
                    <label for="weight" class="col-md-3 control-label required">Khối lượng(kg)</label>
                    <div class="col-md-9">
                        <input name="weight" 
                               class="form-control" id="add-weight" />
                    </div>
                </div>
                <div class="form-group row" >
                    <label for="note" class="col-md-3 control-label">Ghi chú</label>
                    <div class="col-md-9">
                        <textarea class="form-control" id="add-note"
                                  name="note" rows="3"></textarea>
                    </div>
                </div>
<!--                <div class="form-group row" >
                    <label for="note" class="col-md-3 control-label">Hình ảnh</label>
                    <div class="col-md-9">
                        <input type="file" id="add-image" name="fileUpload" class="form-control"/>
                    </div>
                </div>-->
            </div>
            <div class="modal-footer">
                <div class="pull-left">
                    <label class="col-md-3 control-label required" ></label> Bắt buộc
                </div>	
                <div class="pull-right">
                    <button type="submit" id="btn-add" class="btn btn-primary" onclick="onCreate();"><i class="fa fa-check-square-o">Lưu</i></button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times">Đóng</i></button>
                </div>	
            </div>
        </div>
        <div class="tab-pane" id="access-security">content 0</div>
    </div>
</div>