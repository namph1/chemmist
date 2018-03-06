<%-- 
    Document   : search-result
    Created on : Jan 13, 2018, 2:47:59 PM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<div class="row">
    <div class="col-md-12 col-sm-12">
        <div class="panel panel-default">
            <div class="panel-heading clearfix">
                <h3 class="panel-title pull-left" id="modalLabel">
                    <i class="fa fa-list"></i> Báo cáo sản lượng theo vùng
                </h3>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table id="tblPack" class="table table-responsive table-reflow table-hover" >
                        <thead>
                            <tr>
                                <th style="border: 1px solid silver;" class="text-center col-md-1">STT</th>
                                <th style="border: 1px solid silver;">Tỉnh thành- phố</th>
                                <th style="border: 1px solid silver;">Sản lượng</th>
                                <th style="border: 1px solid silver;"  class="text-center col-md-1">Chi tiết</th>
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
                                        <td style="border: 1px solid silver;">${entity.customerName}</td>
                                        <td style="border: 1px solid silver;">
                                            <fmt:formatNumber type = "number" 
                                                              pattern="###,###" value = "${entity.sanluong}" />
                                        </td>
                                        <td style="border: 1px solid silver;" class="text-center">
                                            <a onclick="showHide(this)" id="detail_${entity.customerId}"
                                               data-toggle="collapse" href="#col${entity.customerId}">
                                                <i id="i${entity.customerId}" class="fa fa-chevron-down"></i>
                                            </a>                                            
                                        </td>
                                    </tr>
                                    <tr id="col${entity.customerId}" class="collapse">
                                        <%@include file="tbl_detail.jsp"%>
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
