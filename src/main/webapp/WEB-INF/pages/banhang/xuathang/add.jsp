<%-- 
    Document   : add
    Created on : Oct 8, 2017, 3:00:43 PM
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
                <h4 class="modal-title" id="modalLabel"><label id="lblTitle" >Xuất kho thành phẩm</label></h4>
            </div>
            <input type="hidden" id="add-id">
            <div class="modal-body">
                <div id="divformAdd">
                    <%@include file="form_add.jsp" %>
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