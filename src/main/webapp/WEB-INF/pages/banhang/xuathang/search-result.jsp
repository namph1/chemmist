<%-- 
    Document   : search-result
    Created on : Oct 8, 2017, 10:31:34 AM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


<input type="hidden" id="message" value="${message}">
<div class="row">
    <div class="col-md-12 col-sm-12">
        <div class="panel panel-default">
            <div class="panel-heading clearfix">
                <h3 class="panel-title pull-left" id="modalLabel">
                    <i class="fa fa-list"></i> Danh sách chứng từ
                </h3>
                <div class="panel-title pull-right">
                    <a class="btn btn-flat" onclick='prepareAdd();'><i class="fa fa-plus text-aqua">Xuất kho</i></a>
                </div>
            </div>

            <div class="panel-body">
                <div class="table-responsive">
                    <table id="tblPack" class="table table-responsive table-reflow table-hover" >
                        <thead>
                            <tr>
                                <th style="border: 1px solid silver;" class="text-center">STT</th>
                                <th style="border: 1px solid silver;">Ngày xuất</th>
                                <th style="border: 1px solid silver;">Mã khách</th>
                                <th style="border: 1px solid silver;">Khách hàng</th>
                                <th style="border: 1px solid silver;">Số phiếu</th>
                                <th style="border: 1px solid silver;">Tổng tiền hàng</th>
                                <th style="border: 1px solid silver;">Chiết khấu</th>
                                <th style="border: 1px solid silver;">Tổng thanh toán</th>
                                <th style="border: 1px solid silver;">Khối lượng(kg)</th>
                                <th style="border: 1px solid silver;" class="text-center">Chi tiết</th>
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
                                        <td style="border: 1px solid silver;">${entity.strCreateDate}</td>
                                        <td style="border: 1px solid silver;">${entity.customer.code}${entity.customer.level}</td>
                                        <td style="border: 1px solid silver;">${entity.customer.name}</td>
                                        <td style="border: 1px solid silver;">${entity.strNo}</td>
                                        <td style="border: 1px solid silver;" class="text-right ">
                                            <fmt:formatNumber type = "number" 
                                                              pattern="###,###" value = "${entity.total}" /></td>
                                        <td style="border: 1px solid silver;" class="text-right">
                                            <fmt:formatNumber type = "number" 
                                                              pattern="###,###" value = "${entity.discount}" /></td>
                                        <td style="border: 1px solid silver;" class="text-right ">
                                            <fmt:formatNumber type = "number" 
                                                              pattern="###,###" value = "${entity.totalLast}" /></td>
                                        <td style="border: 1px solid silver;" class="text-right ">
                                            <fmt:formatNumber type = "number" 
                                                               minFractionDigits="0" maxFractionDigits="2" value = "${entity.weight}" /></td>
                                        <td style="border: 1px solid silver;" class="text-center">
                                            <a  onclick="onDetail(${entity.id},${entity.customer.id}, '${entity.customer.address}');" data-toggle="tooltip" title="Chi tiết">
                                                <i class="fa fa-th text-success"></i>
                                            </a> &nbsp;
                                            <a  onclick="onDelete(${entity.id}, '${entity.strNo}');" data-toggle="tooltip" title="Xóa">
                                                <i class="fa fa-trash text-danger"></i>
                                            </a>&nbsp;
<!--                                            <a  href="<%=request.getContextPath()%>/export/print/${entity.id}" target="_blank" data-toggle="tooltip" title="In phiếu xuất kho">
                                                <i class="ion ion-printer text-blue"></i>
                                            </a>&nbsp;
                                            <a  href="<%=request.getContextPath()%>/export/print2/${entity.id}" target="_blank" data-toggle="tooltip" title="In phiếu giao hàng">
                                                <i class="ion ion-printer text-navy"></i>
                                            </a>-->
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
