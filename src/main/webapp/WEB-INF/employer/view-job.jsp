<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>${job.title} - JobConnect</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }

        .navbar {
            background-color: #2c3e50;
            padding: 1rem 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar-brand {
            color: white;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: bold;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: #3498db;
        }

        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .job-details {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
        }

        .job-header {
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }

        .job-title {
            font-size: 2rem;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }

        .job-meta {
            color: #666;
            font-size: 0.9rem;
        }

        .job-meta span {
            margin-right: 1rem;
        }

        .job-section {
            margin-bottom: 1.5rem;
        }

        .section-title {
            color: #2c3e50;
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }

        .job-description {
            white-space: pre-line;
        }

        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .status-active {
            background-color: #e8f5e9;
            color: #2e7d32;
        }

        .status-inactive {
            background-color: #ffebee;
            color: #c62828;
        }

        .button-group {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
        }

        .button {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            font-size: 1rem;
            font-weight: 500;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
        }

        .button-primary {
            background-color: #3498db;
            color: white;
        }

        .button-primary:hover {
            background-color: #2980b9;
        }

        .button-secondary {
            background-color: #95a5a6;
            color: white;
        }

        .button-secondary:hover {
            background-color: #7f8c8d;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">JobConnect</a>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/employer/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/employer/post-job">Post Job</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="job-details">
            <div class="job-header">
                <h1 class="job-title">${job.title}</h1>
                <div class="job-meta">
                    <span>📍 ${job.location}</span>
                    <span>💼 ${job.type}</span>
                    <span>🏢 ${job.department}</span>
                    <span class="status-badge ${job.status == 'active' ? 'status-active' : 'status-inactive'}">
                        ${job.status}
                    </span>
                </div>
            </div>

            <div class="job-section">
                <h2 class="section-title">Experience Level</h2>
                <p>${job.experienceLevel}</p>
            </div>

            <div class="job-section">
                <h2 class="section-title">Salary</h2>
                <p>${job.salary}</p>
            </div>

            <div class="job-section">
                <h2 class="section-title">Description</h2>
                <div class="job-description">${job.description}</div>
            </div>

            <div class="job-section">
                <h2 class="section-title">Requirements</h2>
                <div class="job-description">${job.requirements}</div>
            </div>

            <div class="job-section">
                <h2 class="section-title">Benefits</h2>
                <div class="job-description">${job.benefits}</div>
            </div>

            <div class="job-section">
                <h2 class="section-title">Additional Information</h2>
                <p><strong>Posted Date:</strong> <fmt:formatDate value="${job.postedDate}" pattern="MMM dd, yyyy"/></p>
                <p><strong>Application Deadline:</strong> <fmt:formatDate value="${job.applicationDeadline}" pattern="MMM dd, yyyy"/></p>
            </div>

            <div class="button-group">
                <a href="${pageContext.request.contextPath}/edit-job?id=${job.id}" class="button button-primary">Edit Job</a>
                <a href="${pageContext.request.contextPath}/employer/dashboard" class="button button-secondary">Back to Dashboard</a>
            </div>
        </div>
    </div>
</body>
</html> 