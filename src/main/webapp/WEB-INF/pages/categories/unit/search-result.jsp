<%-- 
    Document   : search-result
    Created on : Sep 20, 2017, 11:03:39 AM
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
                    <i class="fa fa-list"></i> Danh sách đơn vị
                </h3>
                <div class="panel-title pull-right">
                    <a class="btn" onclick='prepareAdd();'><i class="fa fa-plus text-aqua">Thêm mới</i></a>
                </div>
            </div>

            <div class="panel-body">
                <div class="table-responsive">
                    <table id="tblPack" class="table table-responsive table-reflow table-hover" >
                        <thead>
                            <tr>
                                <th style="border: 1px solid silver;" class="text-center">STT</th>
                                <th style="border: 1px solid silver;">Tên đơn vị</th>
                                <th style="border: 1px solid silver;">Ghi chú</th>
                                <th style="border: 1px solid silver;" class="text-center">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${not empty lstResult}">
                                <c:forEach var="entity" items="${lstResult}"
                                           varStatus="loopCounter">
                                    <c:if test="${loopCounter.index % 2 == 0}">
                                        <tr class="active">
                                            <td style="border: 1px solid silver;" class="text-center">${loopCounter.index+1}</td>
                                            <td style="border: 1px solid silver;">${entity.name}</td>
                                            <td style="border: 1px solid silver;">${entity.note}</td>
                                            <td style="border: 1px solid silver;" class="text-center col-md-2">
                                                <a onclick="prepareEdit(${entity.id},'${entity.name}','${entity.note}');" data-toggle="collapse">
                                                    <i class="fa fa-pencil text-yellow"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${loopCounter.index % 2 != 0}">
                                        <tr>
                                            <td style="border: 1px solid silver;" class="text-center">${loopCounter.index+1}</td>
                                            <td style="border: 1px solid silver;">${entity.name}</td>
                                            <td style="border: 1px solid silver;">${entity.note}</td>
                                            <td style="border: 1px solid silver;" class="text-center col-md-2">
                                                <a onclick="prepareEdit(${entity.id},'${entity.name}','${entity.note}');" data-toggle="collapse">
                                                    <i class="fa fa-pencil text-yellow"></i>
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