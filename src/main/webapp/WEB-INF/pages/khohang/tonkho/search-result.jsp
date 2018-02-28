<%-- 
    Document   : search-result
    Created on : Oct 13, 2017, 2:37:13 PM
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
                    <i class="fa fa-list"></i>Chi tiết tồn kho
                </h3>
            </div>

            <div class="panel-body">
                <div class="table-responsive">
                    <table id="tblPack" class="table table-responsive table-reflow table-hover" >
                        <thead>
                            <tr>
                                <th style="border: 1px solid silver;vertical-align:middle" class="text-center" rowspan="2">STT</th>
                                <th style="border: 1px solid silver;vertical-align:middle" rowspan="2">Mã sản phẩm</th>
                                <th style="border: 1px solid silver;vertical-align:middle" rowspan="2">Tên sản phẩm</th>
                                <th style="border: 1px solid silver;"  class="info" colspan="2">Tồn kho đầu kỳ</th>
                                <th style="border: 1px solid silver;" colspan="2">Nhập kho</th>
                                <th style="border: 1px solid silver;"  class="info" colspan="2">Xuất kho</th>
                                <th style="border: 1px solid silver;" colspan="2">Tồn kho cuối kỳ</th>
                                <th style="border: 1px solid silver;;vertical-align:middle" class="text-center" rowspan="2">Đơn vị</th>
                            </tr>
                            <tr>
                                <th style="border: 1px solid silver;" class="info">Khối lượng(kg)</th>
                                <th style="border: 1px solid silver;" class="info">Số lượng</th>
                                <th style="border: 1px solid silver;">Khối lượng(kg)</th>
                                <th style="border: 1px solid silver;">Số lượng</th>
                                <th style="border: 1px solid silver;"  class="info">Khối lượng(kg)</th>
                                <th style="border: 1px solid silver;" class="info">Số lượng</th>
                                <th style="border: 1px solid silver;">Khối lượng(kg)</th>
                                <th style="border: 1px solid silver;">Số lượng</th>
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
                                        <td style="border: 1px solid silver;">${entity.productCode}</td>
                                        <td style="border: 1px solid silver;">${entity.productName}</td>
                                        <td style="border: 1px solid silver;"  class="info text-right <c:if test="${entity.count < 0}"> text-red</c:if>" >
                                            <label>
                                                <fmt:formatNumber type = "number" 
                                                                  pattern="###,###.###" value = "${entity.weight * entity.tondauky}" /></label>
                                        </td>
                                        <td style="border: 1px solid silver;"  class="info text-right  <c:if test="${entity.count < 0}"> text-red</c:if>"><label>
                                                <fmt:formatNumber type = "number" 
                                                                  pattern="###,###.###" value = "${entity.tondauky}" /></label></td>
                                        <td style="border: 1px solid silver;"  class="text-right  <c:if test="${entity.count < 0}"> text-red</c:if>">
                                            <label>
                                                <fmt:formatNumber type = "number" 
                                                                  pattern="###,###.###" value = "${entity.sanluong * entity.weight}" /></label></td>
                                        <td style="border: 1px solid silver;"  class="text-right  <c:if test="${entity.count < 0}"> text-red</c:if>">
                                            <label>
                                                <fmt:formatNumber type = "number" 
                                                                  pattern="###,###.###" value = "${entity.sanluong}" /></label></td>
                                        <td style="border: 1px solid silver;"  class="info text-right  <c:if test="${entity.count < 0}"> text-red</c:if>">
                                            <label>
                                                <fmt:formatNumber type = "number" 
                                                                  pattern="###,###.###" value = "${entity.sanluongXuat * entity.weight}" /></label></td>
                                        <td style="border: 1px solid silver;" class="info text-right  <c:if test="${entity.count < 0}"> text-red</c:if>">
                                            <label>
                                                <fmt:formatNumber type = "number" 
                                                                  pattern="###,###.###" value = "${entity.sanluongXuat}" /></label></td>
                                        <td style="border: 1px solid silver;"  class="text-right <c:if test="${entity.count < 0}"> text-red</c:if>" >
                                            <label>
                                                <fmt:formatNumber type = "number" 
                                                                  pattern="###,###.###" value = "${entity.weight* entity.count}" /></label>
                                        </td>
                                        <td style="border: 1px solid silver;"  class="text-right  <c:if test="${entity.count < 0}"> text-red</c:if>"><label>
                                                <fmt:formatNumber type = "number" 
                                                                  pattern="###,###.###" value = "${entity.count}" /></label></td>
                                        <td  style="border: 1px solid silver;">${entity.unitName}</td>
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
