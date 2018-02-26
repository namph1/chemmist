<%-- 
    Document   : search-form
    Created on : Sep 25, 2017, 1:47:48 PM
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
                                <label for="code" class="control-label">Mã nhân viên</label>
                                <input type="text" class="form-control" name="code" id="code" 
                                       placeholder="Mã nhân viên: 12512211"/>
                            </div>
                        </div>
                        <div class="col col-md-3">
                            <div class="form-group">
                                <label for="name" class="control-label">Tên nhân viên</label>
                                <input type="text" class="form-control" id="name" name="name" 
                                       placeholder="Tên nhân viên: admin"/>
                            </div>
                        </div>
                        <div class="col col-md-3">
                            <div class="form-group">
                                <label for="leaderId" class="control-label">Nhóm trưởng</label>
                                <select id="leaderId" style="width: 100%;"
                                        class="form-control">
                                    <option value="-1">--- Chọn trưởng nhóm ---</option>
                                    <c:forEach var="itemStatus" items="${lstLeader}">
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
        <%@include file="search-result.jsp" %>
    </div>
</section>
