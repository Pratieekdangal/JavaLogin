<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employer Dashboard - JobConnect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .dashboard-container {
            max-width: 1200px;
            margin: 2rem auto;
        }
        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .action-card {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            text-align: center;
        }
        .action-card i {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #0d6efd;
        }
        .job-list {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .welcome-section {
            background: linear-gradient(135deg, #0d6efd, #0099ff);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body class="bg-light">
    <%@ include file="../includes/header.jsp" %>

    <div class="dashboard-container container">
        <div class="welcome-section">
            <h2>Welcome, ${user.name}!</h2>
            <p class="mb-0">Manage your company profile and job postings from your dashboard</p>
        </div>

        <div class="row">
            <!-- Quick Actions -->
            <div class="col-md-4">
                <c:choose>
                    <c:when test="${empty company}">
                        <div class="action-card">
                            <i class="bi bi-building"></i>
                            <h4>Register Your Company</h4>
                            <p>Start by registering your company to post jobs</p>
                            <a href="${pageContext.request.contextPath}/employer/register-company" 
                               class="btn btn-primary">Register Company</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="action-card">
                            <i class="bi bi-plus-circle"></i>
                            <h4>Post a New Job</h4>
                            <p>Create a new job posting</p>
                            <a href="${pageContext.request.contextPath}/employer/post-job" 
                               class="btn btn-primary">Post Job</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Company Profile -->
            <div class="col-md-8">
                <c:if test="${not empty company}">
                    <div class="stats-card">
                        <h4>Company Profile</h4>
                        <hr>
                        <div class="row">
                            <div class="col-md-6">
                                <p><strong>Company Name:</strong> ${company.name}</p>
                                <p><strong>Industry:</strong> ${company.industry}</p>
                                <p><strong>Size:</strong> ${company.size}</p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Location:</strong> ${company.address}</p>
                                <c:if test="${not empty company.website}">
                                    <p><strong>Website:</strong> <a href="${company.website}" target="_blank">${company.website}</a></p>
                                </c:if>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/employer/edit-company" 
                           class="btn btn-outline-primary">Edit Profile</a>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Active Job Postings -->
        <div class="job-list mt-4">
            <h4>Active Job Postings</h4>
            <hr>
            <c:choose>
                <c:when test="${empty jobPostings}">
                    <p class="text-center text-muted">No active job postings. Start by posting a new job.</p>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Job Title</th>
                                    <th>Department</th>
                                    <th>Type</th>
                                    <th>Posted Date</th>
                                    <th>Applications</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${jobPostings}" var="job">
                                    <tr>
                                        <td>${job.title}</td>
                                        <td>${job.department}</td>
                                        <td>${job.type}</td>
                                        <td>${job.postedDate}</td>
                                        <td><a href="${pageContext.request.contextPath}/employer/applications?jobId=${job.id}">${job.applicationCount} applications</a></td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="${pageContext.request.contextPath}/employer/edit-job?id=${job.id}" 
                                                   class="btn btn-sm btn-outline-primary">Edit</a>
                                                <button type="button" class="btn btn-sm btn-outline-danger" 
                                                        onclick="deleteJob(${job.id})">Delete</button>
                                            </div>
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

    <%@ include file="../includes/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function deleteJob(jobId) {
            if (confirm('Are you sure you want to delete this job posting?')) {
                window.location.href = '${pageContext.request.contextPath}/employer/delete-job?id=' + jobId;
            }
        }
    </script>
</body>
</html> 