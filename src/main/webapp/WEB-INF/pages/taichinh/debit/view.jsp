<%-- 
    Document   : view
    Created on : Oct 23, 2017, 9:50:47 AM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page session="true"%>
<%@include file="../../template/init.jsp" %>
<%@include file="../../template/header.jsp" %>

<section class="content-header">
    <h1>
        Công nợ khách hàng/ nhân viên
    </h1>
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}"><i class="fa fa-dashboard"></i>Trang chủ</a></li>
        <li class="active">Công nợ khách hàng/ nhân viên</li>
    </ol>
</section>

<%@include file="search-form.jsp" %>
<%@include file="js.jsp" %>
<div id="divConfig">
    <%@include file="details.jsp" %>
</div>
