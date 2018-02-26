<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Login - Java Spring Example</title>
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body>
    <nav class="navbar navbar-inverse">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="https://java-in-heroku.herokuapp.com/">Java Spring Example</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="col-md-4 col-md-offset-4">
            <form action="/login.htm" method="POST" role="form">
                <legend>Login</legend>

                <div class="form-group">
                    <input type="text" class="form-control" id="username" name="username" placeholder="Username">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                </div>
                <button type="submit" class="btn btn-primary">Login</button>
                <c:if test="${error == 1}">
                    <div class="alert alert-danger" role="alert">Username or password invaild!</div>
                </c:if>
            </form>
        </div>
    </div>

    <div class="container">
        <footer>
            <p>
                &copy; <a href="http://sakadream.me">sakadream.me</a> 2017
            </p>
        </footer>
    </div>
</body>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/jquery.min.js"></script>

</html>