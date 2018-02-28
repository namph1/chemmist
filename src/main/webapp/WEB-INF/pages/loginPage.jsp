<%-- 
    Document   : loginPage.jsp
    Created on : Aug 13, 2017, 9:01:34 AM
    Author     : namph
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
    <head><title>Đăng nhập</title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" >
        <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminLte/css/AdminLTE.min.css"/>
        <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/ionicons.min.css">
        <!-- Google Font -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/iCheck/square/blue.css">
        <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/iCheck/icheck.min.js"></script>
        <script>
            $(function () {
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '20%' // optional
                });
            });
        </script>
    </head>
    <body class="hold-transition login-page">
        <%--<jsp:include page="_menu.jsp" />--%>
        <div class="login-box">
            <div class="login-logo">
                <a href="${pageContext.request.contextPath}"><b>Nam </b>Dương</a>
            </div>
            <div class="login-box-body">
                <c:if test="${param.error == 'true'}">
                    <div style="color:red;margin:10px 0px;">
                        Login Failed!!!<br />
                        Reason :  ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}

                    </div>
                </c:if>
                <form  name='f' action="${pageContext.request.contextPath}/j_spring_security_check" method='POST'>
                    <div class="form-group has-feedback">
                        <input  name='username' class="form-control" placeholder="Email">
                        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                    </div>
                    <div class="form-group has-feedback">
                        <input type="password" name="password" class="form-control" placeholder="Password">
                        <span class="fa fa-key form-control-feedback"></span>
                    </div>
                    <div class="row">
                        <div class="col-xs-8">
                            <div class="checkbox icheck">
                                <label>
                                    <input type="checkbox"> Remember Me
                                </label>
                            </div>
                        </div>
                        <!-- /.col -->
                        <div class="col-xs-4">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Đăng nhập</button>
                        </div>
                        <input type="hidden"
                               name="${_csrf.parameterName}"
                               value="${_csrf.token}"/>
                        <!-- /.col -->
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
