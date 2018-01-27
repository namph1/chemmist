<%-- 
    Document   : details
    Created on : Oct 23, 2017, 11:16:33 AM
    Author     : namph
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<div class="modal fade" id="ojectAdd" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="modalLabel"><label id="lblTitle" >Chi tiết công nợ</label></h4>
            </div>
            <div class="modal-body">

                <ul class="timeline">
                    <c:if test="${not empty lstCongNo}">
                        <c:forEach var="item" items="${lstCongNo}"
                                   varStatus="loopCounter">
                            <li class="time-label">
                                <span class="bg-red">
                                    ${item.key}
                                </span>
                            </li>
                            <c:forEach var="entity" items="${item.value}">
                                <li>
                                    <i class="fa fa-usd bg-blue"></i>

                                    <div class="timeline-item">
                                        <!--<span class="time"><i class="fa fa-clock-o"></i> 12:05</span>-->

                                        <h3 class="timeline-header"><label> ${entity.types}   </label>
                                            <label class="text-blue">  <fmt:formatNumber type = "number" 
                                                              pattern="###,###" value = "${entity.total}" /> <sup>VNĐ</sup></label>
                                        </h3>

                                    </div>
                                </li>
                            </c:forEach>
                        </c:forEach>
                    </c:if>
                </ul>
            </div>
        </div>
        <div class="tab-pane" id="access-security">content 0</div>
    </div>
</div>
