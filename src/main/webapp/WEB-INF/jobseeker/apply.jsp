<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>JobConnect - Apply for Job</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <style>
                .apply-main {
                    max-width: 700px;
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
                .card-header {
                    margin-bottom: 1.5rem;
                }
                .card-title {
                    font-size: 1.5rem;
                    font-weight: 700;
                    color: var(--primary-color);
                }
                .job-details {
                    background: #f3f4f6;
                    border-radius: 0.75rem;
                    padding: 1rem 1.5rem;
                    margin-bottom: 1.5rem;
                }
                .form-label {
                    font-weight: 500;
                    margin-bottom: 0.5rem;
                    display: block;
                }
                .form-control, textarea {
                    width: 100%;
                    padding: 0.75rem 1rem;
                    border-radius: 0.5rem;
                    border: 1px solid #e5e7eb;
                    font-size: 1rem;
                    margin-bottom: 1rem;
                }
                .button-primary {
                    background: var(--primary-color);
                    color: #fff;
                    border: none;
                    border-radius: 0.5rem;
                    padding: 0.75rem 1.5rem;
                    font-size: 1rem;
                    font-weight: 600;
                    cursor: pointer;
                    margin-right: 0.5rem;
                }
                .button-secondary {
                    background: #e5e7eb;
                    color: var(--text-color);
                    border: none;
                    border-radius: 0.5rem;
                    padding: 0.75rem 1.5rem;
                    font-size: 1rem;
                    font-weight: 600;
                    cursor: pointer;
                }
                .alert-danger {
                    background: #ffeaea;
                    color: #e11d48;
                    border-radius: 0.5rem;
                    padding: 1rem 1.5rem;
                    margin-bottom: 1rem;
                }
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
                        <li><a class="nav-link" href="${pageContext.request.contextPath}/applications">My Applications</a></li>
                        <li><a class="nav-link" style="color: #ef4444;" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                    </ul>
                </div>
            </nav>
            <div class="apply-main">
                <div class="card">
                    <div class="card-header">
                        <h2 class="card-title">Apply for: ${job.title}</h2>
                    </div>
                    <div class="card-body">
                        <div class="job-details mb-4">
                            <h4 style="margin-bottom:0.5rem;">Job Details</h4>
                            <p><strong>Department:</strong> ${job.department}</p>
                            <p><strong>Type:</strong> ${job.type}</p>
                            <p><strong>Location:</strong> ${job.location}</p>
                            <p><strong>Salary:</strong> ${job.salary}</p>
                            <p><strong>Description:</strong> ${job.description}</p>
                        </div>
                        <c:if test="${not empty error}">
                            <div class="alert-danger">${error}</div>
                        </c:if>
                        <form action="${pageContext.request.contextPath}/jobs/apply" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="jobId" value="${param.id}">
                            <div>
                                <label for="resume" class="form-label">Resume (PDF, DOC, DOCX)</label>
                                <input type="file" class="form-control" id="resume" name="resume" accept=".pdf,.doc,.docx" required>
                            </div>
                            <div>
                                <label for="coverLetter" class="form-label">Cover Letter</label>
                                <textarea class="form-control" id="coverLetter" name="coverLetter" rows="6" required placeholder="Write a brief cover letter explaining why you're a good fit for this position..."></textarea>
                            </div>
                            <div style="display:flex;gap:1rem;">
                                <button type="submit" class="button-primary">Submit Application</button>
                                <a href="${pageContext.request.contextPath}/dashboard" class="button-secondary" style="text-align:center;line-height:2.2rem;">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </body>

        </html>