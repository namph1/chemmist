<%-- 
    Document   : tbl_detail
    Created on : Jan 18, 2018, 11:05:46 AM
    Author     : namph
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<td colspan="1">
<td colspan="2">
    <table style="width: 100%">
        <tbody>
            <c:if test="${not empty listDetails}">
                <c:forEach var="itemDetail" items="${listDetails}"
                           varStatus="loopCounter">
                    <tr>
                        <td  class=" col-md-1">Khu vực</td>
                        <td  class="text-primary col-md-3">${itemDetail.customerName}</td>
                        <td  class="col-md-1">Sản lượng</td>
                        <td  class="text-primary col-md-3"><fmt:formatNumber type = "number" 
                                                              pattern="###,###" value = "${itemDetail.sanluong}" /></td>
                    </tr>
                </c:forEach>
            </c:if>
        </tbody>
    </table>
</td>
<td colspan="1">
