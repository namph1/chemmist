<%-- 
    Document   : search-result
    Created on : Sep 25, 2017, 1:48:43 PM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<div class="row">
    <div class="col-md-12 col-sm-12">
        <div class="panel panel-default">
            <div class="panel-heading clearfix">
                <h3 class="panel-title pull-left" id="modalLabel">
                    <i class="fa fa-list"></i> Danh sách nhân viên
                </h3>
                <div class="panel-title pull-right">
                    <a class="btn btn-flat" onclick='prepareAdd();'><i class="fa fa-plus text-aqua">Thêm mới</i></a>
                </div>
            </div>

            <div class="panel-body">
                <div class="table-responsive">
                    <table id="tblPack" class="table table-responsive table-reflow table-hover" >
                        <thead>
                            <tr>
                                <th style="border: 1px solid silver;" class="text-center">STT</th>
                                <th style="border: 1px solid silver;">Mã nhân viên</th>
                                <th style="border: 1px solid silver;">Họ tên</th>
                                <th style="border: 1px solid silver;">Địa chỉ</th>
                                <th style="border: 1px solid silver;">Số điện thoại</th>
                                <th style="border: 1px solid silver;">Trạng thái</th>
                                <th style="border: 1px solid silver;" class="text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${not empty lstResult}">
                                <c:forEach var="entity" items="${lstResult}"
                                           varStatus="loopCounter">
                                    <c:if test="${loopCounter.index % 2 == 0}">
                                        <tr class="active">
                                            <td style="border: 1px solid silver;" class="text-center">
                                                ${(pageInfo.destPage -1)*pageInfo.direction+loopCounter.index+1}
                                            </td>
                                            <td style="border: 1px solid silver;">
                                                ${entity.code}${entity.orders}
                                                <c:if test="${entity.levels == 1}">
                                                    <i class="text-danger fa fa-flag" aria-hidden="true" data-toggle="tooltip" title="Trưởng nhóm"></i>
                                                </c:if>
                                            </td>
                                            <td style="border: 1px solid silver;">${entity.name}</td>
                                            <td style="border: 1px solid silver;">${entity.address}</td>
                                            <td style="border: 1px solid silver;">${entity.phone}</td>
                                            <td style="border: 1px solid silver;">${entity.sStatus}</td>
                                            <td style="border: 1px solid silver;" >
                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                <a onclick="lockUnlock(${entity.id},${entity.status}, '${entity.name}');" data-toggle="tooltip" title="Khóa/ Mở khóa">
                                                    <c:choose>
                                                        <c:when test="${entity.status == 1}">
                                                            <i class="fa fa-lock text-danger"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa fa-unlock text-danger"></i>
                                                        </c:otherwise>
                                                    </c:choose>      
                                                </a>
                                                <c:if test="${entity.status == 1}">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <a onclick="prepareEdit(${entity.id}, '${entity.name}', '${entity.address}', '${entity.phone}',${entity.levels},${entity.parentId});" data-toggle="tooltip" title="Cập nhật">
                                                        <i class="fa fa-pencil text-yellow"></i>
                                                    </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <c:if test="${entity.levels == 0}">
                                                        <a onclick="prepareAssign(${entity.id}, '${entity.name}');" data-toggle="tooltip" title="Gán đại lý">
                                                            <i class="fa  fa-users text-navy"></i>
                                                        </a>
                                                    </c:if>   
                                                </c:if>   
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${loopCounter.index % 2 != 0}">
                                        <tr>
                                            <td style="border: 1px solid silver;" class="text-center">
                                                ${(pageInfo.destPage -1)*pageInfo.direction+loopCounter.index+1}
                                            </td>
                                            <td style="border: 1px solid silver;">
                                                ${entity.code}${entity.orders}
                                                <c:if test="${entity.levels == 1}">
                                                    <i class="text-danger fa fa-flag" aria-hidden="true" data-toggle="tooltip" title="Trưởng nhóm"></i>
                                                </c:if>
                                            </td>
                                            <td style="border: 1px solid silver;">${entity.name}</td>
                                            <td style="border: 1px solid silver;">${entity.address}</td>
                                            <td style="border: 1px solid silver;">${entity.phone}</td>
                                            <td style="border: 1px solid silver;">${entity.sStatus}</td>
                                            <td style="border: 1px solid silver;" >
                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                <a onclick="lockUnlock(${entity.id},${entity.status}, '${entity.name}');" data-toggle="tooltip" title="Khóa/ Mở khóa">
                                                    <c:choose>
                                                        <c:when test="${entity.status == 1}">
                                                            <i class="fa fa-lock text-danger"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa fa-unlock text-danger"></i>
                                                        </c:otherwise>
                                                    </c:choose>      
                                                </a>
                                                <c:if test="${entity.status == 1}">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <a onclick="prepareEdit(${entity.id}, '${entity.name}', '${entity.address}', '${entity.phone}',${entity.levels},${entity.parentId});" data-toggle="tooltip" title="Cập nhật">
                                                        <i class="fa fa-pencil text-yellow"></i>
                                                    </a>&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <c:if test="${entity.levels == 0}">
                                                        <a onclick="prepareAssign(${entity.id}, '${entity.name}');" data-toggle="tooltip" title="Gán đại lý">
                                                            <i class="fa  fa-users text-navy"></i>
                                                        </a>
                                                    </c:if>
                                                </c:if>    
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
