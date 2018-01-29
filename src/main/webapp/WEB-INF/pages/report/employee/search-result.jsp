<%-- 
    Document   : search-result
    Created on : Oct 25, 2017, 11:01:59 AM
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
                    <i class="fa fa-list"></i> Báo cáo sản lượng đại lý
                </h3>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table id="tblPack" class="table table-responsive table-reflow table-hover" >
                        <thead>
                            <tr>
                                <th style="border: 1px solid silver;" class="text-center">STT</th>
                                <th style="border: 1px solid silver;">Mã nhân viên</th>
                                <th style="border: 1px solid silver;">Tên nhân viên</th>
                                <th style="border: 1px solid silver;">Địa chỉ</th>
                                <th style="border: 1px solid silver;">Sản lượng</th>
                                <!--<th style="border: 1px solid silver;" class="text-center">Chi tiết</th>-->
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
                                        <td style="border: 1px solid silver;" class="col-md-2">${entity.customerCode}</td>
                                        <td style="border: 1px solid silver;">${entity.customerName}</td>
                                        <td style="border: 1px solid silver;">${entity.address}</td>
                                        <td style="border: 1px solid silver;">
                                            <fmt:formatNumber type = "number" 
                                                              pattern="###,###" value = "${entity.sanluong}" />
                                        </td>
                                        <!--<td style="border: 1px solid silver;"></td>-->
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

