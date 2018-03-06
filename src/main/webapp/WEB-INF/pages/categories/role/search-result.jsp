<%-- 
    Document   : search-result
    Created on : Jan 30, 2018, 9:28:40 AM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="row">
    <div class="col-md-12 col-sm-12">
        <div class="panel panel-default">
            <div class="panel-heading clearfix">
                <h3 class="panel-title pull-left" id="modalLabel">
                    <i class="fa fa-list"></i> Danh sách nhóm quyền
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
                                <th style="border: 1px solid silver;vertical-align:middle">Tên nhóm quyền</th>
                                <th style="border: 1px solid silver;vertical-align:middle">Ghi chú</th>
                                <th style="border: 1px solid silver;vertical-align:middle" class="text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${not empty lstResult}">
                                <c:forEach var="entity" items="${lstResult}"
                                           varStatus="loopCounter">
                                    <tr class="info">
                                        <td style="border: 1px solid silver;" class="text-center">
                                            ${(pageInfo.destPage -1)*pageInfo.direction+loopCounter.index+1}
                                        </td>
                                        <td style="border: 1px solid silver;vertical-align:middle">${entity.name}</td>
                                        <td style="border: 1px solid silver;vertical-align:middle">${entity.note}</td>
                                        <td style="border: 1px solid silver;vertical-align:middle" class="text-center">
                                            <a class="btn" onclick="prepareEdit(${entity.roleId}, '${entity.name}', '${entity.note}');"
                                               data-toggle="collapse">
                                                <i class="fa fa-pencil text-yellow"></i>
                                            </a>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <a class="btn" onclick="prepareAssign(${entity.roleId}, '${entity.name}');"
                                               data-toggle="collapse">
                                                <i class="fa fa-share text-blue"></i>
                                            </a>
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