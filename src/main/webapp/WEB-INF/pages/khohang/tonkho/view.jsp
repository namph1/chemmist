<%-- 
    Document   : view
    Created on : Oct 13, 2017, 2:35:46 PM
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
        Quản lý tồn kho
    </h1>
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}"><i class="fa fa-dashboard"></i>Trang chủ</a></li>
        <li class="active">Quản lý tồn kho</li>
    </ol>
</section>
<input type="hidden" id="csrfToken" value="${_csrf.token}"/>
<input type="hidden" id="csrfHeader" value="${_csrf.headerName}"/>

<%@include file="search-form.jsp" %>
<%@include file="js.jsp" %>