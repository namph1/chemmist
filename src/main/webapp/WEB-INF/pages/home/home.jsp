<%-- 
    Document   : home
    Created on : Oct 25, 2017, 9:51:16 AM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%@page session="true"%>
<%@include file="../template/init.jsp" %>
<%@include file="../template/header.jsp" %>


<section class="content-header">
    <h1>
        Trang chủ
    </h1>
    <ol class="breadcrumb">
        <li><a href="${pageContext.request.contextPath}"><i class="fa fa-dashboard"></i>Trang chủ</a></li>
    </ol>
</section>
<section class="content">
    <div class="row">
        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-aqua">
                <div class="inner">
                    <h3>${sizeExp}</h3>

                    <p>Đơn hàng</p>
                </div>
                <div class="icon" style="top: 5px;">
                    <i class="fa fa-bell-o"></i>
                </div>
                <a href="<%=request.getContextPath()%>/export" class="small-box-footer">Đi tiếp <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-green">
                <div class="inner">
                    <h3>${sizeProduct}</h3>

                    <p>Sản phẩm</p>
                </div>
                <div class="icon" style="top: 5px;">
                    <i class="ion ion-stats-bars"></i>
                </div>
                <a href="#" class="small-box-footer">Đi tiếp <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-yellow">
                <div class="inner">
                    <h3>${sizeCus}</h3>

                    <p>Khách hàng</p>
                </div>
                <div class="icon" style="top: 5px;">
                    <i class="ion ion-person-add"></i>
                </div>
                <a href="<%=request.getContextPath()%>/customer" class="small-box-footer">Đi tiếp <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-red">
                <div class="inner">
                    <h3><fmt:formatNumber type = "number" minFractionDigits="0" maxFractionDigits="2" value = "${sizeMoney}" /></h3>

                    <p>Doanh thu(VNĐ)</p>
                </div>
                <div class="icon" style="top: 5px;">
                    <i class="ion ion-pie-graph"></i>
                </div>
                <a href="<%=request.getContextPath()%>/cash" class="small-box-footer">Đi tiếp <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-gray-active">
                <div class="inner">
                    <h3><fmt:formatNumber type = "number" minFractionDigits="0" maxFractionDigits="2" value = "${sizeMoney2}" /></h3>

                    <p>Chi phí(VNĐ)</p>
                </div>
                <div class="icon" style="top: 5px;">
                    <i class="ion ion-paper-airplane"></i>
                </div>
                <a href="<%=request.getContextPath()%>/cash" class="small-box-footer">Đi tiếp <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <div class="col-lg-3 col-xs-6">
            <!-- small box -->
            <div class="small-box bg-teal-active">
                <div class="inner">
                    <h3><fmt:formatNumber type = "number" minFractionDigits="0" maxFractionDigits="2" value = "${sizeOline}" /></h3>

                    <p>Người dùng đang truy cập</p>
                </div>
                <div class="icon" style="top: 5px;">
                    <i class="ion ion-ios-contact"></i>
                </div>
                <a href="<%=request.getContextPath()%>/cash" class="small-box-footer">Đi tiếp <i class="fa fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
    </div>
</section>   

