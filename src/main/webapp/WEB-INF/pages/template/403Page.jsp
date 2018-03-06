<%-- 
    Document   : 403Page.jsp
    Created on : Aug 13, 2017, 9:00:56 AM
    Author     : namph
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page session="true"%>
<%@include file="init.jsp" %>
<%@include file="header.jsp" %>


<section class="content">
    <div class="error-page">
        <h2 class="headline text-yellow">${errorCode}</h2>

        <div class="error-content">
            <h3><i class="fa fa-warning text-yellow"></i>
                <c:choose>
                    <c:when test="${errorCode == 403}">
                        Bạn không có quyền truy cập trang này!
                    </c:when>
                    <c:otherwise>
                          Rất tiếc! Không tìm thấy trang yêu cầu.
                    </c:otherwise>
                </c:choose>
                
              </h3>
            <p>
               Chúng tôi không thể tìm thấy trang bạn đang tìm kiếm.
               Bạn có thể quay trở lại <a href="<%=request.getContextPath()%>">Trang chủ</a> hoặc sử dụng khung tìm kiếm.
            </p>
            <form class="search-form">
                <div class="input-group">
                    <input type="text" name="search" class="form-control" placeholder="Search">

                    <div class="input-group-btn">
                        <button type="submit" name="submit" class="btn btn-warning btn-flat"><i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
                <!-- /.input-group -->
            </form>
        </div>
        <!-- /.error-content -->
    </div>
    <!-- /.error-page -->
</section>
