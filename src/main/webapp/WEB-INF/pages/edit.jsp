<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta http-equiv="X-UA-Compatible" content="ie=edge">
            <title>Edit Employee - Java Spring Example</title>
            <link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
        </head>

        <body>
            <nav class="navbar navbar-inverse">
                <div class="container">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="https://java-in-heroku.herokuapp.com/">Java Spring Example</a>
                        <a href="/logout.htm" class="btn btn-default">Logout</a>
                    </div>
                </div>
            </nav>

            <div class="container">
                <div class="col-md-4 col-md-offset-4">
                    <form action="/edit-post.htm" method="POST" role="form">
                        <legend>Edit Employee</legend>

                        <div class="form-group">
                            <input type="text" required class="form-control" id="fullname" name="fullname" value="${e.fullName}" placeholder="Full Name">
                        </div>
                        <div class="form-group">
                            <input type="text" required class="form-control" id="address" name="address" value="${e.address}" placeholder="Address">
                        </div>
                        <div class="form-group">
                            <input type="email" required class="form-control" id="email" name="email" value="${e.email}" placeholder="Email">
                        </div>
                        <div class="form-group">
                            <input type="tel" required class="form-control" id="phone" name="phone" value="${e.phone}" placeholder="Phone">
                        </div>
                        <div class="form-group">
                            <input type="number" min="1000000" required class="form-control" id="salary" value="${e.salary}" name="salary" placeholder="Salary">
                        </div>
                        <input type="hidden" id="id", name="id" value="${e.id}">
                        <button type="submit" class="btn btn-primary">Edit</button>
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