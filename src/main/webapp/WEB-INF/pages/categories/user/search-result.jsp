<%-- 
    Document   : search-result
    Created on : Jan 30, 2018, 9:28:40 AM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="row">
    <div class="col-md-12 col-sm-12">
        <div class="panel panel-default">
            <div class="panel-heading clearfix">
                <h3 class="panel-title pull-left" id="modalLabel">
                    <i class="fa fa-list"></i> Danh sách người dùng
                </h3>
                <div class="panel-title pull-right">
                    <a class="btn" onclick='prepareAdd();'><i class="fa fa-plus text-aqua">Thêm mới</i></a>
                </div>
            </div>

            <div class="panel-body">
                <div class="table-responsive">
                    <table id="tblPack" class="table table-responsive table-reflow table-hover" >
                        <thead>
                            <tr class="active">
                                <th style="border: 1px solid silver;vertical-align:middle" class="text-center">STT</th>
                                <th style="border: 1px solid silver;vertical-align:middle">Tên đăng nhập</th>
                                <th style="border: 1px solid silver;vertical-align:middle">Họ tên</th>
                                <th style="border: 1px solid silver;vertical-align:middle">Email</th>
                                <th style="border: 1px solid silver;vertical-align:middle">Số điện thoại</th>
                                <th style="border: 1px solid silver;vertical-align:middle">Trạng thái</th>
                                <th style="border: 1px solid silver;vertical-align:middle" class="text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${not empty lstResult}">
                                <c:forEach var="entity" items="${lstResult}"
                                           varStatus="loopCounter">
                                    <c:if test="${loopCounter.index % 2 == 0}">
                                        <tr class="info">
                                            <td style="border: 1px solid silver;" class="text-center">
                                                ${(pageInfo.destPage -1)*pageInfo.direction+loopCounter.index+1}
                                            </td>
                                            <td style="border: 1px solid silver;vertical-align:middle">
                                                <c:if test="${entity.isAdmin == 1}">
                                                    <i class="fa fa-copyright" aria-hidden="true"></i>
                                                </c:if>
                                                ${entity.name}</td>
                                            <td style="border: 1px solid silver;vertical-align:middle">${entity.fullName}</td>
                                            <td style="border: 1px solid silver;vertical-align:middle">${entity.email}</td>
                                            <td style="border: 1px solid silver;vertical-align:middle">${entity.phone}</td>
                                            <td style="border: 1px solid silver;vertical-align:middle">${entity.sStatus}</td>
                                            <td style="border: 1px solid silver;vertical-align:middle" class="text-center">
                                                <a class="btn" onclick="lockUnlock(${entity.userId},${entity.active}, '${entity.name}');" data-toggle="collapse">
                                                    <c:choose>
                                                        <c:when test="${entity.active == 1}">
                                                            <i class="fa fa-lock text-danger"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa fa-unlock text-danger"></i>
                                                        </c:otherwise>
                                                    </c:choose>      
                                                </a><c:if test="${entity.active == 1}">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <a class="btn" onclick="prepareEdit(${entity.userId}, '${entity.name}', '${entity.email}', '${entity.phone}', '${entity.fullName}');"
                                                       data-toggle="collapse">
                                                        <i class="fa fa-pencil text-yellow"></i>
                                                    </a>
                                                </c:if>  
                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                <a class="btn" onclick="prepareAssign(${entity.userId}, '${entity.name}');"
                                                   data-toggle="collapse">
                                                    <i class="fa fa-share text-blue"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${loopCounter.index % 2 != 0}">
                                        <tr>
                                            <td style="border: 1px solid silver;" class="text-center">
                                                ${(pageInfo.destPage -1)*pageInfo.direction+loopCounter.index+1}
                                            </td>
                                            <td style="border: 1px solid silver;vertical-align:middle">
                                                <c:if test="${entity.isAdmin == 1}">
                                                    <i class="fa fa-copyright" aria-hidden="true"></i>
                                                </c:if>${entity.name}</td>
                                            <td style="border: 1px solid silver;vertical-align:middle">${entity.fullName}</td>
                                            <td style="border: 1px solid silver;vertical-align:middle">${entity.email}</td>
                                            <td style="border: 1px solid silver;vertical-align:middle">${entity.phone}</td>
                                            <td style="border: 1px solid silver;vertical-align:middle">${entity.sStatus}</td>
                                            <td style="border: 1px solid silver;vertical-align:middle" class="text-center">
                                                <a class="btn" onclick="lockUnlock(${entity.userId},${entity.active}, '${entity.name}');" data-toggle="collapse">
                                                    <c:choose>
                                                        <c:when test="${entity.active == 1}">
                                                            <i class="fa fa-lock text-danger"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa fa-unlock text-danger"></i>
                                                        </c:otherwise>
                                                    </c:choose>      
                                                </a>
                                                <c:if test="${entity.active == 1}">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <a class="btn" onclick="prepareEdit(${entity.userId}, '${entity.name}', '${entity.email}', '${entity.phone}', '${entity.fullName}');"
                                                       data-toggle="collapse">
                                                        <i class="fa fa-pencil text-yellow"></i>
                                                    </a>
                                                </c:if>  
                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <a class="btn" onclick="prepareAssign(${entity.userId}, '${entity.name}');"
                                                       data-toggle="collapse">
                                                        <i class="fa fa-share text-blue"></i>
                                                    </a>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="panel-footer" id="divFooter">
                <%@include file="../../template/page_info_ajax.jsp"%>
            </div>
        </div>
    </div>
</div>