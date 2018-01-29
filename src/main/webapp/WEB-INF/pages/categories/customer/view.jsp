<%-- 
    Document   : view
    Created on : Sep 20, 2017, 2:34:22 PM
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
        Danh mục đại lý- khách hàng
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i>Home</a></li>
        <li class="active">Danh mục đại lý- khách hàng</li>
    </ol>
</section>

<%@include file="search-form.jsp" %>
<%@include file="js.jsp" %>
<%@include file="add.jsp" %>