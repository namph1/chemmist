<%-- 
    Document   : table_detail
    Created on : Oct 8, 2017, 3:03:39 PM
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
            <th style="border: 1px solid silver;">Đơn vị</th>
            <th style="border: 1px solid silver;">Số lượng</th>
            <th style="border: 1px solid silver;">Giá thành</th>
            <th style="border: 1px solid silver;">Thành tiền</th>
            <th style="border: 1px solid silver;">Khối lượng</th>
            <th style="border: 1px solid silver;">Tổng khối lượng</th>
            <th style="border: 1px solid silver;" class="text-center">Xóa</th>
        </tr>
    </thead>
    <tbody>
        <c:if test="${not empty lstProduct}">
            <c:forEach var="entity" items="${lstProduct}"
                       varStatus="loopCounter">
                <tr title="${entity.id}" id="${entity.exportDetailId}">
                    <td style="border: 1px solid silver;" class="text-center">${loopCounter.index+1}</td>
                    <td style="border: 1px solid silver;" >${entity.code}</td>
                    <td style="border: 1px solid silver;">${entity.name}</td>
                    <td style="border: 1px solid silver;" class="col-md-1" id="unit_${entity.unit.id}">${entity.unit.name}</td>
                    <td style="border: 1px solid silver;" id="count_${entity.id}"  
                        onkeyup="changeCount(${entity.id},${entity.price},${entity.weight});" 
                        contenteditable='true'>
                        ${entity.count}</td>
                    <td style="border: 1px solid silver;" 
                        id="price_${entity.id}"
                        class="col-md-2"  
                        onkeyup="changeCount(${entity.id},${entity.price},${entity.weight});" 
                        contenteditable='true'>
                        <fmt:formatNumber type = "number" 
                                          pattern="###,###" value = "${entity.price}" /></td>
                    <td style="border: 1px solid silver;" id="total_${entity.id}" >
                        <fmt:formatNumber type = "number" 
                                          pattern="###,###" value = "${entity.price* entity.count}" />
                    </td>
                    <td style="border: 1px solid silver;">${entity.weight}</td>
                    <td style="border: 1px solid silver;" id="weight_${entity.id}">
                        <fmt:formatNumber type = "number" 
                                         minFractionDigits="0" maxFractionDigits="2" value = "${entity.weight* entity.count}" /></td>
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
        <tr class="success">
            <td></td>
            <td >Tổng tiền hàng</td>
            <td id="totalBefore">
                <fmt:formatNumber type = "number" 
                                  pattern="###,###" value = "${total}" /></td>
            <td >Chiết khấu</td>
            <td>
                <input type="text" id="discount" style="width: 100%;" 
                       value="<fmt:formatNumber type = 'number' pattern='###,###' value = '${discount}' />" 
                       onchange="calculatorTotal(${total}, this.value);"/>
            </td>
            <td>Tổng thanh toán</td>
            <td><label id="total"><fmt:formatNumber type = 'number' pattern='###,###' value = '${total-discount}' /></label></td>
            <td></td>
            <td colspan="2"></td>
        </tr>
    </tfoot>
</table>
