<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Login - JobConnect</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <body class="bg-light">
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container">
                    <a class="navbar-brand" href="${pageContext.request.contextPath}/">JobConnect</a>
                </div>
            </nav>

            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card shadow">
                            <div class="card-body">
                                <h2 class="text-center mb-4">Login</h2>

                                <% if (request.getParameter("error") !=null) { %>
                                    <div class="alert alert-danger">
                                        <%= request.getParameter("error") %>
                                    </div>
                                    <% } %>

                                        <% if (request.getParameter("message") !=null) { %>
                                            <div class="alert alert-success">
                                                <%= request.getParameter("message") %>
                                            </div>
                                            <% } %>

                                                <form action="${pageContext.request.contextPath}/login" method="post">
                                                    <div class="mb-3">
                                                        <label for="email" class="form-label">Email address</label>
                                                        <input type="email" class="form-control" id="email" name="email"
                                                            required>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="password" class="form-label">Password</label>
                                                        <input type="password" class="form-control" id="password"
                                                            name="password" required>
                                                    </div>

                                                    <div class="d-grid gap-2">
                                                        <button type="submit" class="btn btn-primary">Login</button>
                                                    </div>
                                                </form>

                                                <div class="text-center mt-3">
                                                    <p>Don't have an account?
                                                        <a href="${pageContext.request.contextPath}/register.jsp">Register
                                                            here</a>
                                                    </p>
                                                    <p><a href="${pageContext.request.contextPath}/forgot-password.jsp">Forgot
                                                            Password?</a></p>
                                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>