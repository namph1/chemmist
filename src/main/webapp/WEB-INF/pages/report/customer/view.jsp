<%-- 
    Document   : view
    Created on : Oct 25, 2017, 11:01:42 AM
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
        Báo cáo sản lượng xuất theo đại lý
    </h1>
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}"><i class="fa fa-dashboard"></i>Trang chủ</a></li>
        <li class="active">Báo cáo sản lượng xuất theo đại lý</li>
    </ol>
</section>

<%@include file="js.jsp" %>
<%@include file="search-form.jsp" %>