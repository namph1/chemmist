<%-- 
    Document   : table_detail
    Created on : Oct 2, 2017, 2:30:02 PM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<input type="hidden" id="msg" value="${error}"/>
<table id="tblProduct" class="table table-responsive table-reflow table-hover" >
    <thead>
        <tr>
            <th style="border: 1px solid silver;" class="text-center">STT</th>
            <th style="border: 1px solid silver;">Mã sản phẩm</th>
            <th style="border: 1px solid silver;">Tên sản phẩm</th>
            <th style="border: 1px solid silver;">Số lượng</th>
            <th style="border: 1px solid silver;">Giá nhập</th>
            <th style="border: 1px solid silver;">Đơn vị</th>
            <th style="border: 1px solid silver;">Khối lượng(kg)</th>
            <th style="border: 1px solid silver;">Tổng khối lượng(kg)</th>
            <th style="border: 1px solid silver;">Thành tiền</th>
            <th style="border: 1px solid silver;" class="text-center">Xóa</th>
        </tr>
    </thead>
    <tbody>
        <c:if test="${not empty lstProduct}">
            <c:forEach var="entity" items="${lstProduct}"
                       varStatus="loopCounter">
                <tr title="${entity.id}">
                    <td style="border: 1px solid silver;" class="text-center">${loopCounter.index+1}</td>
                    <td style="border: 1px solid silver;" class="col-md-2" >${entity.code}</td>
                    <td style="border: 1px solid silver;">${entity.name}</td>
                    <td style="border: 1px solid silver;" contenteditable='true' class="text-right bg-info"
                        onkeyup="changeCount(${entity.id},${entity.price},${entity.weight});" id="count_${entity.id}" >
                        <fmt:formatNumber type = "number"
                                          minFractionDigits="0" maxFractionDigits="2" value = "${entity.count}" /></td>
                    <td style="border: 1px solid silver;" contenteditable='true'  id="price_${entity.id}" class="text-right bg-info">
                        <fmt:formatNumber type = "number" 
                                          minFractionDigits="0" maxFractionDigits="2" value = "${entity.price}" />
                    </td>
                    <td style="border: 1px solid silver;">${entity.unit.name}</td>
                    <td style="border: 1px solid silver;" class="text-right">${entity.weight}</td>
                    <td style="border: 1px solid silver;" class="text-right"  id="weight_${entity.id}">
                        <fmt:formatNumber type = "number" 
                                          minFractionDigits="0" maxFractionDigits="2" value = "${entity.weight* entity.count}" />
                    </td>
                    <td style="border: 1px solid silver;" class="text-right" id="total_${entity.id}"> <fmt:formatNumber type = "number" 
                                                     minFractionDigits="0" maxFractionDigits="2" value = "${entity.price* entity.count}" /></td>
                    <td style="border: 1px solid silver;" class="text-center">
                        <a data-toggle="collapse" onclick="onDel(${entity.id});">
                            <i class="fa fa-trash text-danger"></i>
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </c:if>
    </tbody>
    <tfoot>
        <tr class="info"> 
            <td class="text-right" style="border: 1px solid silver;" colspan="3">Tổng</td>
            <td class="text-right" style="border: 1px solid silver;">
                <label id="total_count"><fmt:formatNumber type = 'number' pattern='###,###' value = '${total_count}' />
                </label></td>
            <td colspan="4" class="text-right" style="border: 1px solid silver;">
                <label id="total_weight"><fmt:formatNumber type = 'number'  minFractionDigits="0" maxFractionDigits="2" value = '${total_weight}' />
                </label>
            </td>
            <td style="border: 1px solid silver;" class="text-right">
                <label id="total_price"><fmt:formatNumber type = 'number' minFractionDigits="0" maxFractionDigits="2" value = '${total_price}' />
                </label>

            </td>
            <td style="border: 1px solid silver;" ></td>
        </tr>
    </tfoot>
</table>
