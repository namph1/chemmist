<%-- 
    Document   : search-form
    Created on : Sep 17, 2017, 1:54:27 PM
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
                                <label for="code" class="control-label">Mã sản phẩm</label>
                                <input type="text" class="form-control" name="code" id="code" 
                                       placeholder="Mã sản phẩm: 12512211"/>
                            </div>
                        </div>
                        <div class="col col-md-3">
                            <div class="form-group">
                                <label for="name" class="control-label">Tên sản phẩm</label>
                                <input type="text" class="form-control" id="name" name="name" 
                                       placeholder="Tên sản phẩm: giấy cuộn"/>
                            </div>
                        </div>
                        <div class="col col-md-3">
                            <div class="form-group">
                                <label for="name" class="control-label">Loại sản phẩm</label>
                                <select id="bankId" data-show-subtext="true" data-live-search="true"
                                        data-live-search-placeholder="Tìm kiếm"
                                        class="form-control selectpicker" style="width: 100%;">
                                    <option value="-1">--- Tất cả ---</option>
                                    <c:forEach var="itemStatus" items="${lstType}">
                                        <option value="${itemStatus.id}">${itemStatus.name}</option>
                                    </c:forEach>
                                </select>
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
    </div>
</section>
