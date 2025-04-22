<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>JobConnect - Apply for Job</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
                                <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/profile">My Profile</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/applications">My
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
                <div class="row justify-content-center">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <h2 class="card-title">Apply for: ${job.title}</h2>
                            </div>
                            <div class="card-body">
                                <div class="job-details mb-4">
                                    <h4>Job Details</h4>
                                    <p><strong>Department:</strong> ${job.department}</p>
                                    <p><strong>Type:</strong> ${job.type}</p>
                                    <p><strong>Location:</strong> ${job.location}</p>
                                    <p><strong>Salary:</strong> ${job.salary}</p>
                                    <p><strong>Description:</strong> ${job.description}</p>
                                </div>

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger" role="alert">
                                        ${error}
                                    </div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/jobs/apply" method="post"
                                    enctype="multipart/form-data">
                                    <input type="hidden" name="jobId" value="${param.id}">

                                    <div class="mb-3">
                                        <label for="resume" class="form-label">Resume (PDF, DOC, DOCX)</label>
                                        <input type="file" class="form-control" id="resume" name="resume"
                                            accept=".pdf,.doc,.docx" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="coverLetter" class="form-label">Cover Letter</label>
                                        <textarea class="form-control" id="coverLetter" name="coverLetter" rows="6"
                                            required
                                            placeholder="Write a brief cover letter explaining why you're a good fit for this position..."></textarea>
                                    </div>

                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-primary">Submit Application</button>
                                        <a href="${pageContext.request.contextPath}/dashboard"
                                            class="btn btn-secondary">Cancel</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>