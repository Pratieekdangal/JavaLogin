<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobConnect - Job Seeker Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
            display: inline-block;
        }
        .status-PENDING {
            background-color: #fff3cd;
            color: #856404;
        }
        .status-ACCEPTED {
            background-color: #d4edda;
            color: #155724;
        }
        .status-REJECTED {
            background-color: #f8d7da;
            color: #721c24;
        }
        .application-card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .application-card:hover {
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .job-title {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        .company-name {
            color: #6c757d;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">JobConnect</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/profile">My Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/applications">My Applications</a>
                    </li>
                </ul>
                <div class="d-flex">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-light">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Welcome, ${user.name}!</h2>
        
        <div class="row mt-4">
            <div class="col-md-8">
                <div class="card mb-4">
                    <div class="card-header">
                        <h3 class="card-title">Recent Applications</h3>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty applications}">
                            <p class="text-muted">You haven't applied to any jobs yet.</p>
                        </c:if>
                        
                        <c:forEach var="application" items="${applications}">
                            <div class="application-card mb-3 p-3">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <h5 class="job-title mb-1">${application.jobTitle}</h5>
                                        <p class="company-name mb-2">${application.companyName}</p>
                                    </div>
                                    <span class="status-badge status-${application.status}">
                                        <c:choose>
                                            <c:when test="${application.status eq 'PENDING'}">Under Review</c:when>
                                            <c:when test="${application.status eq 'ACCEPTED'}">Accepted</c:when>
                                            <c:when test="${application.status eq 'REJECTED'}">Not Selected</c:when>
                                            <c:otherwise>${application.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="application-meta text-muted">
                                    <small>Applied on: <fmt:formatDate value="${application.appliedDate}" pattern="MMM dd, yyyy"/></small>
                                </div>
                                <c:if test="${application.status eq 'ACCEPTED'}">
                                    <div class="mt-3 alert alert-success">
                                        <i class="bi bi-check-circle-fill"></i> Congratulations! Your application has been accepted.
                                        The employer will contact you soon with next steps.
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Available Jobs</h3>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty availableJobs}">
                            <p class="text-muted">No jobs available at the moment.</p>
                        </c:if>
                        
                        <c:forEach var="job" items="${availableJobs}">
                            <div class="job-card mb-3 p-3 border rounded">
                                <h4>${job.title}</h4>
                                <p class="text-muted">
                                    ${job.department} | ${job.type} | ${job.location}
                                </p>
                                <p class="mb-2">${job.description}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="text-primary">Salary: ${job.salary}</span>
                                    <a href="${pageContext.request.contextPath}/jobs/apply?id=${job.id}" 
                                       class="btn btn-primary">Apply Now</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Quick Stats</h3>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-3">
                            <span>Applications Submitted:</span>
                            <span class="badge bg-primary">${applicationCount}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span>Pending Applications:</span>
                            <span class="badge bg-warning text-dark">${pendingCount}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span>Accepted Applications:</span>
                            <span class="badge bg-success">${acceptedCount}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-3">
                            <span>Profile Completion:</span>
                            <span class="badge bg-info">85%</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 