<%-- 
    Document   : search-result
    Created on : Jun 11, 2018, 8:15:49 AM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<div class="row">
    <div class="col-md-12 col-sm-12">
        <div class="panel panel-default">
            <div class="panel-heading clearfix">
                <h3 class="panel-title pull-left" id="modalLabel">
                    <i class="fa fa-list"></i> Danh sách đại lý
                </h3>
                <div class="panel-title pull-right">
                    <a onclick='importExcel();'><i class="fa fa-file-excel-o text-green"></i></a>
                    <a onclick='prepareAdd();'><i class="fa fa-plus text-aqua">Thêm mới</i></a>
            </div>
            </div>

            <div class="panel-body">
                <div class="table-responsive">
                    <table id="tblPack" class="table table-responsive table-reflow table-hover" >
                        <thead>
                            <tr class="active">
                                <th style="border: 1px solid silver;vertical-align:middle" class="text-center">STT</th>
                                <th style="border: 1px solid silver;vertical-align:middle">Mã đại lý</th>
                                <th style="border: 1px solid silver;vertical-align:middle">Họ tên</th>
                                <th style="border: 1px solid silver;vertical-align:middle">Số tiền</th>
                                <th style="border: 1px solid silver;vertical-align:middle">Nội dung</th>
                                <th style="border: 1px solid silver;vertical-align:middle">Trạng thái</th>
                                <th style="border: 1px solid silver;vertical-align:middle">Ngày tháng</th>
                                <th style="border: 1px solid silver;vertical-align:middle" class="text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${not empty lstResult}">
                                <c:forEach var="entity" items="${lstResult}"
                                           varStatus="loopCounter">
                                    <tr>
                                        <td style="border: 1px solid silver;" class="text-center">
                                            ${(pageInfo.destPage -1)*pageInfo.direction+loopCounter.index+1}
                                        </td>
                                        <td style="border: 1px solid silver;vertical-align:middle">${entity.code}</td>
                                        <td style="border: 1px solid silver;vertical-align:middle">${entity.name}</td>
                                        <td style="border: 1px solid silver;vertical-align:middle">
                                            <fmt:formatNumber type = "number" 
                                                              pattern="###,###" value = "${entity.money}" /></td>
                                        <td style="border: 1px solid silver;vertical-align:middle">${entity.content}</td>
                                        <td style="border: 1px solid silver;vertical-align:middle">${entity.sStatus}</td>
                                        <td style="border: 1px solid silver;vertical-align:middle">
                                            <fmt:formatDate pattern = "dd-MM-yyyy" 
                                                            value = "${entity.insertDate}" />
                                        </td>
                                        <td style="border: 1px solid silver;vertical-align:middle" class="text-center">
                                            <a onclick="lockUnlock(${entity.id},${entity.status}, '${entity.name}');" data-toggle="collapse">
                                                <c:choose>
                                                    <c:when test="${entity.status == 1}">
                                                        <i class="fa fa-lock text-danger"></i>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="fa fa-unlock text-danger"></i>
                                                    </c:otherwise>
                                                </c:choose>      
                                            </a><c:if test="${entity.status == 1}">
                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                <a onclick="prepareEdit(${entity.id}, '${entity.code}','${entity.name}', ${entity.money}, '${entity.content}');"
                                                   data-toggle="collapse">
                                                    <i class="fa fa-pencil text-yellow"></i>
                                                </a>
                                            </c:if>  
                                        </td>
                                    </tr>
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