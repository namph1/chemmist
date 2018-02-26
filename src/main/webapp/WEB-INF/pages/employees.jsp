<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta http-equiv="X-UA-Compatible" content="ie=edge">
            <title>Employees - Java Spring Example</title>
            <link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
            <link href="/resources/css/font-awesome.min.css" rel="stylesheet" />
        </head>

        <body>
            <nav class="navbar navbar-inverse">
                <div class="container">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="https://java-in-heroku.herokuapp.com">Java Spring Example</a>
                        <a href="/logout.htm" class="btn btn-default">Logout</a>
                    </div>
                </div>
            </nav>

            <div class="container">
                <table class="table table-hover">
                    <thead>
                        <tr><a href="/add.htm" style="margin-bottom: 20px;" class="fa fa-plus btn btn-success">Add New</a></tr>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Salary</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="e">
                            <tr>
                                <td>${e.id}</td>
                                <td>${e.fullName}</td>
                                <td>${e.address}</td>
                                <td>${e.email}</td>
                                <td>${e.phone}</td>
                                <td>${e.salary}</td>
                                <td>
                                    <a href="/edit.htm?id=${e.id}" class="fa fa-edit btn btn-default">Edit</a>
                                    <a href="/delete.htm?id=${e.id}" class="fa fa-trash btn btn-danger" onclick="return confirm('Do you want to remove this employee?')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
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