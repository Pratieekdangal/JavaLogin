<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>JobConnect - My Applications</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                <style>
                    .applications-main {
                        max-width: 1100px;
                        margin: 5.5rem auto 2rem auto;
                        padding: 0 1.5rem;
                    }
                    .card {
                        background: var(--white);
                        border-radius: 1rem;
                        box-shadow: var(--shadow-md);
                        padding: 2rem;
                        margin-bottom: 2rem;
                    }
                    .empty-state {
                        text-align: center;
                        color: var(--text-light);
                        margin: 4rem 0;
                    }
                    .empty-icon {
                        font-size: 2.5rem;
                        color: var(--primary-color);
                        margin-bottom: 0.5rem;
                    }
                    .table {
                        width: 100%;
                        border-collapse: collapse;
                    }
                    .table th, .table td {
                        padding: 0.75rem 1rem;
                        border-bottom: 1px solid #e5e7eb;
                        text-align: left;
                    }
                    .table th {
                        background: #f3f4f6;
                        color: var(--text-color);
                        font-weight: 600;
                    }
                    .badge {
                        display: inline-block;
                        padding: 0.35em 0.7em;
                        font-size: 0.9em;
                        border-radius: 0.5em;
                        font-weight: 500;
                    }
                    .bg-warning { background: #facc15; color: #92400e; }
                    .bg-success { background: #4ade80; color: #166534; }
                    .bg-danger { background: #f87171; color: #991b1b; }
                    .bg-secondary { background: #e5e7eb; color: #374151; }
                </style>
            </head>

            <body>
                <!-- Top Navbar -->
                <nav class="navbar">
                    <div class="nav-container">
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/">JobConnect</a>
                        <ul class="nav-menu">
                            <li><a class="nav-link" href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                            <li><a class="nav-link" href="${pageContext.request.contextPath}/browse">Browse Jobs</a></li>
                            <li><a class="nav-link active" href="${pageContext.request.contextPath}/applications">My Applications</a></li>
                            <li><a class="nav-link" style="color: #ef4444;" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                        </ul>
                    </div>
                </nav>
                <div class="applications-main">
                    <h1 style="font-size:2rem;font-weight:800;margin-bottom:1.5rem;">My Applications</h1>
                    <c:if test="${not empty success}">
                        <div class="card" style="background:#e6ffed;color:#15803d;">${success}</div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="card" style="background:#ffeaea;color:#e11d48;">${error}</div>
                    </c:if>
                    <div class="card">
                        <c:choose>
                            <c:when test="${empty applications}">
                                <div class="empty-state">
                                    <div class="empty-icon">📄</div>
                                    <div>You haven't applied to any jobs yet.</div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table">
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
                                                <td><fmt:formatDate value="${app.appliedDate}" pattern="MMM dd, yyyy" /></td>
                                                <td>
                                                    <span class="badge bg-${app.status eq 'PENDING' ? 'warning' : app.status eq 'ACCEPTED' ? 'success' : app.status eq 'REJECTED' ? 'danger' : 'secondary'}">
                                                        ${app.status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/view-job?id=${app.jobId}" class="button button-outline">View Job</a>
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
            </body>

            </html>