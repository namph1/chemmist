<%-- 
    Document   : search-result
    Created on : Sep 17, 2017, 1:54:56 PM
    Author     : namph
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<div class="row">
    <div id="myModal" class="cus_modal">
        <span class="cus_close">&times;</span>
        <img class="cus_modal-content" id="img01" >
        <div id="caption"></div>
    </div>
    <div class="col-md-12 col-sm-12">
        <div class="panel panel-default">
            <div class="panel-heading clearfix">
                <h3 class="panel-title pull-left" id="modalLabel">
                    <i class="fa fa-list"></i> Danh sách sản phẩm
                </h3>
                <div class="panel-title pull-right">
                    <a onclick='prepareAdd();'><i class="fa fa-plus text-aqua">Thêm mới</i></a>
                </div>
            </div>

            <div class="panel-body">
                <div class="table-responsive">
                    <table id="tblPack" class="table table-responsive table-reflow table-hover" >
                        <thead>
                            <tr>
                                <th style="border: 1px solid silver;" class="text-center">STT</th>
                                <th style="border: 1px solid silver;">Mã sản phẩm</th>
                                <th style="border: 1px solid silver;">Tên sản phẩm</th>
                                <th style="border: 1px solid silver;">Nhóm sản phẩm</th>
                                <th style="border: 1px solid silver;">Đơn vị</th>
                                <th style="border: 1px solid silver;">Khối lượng(kg)</th>
                                <th style="border: 1px solid silver;">Giá bán(VNĐ)</th>
                                <th style="border: 1px solid silver;">Giá gốc(AUD)</th>
                                <th style="border: 1px solid silver;">Trạng thái</th>
                                <th style="border: 1px solid silver;">Ghi chú</th>
                                <th style="border: 1px solid silver;">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${not empty lstResult}">
                                <c:forEach var="entity" items="${lstResult}"
                                           varStatus="loopCounter">
                                    <c:if test="${loopCounter.index % 2 == 0}">
                                        <tr class="active">
                                            <td style="border: 1px solid silver;" 
                                                class="text-center">${loopCounter.index+1}</td>
                                            <td style="border: 1px solid silver;">${entity.code}</td>
                                            <td style="border: 1px solid silver;">${entity.name}
<!--                                                <a onclick="showImage('${entity.getImage()}', '${entity.name}');" data-toggle="tooltip" title="Ảnh đại diện">
                                                    <i class="fa fa-picture-o text-primary"></i>
                                                </a>-->
                                            </td>
                                            <td style="border: 1px solid silver;">${entity.group.name}</td>
                                            <td style="border: 1px solid silver;">${entity.unit.name}</td>
                                            <td style="border: 1px solid silver;">
                                                <fmt:formatNumber type = "number" 
                                                                  pattern="###,###.###" value = "${entity.weight}" /></td>
                                            <td style="border: 1px solid silver;">
                                                <fmt:formatNumber type = "number" 
                                                                  pattern="###,###" value = "${entity.price}" />
                                            </td>
                                            <td style="border: 1px solid silver;">${entity.priceAu}
                                            </td>
                                            <td style="border: 1px solid silver;">${entity.sStatus}</td>
                                            <td style="border: 1px solid silver;">
                                                <a onclick="showDetailMess('Detail', '${entity.note}');" data-toggle="collapse">
                                                    <i class="fa fa-th text-light-blue"></i>
                                                </a>
                                            </td>
                                            <td style="border: 1px solid silver;" class="text-center">
                                                <a onclick="lockUnlock(${entity.id},${entity.status}, '${entity.name}');" data-toggle="collapse">
                                                    <c:choose>
                                                        <c:when test="${entity.status == 1}">
                                                            <i class="fa fa-lock text-danger"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa fa-unlock text-danger"></i>
                                                        </c:otherwise>
                                                    </c:choose>       

                                                </a>
                                                <c:if test="${entity.status == 1}">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <a onclick="prepareEdit(${entity.id});" data-toggle="collapse">
                                                        <i class="fa fa-pencil text-yellow"></i>
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:if test="${loopCounter.index % 2 != 0}">
                                        <tr>
                                            <td style="border: 1px solid silver;" class="text-center">${loopCounter.index+1}</td>
                                            <td style="border: 1px solid silver;">${entity.code}</td>
                                            <td style="border: 1px solid silver;">${entity.name}
<!--                                                <a onclick="showImage('${entity.image}', '${entity.name}');" data-toggle="tooltip" title="Ảnh đại diện">
                                                    <i class="fa fa-picture-o text-primary"></i>
                                                </a>-->
                                            </td>
                                            <td style="border: 1px solid silver;">${entity.group.name}</td>
                                            <td style="border: 1px solid silver;">${entity.unit.name}</td>
                                            <td style="border: 1px solid silver;">
                                                <fmt:formatNumber type = "number" 
                                                                  pattern="###,###.###" value = "${entity.weight}" /></td>
                                            <td style="border: 1px solid silver;">
                                                <fmt:formatNumber type = "number"  
                                                                  pattern="###,###" value = "${entity.price}" /></td>
                                            <td style="border: 1px solid silver;">${entity.priceAu}
                                            </td>
                                            <td style="border: 1px solid silver;">${entity.sStatus}</td>
                                            <td style="border: 1px solid silver;">
                                                <a onclick="showDetailMess('Detail', '${entity.note}');" data-toggle="collapse">
                                                    <i class="fa fa-th text-light-blue"></i>
                                                </a>
                                            </td>
                                            <td style="border: 1px solid silver;" class="text-center">
                                                <a onclick="lockUnlock(${entity.id},${entity.status}, '${entity.name}');" data-toggle="collapse">
                                                    <c:choose>
                                                        <c:when test="${entity.status == 1}">
                                                            <i class="fa fa-lock text-danger"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa fa-unlock text-danger"></i>
                                                        </c:otherwise>
                                                    </c:choose>       

                                                </a>
                                                <c:if test="${entity.status == 1}">
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <a onclick="prepareEdit(${entity.id});" data-toggle="collapse">
                                                        <i class="fa fa-pencil text-yellow"></i>
                                                    </a>
                                                </c:if>
                                            </td>  
                                        </tr>
                                    </c:if>
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
