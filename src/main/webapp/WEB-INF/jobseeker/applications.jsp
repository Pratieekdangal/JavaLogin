<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>JobConnect - My Applications</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            </head>

            <body>
                <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                    <div class="container">
                        <a class="navbar-brand" href="#">JobConnect</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto">
                                <li class="nav-item">
                                    <a class="nav-link"
                                        href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/profile">My Profile</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/applications">My
                                        Applications</a>
                                </li>
                            </ul>
                            <div class="d-flex">
                                <a href="${pageContext.request.contextPath}/logout" class="btn btn-light">Logout</a>
                            </div>
                        </div>
                    </div>
                </nav>

                <div class="container mt-4">
                    <h2>My Applications</h2>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="row mt-4">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <c:choose>
                                        <c:when test="${empty applications}">
                                            <p class="text-muted text-center">You haven't applied to any jobs yet.</p>
                                            <div class="text-center mt-3">
                                                <a href="${pageContext.request.contextPath}/dashboard"
                                                    class="btn btn-primary">
                                                    Browse Jobs
                                                </a>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="table-responsive">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>Job Title</th>
                                                            <th>Department</th>
                                                            <th>Applied Date</th>
                                                            <th>Status</th>
                                                            <th>Actions</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${applications}" var="app">
                                                            <tr>
                                                                <td>${app.jobTitle}</td>
                                                                <td>${app.jobDepartment}</td>
                                                                <td>
                                                                    <fmt:formatDate value="${app.appliedDate}"
                                                                        pattern="MMM dd, yyyy" />
                                                                </td>
                                                                <td>
                                                                    <span
                                                                        class="badge bg-${app.status eq 'PENDING' ? 'warning' : 
                                                                               app.status eq 'ACCEPTED' ? 'success' : 
                                                                               app.status eq 'REJECTED' ? 'danger' : 'secondary'}">
                                                                        ${app.status}
                                                                    </span>
                                                                </td>
                                                                <td>
                                                                    <a href="${pageContext.request.contextPath}/jobs/view?id=${app.jobId}"
                                                                        class="btn btn-sm btn-outline-primary">
                                                                        View Job
                                                                    </a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>