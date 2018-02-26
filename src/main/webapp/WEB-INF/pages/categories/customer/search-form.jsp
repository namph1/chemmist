<%-- 
    Document   : search-form
    Created on : Sep 20, 2017, 2:37:01 PM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title" id="modalLabel">
                        <i class="fa fa-list"></i> Tìm kiếm
                    </h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col col-md-3">
                            <div class="form-group">
                                <label for="code" class="control-label">Mã đại lý</label>
                                <input type="text" class="form-control" name="code" id="code" 
                                       placeholder="Mã đại lý: ANH"/>
                            </div>
                        </div>
                        <div class="col col-md-3">
                            <div class="form-group">
                                <label for="name" class="control-label">Họ và tên</label>
                                <input type="text" class="form-control" id="name" name="name" 
                                       placeholder="Họ và tên đại lý"/>
                            </div>
                        </div>
                        <div class="col col-md-3">
                            <div class="form-group">
                                <label for="phone" class="control-label">Số điện thoại</label>
                                <input type="text" class="form-control" id="phone" name="phone" 
                                       placeholder="Số điện thoại: 0123456789"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col col-md-3">
                            <button class="btn btn-primary btn-flat" id="btnSearch" onclick="onSearch(1);">
                                <i class="fa fa-search">Tìm kiếm</i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divTable">
        <%--<%@include file="search-result.jsp" %>--%>
    </div>
</section>
