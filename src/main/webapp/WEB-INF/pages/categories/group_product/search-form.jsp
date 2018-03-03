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
                                <label for="name" class="control-label">Tên nhóm sản phẩm</label>
                                <input type="text" class="form-control" id="name" name="name" 
                                       placeholder="Tên sản phẩm: giấy cuộn"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col col-md-3">
                            <c:if test="${not empty lstAct}">
                                <c:forEach items="${lstAct}" var="act">
                                    <c:if test="${act.id == 5}">
                                        <button class="btn btn-primary btn-flat" id="btnSearch" onclick="onSearch(1);">
                                            <i class="fa fa-search">Tìm kiếm</i>
                                        </button>
                                    </c:if>
                                </c:forEach>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divTable">
    </div>
</section>
