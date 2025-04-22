<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post a Job - JobConnect</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .job-form {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .form-label {
            font-weight: 500;
        }
        .error-message {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">JobConnect</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/employer/dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="job-form bg-white">
            <h2 class="text-center mb-4">Post a New Job</h2>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/employer/post-job" method="POST" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label for="title" class="form-label">Job Title*</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                    <div class="invalid-feedback">Please enter a job title</div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="department" class="form-label">Department</label>
                        <input type="text" class="form-control" id="department" name="department">
                    </div>
                    <div class="col-md-6">
                        <label for="type" class="form-label">Employment Type*</label>
                        <select class="form-select" id="type" name="type" required>
                            <option value="">Select Type</option>
                            <option value="Full-time">Full-time</option>
                            <option value="Part-time">Part-time</option>
                            <option value="Contract">Contract</option>
                            <option value="Internship">Internship</option>
                            <option value="Remote">Remote</option>
                        </select>
                        <div class="invalid-feedback">Please select employment type</div>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="experienceLevel" class="form-label">Experience Level*</label>
                        <select class="form-select" id="experienceLevel" name="experienceLevel" required>
                            <option value="">Select Level</option>
                            <option value="Entry Level">Entry Level</option>
                            <option value="Mid Level">Mid Level</option>
                            <option value="Senior Level">Senior Level</option>
                            <option value="Executive">Executive</option>
                        </select>
                        <div class="invalid-feedback">Please select experience level</div>
                    </div>
                    <div class="col-md-6">
                        <label for="location" class="form-label">Location*</label>
                        <input type="text" class="form-control" id="location" name="location" required>
                        <div class="invalid-feedback">Please enter job location</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="salary" class="form-label">Salary Range</label>
                    <input type="text" class="form-control" id="salary" name="salary" 
                           placeholder="e.g., $50,000 - $70,000 per year">
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Job Description*</label>
                    <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
                    <div class="invalid-feedback">Please enter job description</div>
                </div>

                <div class="mb-3">
                    <label for="requirements" class="form-label">Requirements</label>
                    <textarea class="form-control" id="requirements" name="requirements" rows="4"></textarea>
                </div>

                <div class="mb-3">
                    <label for="benefits" class="form-label">Benefits</label>
                    <textarea class="form-control" id="benefits" name="benefits" rows="4"></textarea>
                </div>

                <div class="mb-4">
                    <label for="applicationDeadline" class="form-label">Application Deadline</label>
                    <input type="date" class="form-control" id="applicationDeadline" name="applicationDeadline">
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">Post Job</button>
                    <a href="${pageContext.request.contextPath}/employer/dashboard" 
                       class="btn btn-outline-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>

    <footer class="bg-dark text-light py-3 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2024 JobConnect. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
    </script>
</body>
</html> 