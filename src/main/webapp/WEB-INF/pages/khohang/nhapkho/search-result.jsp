<%-- 
    Document   : search-result
    Created on : Sep 29, 2017, 1:27:48 PM
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
                    <a onclick='prepareAdd();'><i class="fa fa-plus text-aqua">Nhập kho</i></a>
                </div>
            </div>

            <div class="panel-body">
                <div class="table-responsive">
                    <table id="tblPack" class="table table-responsive table-reflow table-hover" >
                        <thead>
                            <tr>
                                <th style="border: 1px solid silver;" class="text-center">STT</th>
                                <th style="border: 1px solid silver;">Ngày nhập</th>
                                <th style="border: 1px solid silver;">Số phiếu</th>
                                <th style="border: 1px solid silver;">Nhà cung cấp</th>
                                <th style="border: 1px solid silver;">Khối lượng</th>
                                <th style="border: 1px solid silver;">Phí vận chuyển</th>
                                <th style="border: 1px solid silver;">Tỷ giá</th>
                                <th style="border: 1px solid silver;">Tiền hàng</th>
                                <th style="border: 1px solid silver;">Thanh toán</th>                                
                                <th style="border: 1px solid silver;">Người nhập</th>
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
                                        <td style="border: 1px solid silver;" class="text-right">${entity.strNo}</td>
                                        <td style="border: 1px solid silver;">${entity.customer.name}</td>
                                        <td style="border: 1px solid silver;" class="text-right">
                                            <fmt:formatNumber type = "number" 
                                                          pattern="###,###.###" value = "${entity.weight}" />
                                        </td>
                                        <td style="border: 1px solid silver;" class="text-right">${entity.feeShip}</td>
                                        <td style="border: 1px solid silver;" class="text-right">${entity.rate}</td>
                                        <td style="border: 1px solid silver;" class="text-right">
                                            <fmt:formatNumber type = "number" 
                                                               minFractionDigits="0" maxFractionDigits="2" value = "${entity.totalPrice}" />
                                            </td>
                                        <td style="border: 1px solid silver;" class="text-right">
                                            <fmt:formatNumber type = "number" 
                                                               minFractionDigits="0" maxFractionDigits="2" value = "${entity.total}" /></td>
                                        <td style="border: 1px solid silver;">${entity.users.name}</td>
                                        <td style="border: 1px solid silver;" class="text-center">
                                            <a onclick="onDetail(${entity.id}, '${entity.feeShip}', '${entity.rate}');" data-toggle="collapse">
                                                <i class="fa fa-th text-success"></i>
                                            </a> &nbsp;&nbsp;&nbsp;&nbsp;
                                            <a onclick="onDelete(${entity.id}, '${entity.no}');" data-toggle="collapse">
                                                <i class="fa fa-trash text-danger"></i>
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