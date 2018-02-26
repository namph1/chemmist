<%-- 
    Document   : add
    Created on : Jan 30, 2018, 9:28:53 AM
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
                <div class="form-group row" >
                    <label for="name" class="col-md-4 control-label required" >Tên đăng nhập</label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="add-username" 
                               name="name" maxlength="20" required="required">
                    </div>
                </div>
                <div class="form-group row"  id="div-pass">
                    <label for="name" class="col-md-4 control-label required" >Mật khẩu</label>
                    <div class="col-md-8">
                        <input type="password" class="form-control" id="add-pass" 
                               name="name" maxlength="50" required="required">
                    </div>
                </div>
                <div class="form-group row" >
                    <label for="name" class="col-md-4 control-label required" >Họ tên</label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="add-name" 
                               name="name" maxlength="300" required="required">
                    </div>
                </div>
                <div class="form-group row" >
                    <label for="name" class="col-md-4 control-label required" >Email</label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="add-email" 
                               name="name" maxlength="300" required="required">
                    </div>
                </div>

                <div class="form-group row" >
                    <label for="phone" class="col-md-4 control-label">Số điện thoại</label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="add-phone"
                               name="phone" maxlength="300">
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <div class="pull-left">
                    <label class="col-md-4 control-label required" ></label> Bắt buộc
                </div>	
                <div class="pull-right">
                    <button type="submit" id="btn-add" class="btn btn-primary" onclick="onCreate();">
                        <i class="fa fa-check-square-o">Lưu</i>
                    </button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times">Đóng</i></button>
                </div>	

            </div>
        </div>
        <div class="tab-pane" id="access-security">content 0</div>
    </div>
</div>
