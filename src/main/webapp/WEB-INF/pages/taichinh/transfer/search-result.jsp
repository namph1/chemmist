<%-- 
    Document   : search-result
    Created on : Oct 14, 2017, 8:59:16 AM
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
                    <i class="fa fa-list"></i> Chứng từ chuyển khoản
                </h3>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table id="tblPack" class="table table-responsive table-reflow table-hover" >
                        <thead>
                            <tr>
                                <th style="border: 1px solid silver;" class="text-center">STT</th>
                                <th style="border: 1px solid silver;">Ngày chứng từ</th>
                                <th style="border: 1px solid silver;">Số chứng từ</th>
                                <th style="border: 1px solid silver;">Mã đối tác</th>
                                <th style="border: 1px solid silver;">Tên đối tác</th>
                                <th style="border: 1px solid silver;">Địa chỉ</th>
                                <th style="border: 1px solid silver;">Ngân hàng</th>
                                <th style="border: 1px solid silver;" class="text-center">Hình thức</th>
                                <th style="border: 1px solid silver;" class="text-center">Số tiền</th>
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
                                        <td style="border: 1px solid silver;" class="col-md-2">${entity.strCreateDate}</td>
                                         <td style="border: 1px solid silver;">${entity.strNo}</td>
                                        <c:if test="${entity.customer != null}">
                                            <td style="border: 1px solid silver;">${entity.customer.code}${entity.customer.level}</td>
                                            <td style="border: 1px solid silver;">${entity.customer.name}</td>
                                            <td style="border: 1px solid silver;">${entity.customer.address}</td>
                                        </c:if>
                                        <c:if test="${entity.employee != null}">
                                            <td style="border: 1px solid silver;">${entity.employee.code}${entity.employee.orders}</td>
                                            <td style="border: 1px solid silver;">${entity.employee.name}</td>
                                            <td style="border: 1px solid silver;">${entity.employee.address}</td>
                                        </c:if> 
                                        <td style="border: 1px solid silver;">${entity.bank.name}</td>
                                        <td style="border: 1px solid silver;" class="text-center">${entity.sStatus}
                                            <c:choose>
                                                <c:when test="${entity.status == 0}">
                                                    <i class="fa fa-arrow-down  text-success"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fa fa-arrow-up text-danger"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="border: 1px solid silver;" class="text-right">
                                            <fmt:formatNumber type = "number" 
                                                              pattern="###,###" value = "${entity.total}" />
                                        </td>
                                        <td style="border: 1px solid silver;" class="text-center">
                                            <a  onclick="showDetailMess('Ghi chú.', '${entity.note}');"
                                                data-toggle="tooltip" title="Ghi chú">
                                                <i class="fa fa-th text-success"></i>
                                            </a> &nbsp;&nbsp;&nbsp;&nbsp;
                                            <c:if test="${entity.customer != null}">
                                                <a onclick="prepareDetail(${entity.status},${entity.id}, 'C${entity.customer.id}', ${entity.bank.id}, ${entity.total}, '${entity.note}');" 
                                                   data-toggle="tooltip" title="Cập nhật">
                                                    <i class="fa fa-pencil text-yellow"></i>
                                                </a> &nbsp;&nbsp;&nbsp;&nbsp;
                                            </c:if>
                                            <c:if test="${entity.employee != null}">
                                                <a onclick="prepareDetail(${entity.status},${entity.id}, 'E${entity.employee.id}', ${entity.bank.id}, ${entity.total}, '${entity.note}');"
                                                   data-toggle="tooltip" title="Cập nhật">
                                                    <i class="fa fa-pencil text-yellow"></i>
                                                </a> &nbsp;&nbsp;&nbsp;&nbsp;
                                            </c:if>
                                            <a  onclick="onDelete(${entity.id});" data-toggle="tooltip" title="Xóa">
                                                <i class="fa fa-trash text-danger"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </tbody>
                        <c:if test="${not empty lstResult}">
                            <tfoot>
                                <tr>
                                    <td colspan="7" class="text-right"><label>Tổng thu</label></td>
                                    <td class="text-right"><label><fmt:formatNumber type = 'number' pattern='###,###' value = '${totalIn}' /></label></td>
                                </tr>
                                <tr>
                                    <td colspan="7" class="text-right"><label>Tổng chi</label></td>
                                    <td class="text-right"><label><fmt:formatNumber type = 'number' pattern='###,###' value = '${totalOut}' /></label></td>
                                </tr>
                            </tfoot>
                        </c:if>
                    </table>
                </div>
            </div>
            <div class="panel-footer" id="divFooter">
                <%@include file="../../template/page_info_ajax.jsp"%>
            </div>
        </div>
    </div>
</div>