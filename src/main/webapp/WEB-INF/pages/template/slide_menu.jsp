<%-- 
    Document   : slide_menu
    Created on : Sep 14, 2017, 11:20:39 AM
    Author     : namph
--%>

<%@page import="java.util.Set"%>
<%@page import="java.util.List"%>
<%@page import="com.namph.entity.Menu"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.namph.model.UserCustomImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<aside class="main-sidebar" >
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="${pageContext.request.contextPath}/resources/images/IMG_0315.JPG" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p><%= request.getSession().getAttribute("fullName")%>
                </p>
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <!-- search form -->
        <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Tìm kiếm">
                <span class="input-group-btn">
                    <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                    </button>
                </span>
            </div>
        </form>
        <!-- /.search form -->
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu" data-widget="tree">
            <li class="header">MAIN NAVIGATION</li>
            <li class="active">
                <a href="<%=request.getContextPath()%>/">
                    <i class="fa fa-dashboard"></i> <span>Trang chủ</span>
                </a>
            </li>
            <%
                if (request.getSession().getAttribute("menu") != null) {
                    Set<Menu> lstMenu = (Set<Menu>) request.getSession().getAttribute("menu");
                    if (!lstMenu.isEmpty()) {
                        for (Menu objMenu : lstMenu) {
                            String menuName = objMenu.getName();
                            String icon = objMenu.getIcon();
                            List<Menu> listMenuChild = objMenu.getListMenu();
            %>   
            <li class="treeview">
                <a href="#">
                    <i class="<%= icon%>"></i> <span><%= menuName%></span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <% if (!listMenuChild.isEmpty()) {
                %>  
                <ul class="treeview-menu">
                    <%
                        for (Menu menuChild : listMenuChild) {
                            String childName = menuChild.getName();
                            String url = menuChild.getUrl();
                    %>  

                    <li><a href="<%=request.getContextPath()%>/<%= url%>"><i class="fa fa-angle-double-right"></i><%= childName%></a></li>

                    <%}%>
                </ul>
                <% }%>
            </li>
            <%}
                    }
                }
            %>

        </ul>
    </section>
    <!-- /.sidebar -->
</aside>
<div class="control-sidebar-bg"></div>
<script>
    var ctx = "${pageContext.request.contextPath}";
    var pathname = window.location.pathname; // Returns path only
    var url = window.location.href;
    $('.sidebar-menu').find('a').each(function (e) {
        var path = $(this).attr('href');
        if (path.toString() == pathname.toString()) {
            $('ul li.active').removeClass('active');
            $(this).closest('li').addClass('active');
            $(this).parent().parent().parent().addClass('active');
        }
    });
</script>