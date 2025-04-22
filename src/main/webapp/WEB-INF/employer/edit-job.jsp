<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Job - JobConnect</title>
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

        .edit-form {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
        }

        .form-header {
            margin-bottom: 2rem;
        }

        .form-title {
            font-size: 2rem;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #3498db;
        }

        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }

        .form-row {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .form-row .form-group {
            flex: 1;
            margin-bottom: 0;
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

        .error-message {
            color: #e74c3c;
            font-size: 0.875rem;
            margin-top: 0.5rem;
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
        <form class="edit-form" action="${pageContext.request.contextPath}/employer/jobs/edit" method="post">
            <input type="hidden" name="id" value="${job.id}">
            
            <div class="form-header">
                <h1 class="form-title">Edit Job Posting</h1>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>

            <div class="form-group">
                <label class="form-label" for="title">Job Title</label>
                <input type="text" class="form-control" id="title" name="title" value="${job.title}" required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label" for="type">Job Type</label>
                    <select class="form-control" id="type" name="type" required>
                        <option value="Full-time" ${job.type == 'Full-time' ? 'selected' : ''}>Full-time</option>
                        <option value="Part-time" ${job.type == 'Part-time' ? 'selected' : ''}>Part-time</option>
                        <option value="Contract" ${job.type == 'Contract' ? 'selected' : ''}>Contract</option>
                        <option value="Internship" ${job.type == 'Internship' ? 'selected' : ''}>Internship</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label" for="department">Department</label>
                    <input type="text" class="form-control" id="department" name="department" value="${job.department}" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label" for="location">Location</label>
                    <input type="text" class="form-control" id="location" name="location" value="${job.location}" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="experienceLevel">Experience Level</label>
                    <select class="form-control" id="experienceLevel" name="experienceLevel" required>
                        <option value="Entry Level" ${job.experienceLevel == 'Entry Level' ? 'selected' : ''}>Entry Level</option>
                        <option value="Mid Level" ${job.experienceLevel == 'Mid Level' ? 'selected' : ''}>Mid Level</option>
                        <option value="Senior Level" ${job.experienceLevel == 'Senior Level' ? 'selected' : ''}>Senior Level</option>
                        <option value="Executive" ${job.experienceLevel == 'Executive' ? 'selected' : ''}>Executive</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="salary">Salary</label>
                <input type="text" class="form-control" id="salary" name="salary" value="${job.salary}" required>
            </div>

            <div class="form-group">
                <label class="form-label" for="description">Job Description</label>
                <textarea class="form-control" id="description" name="description" required>${job.description}</textarea>
            </div>

            <div class="form-group">
                <label class="form-label" for="requirements">Requirements</label>
                <textarea class="form-control" id="requirements" name="requirements" required>${job.requirements}</textarea>
            </div>

            <div class="form-group">
                <label class="form-label" for="benefits">Benefits</label>
                <textarea class="form-control" id="benefits" name="benefits" required>${job.benefits}</textarea>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label" for="applicationDeadline">Application Deadline</label>
                    <input type="datetime-local" class="form-control" id="applicationDeadline" name="applicationDeadline" 
                           value="<fmt:formatDate value="${job.applicationDeadline}" pattern="yyyy-MM-dd'T'HH:mm"/>" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="status">Status</label>
                    <select class="form-control" id="status" name="status" required>
                        <option value="active" ${job.status == 'active' ? 'selected' : ''}>Active</option>
                        <option value="inactive" ${job.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
            </div>

            <div class="button-group">
                <button type="submit" class="button button-primary">Save Changes</button>
                <a href="${pageContext.request.contextPath}/view-job?id=${job.id}" class="button button-secondary">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html> 