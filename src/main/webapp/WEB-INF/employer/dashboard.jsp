<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employer Dashboard - JobConnect</title>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <style>
        .applications-section {
            margin-top: 2rem;
            background: white;
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .application-card {
            border: 1px solid #e0e0e0;
            border-radius: 6px;
            padding: 1rem;
            margin-bottom: 1rem;
            background: #fff;
        }

        .application-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
        }

        .application-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2c3e50;
        }

        .application-meta {
            font-size: 0.9rem;
            color: #666;
            margin: 0.5rem 0;
        }

        .application-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-accepted {
            background-color: #d4edda;
            color: #155724;
        }

        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
        }

        .btn-accept {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-reject {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-accept:hover {
            background-color: #218838;
        }

        .btn-reject:hover {
            background-color: #c82333;
        }

        .application-status {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 500;
        }
    </style>
</head>
<body class="dashboard-page">
    <nav class="navbar">
        <div class="nav-container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">JobConnect</a>
            <button class="menu-toggle">☰</button>
            <ul class="nav-menu">
                <li><a class="nav-link" href="${pageContext.request.contextPath}/post-job">Post a Job</a></li>
                <li><a class="nav-link active" href="${pageContext.request.contextPath}/employer/dashboard">Dashboard</a></li>
                <li><a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="dashboard-container">
        <div class="company-profile-section">
            <div class="company-header">
                <div class="company-info">
                    <c:if test="${not empty company.logoUrl}">
                        <img src="${company.logoUrl}" alt="${company.name} logo" class="company-logo">
                    </c:if>
                    <div class="company-details">
                        <h1>${company.name}</h1>
                        <p class="company-location">📍 ${company.location}</p>
                        <p class="company-industry">🏢 ${company.industry}</p>
                    </div>
                </div>
                <div class="company-actions">
                    <a href="${pageContext.request.contextPath}/edit-company" class="button button-outline">
                        Edit Company Profile
                    </a>
                </div>
            </div>

            <div class="company-description">
                <h3>About the Company</h3>
                <p>${company.description}</p>
            </div>

            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-value">${totalJobPostings}</div>
                    <div class="stat-label">Total Job Postings</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">${activeJobPostings}</div>
                    <div class="stat-label">Active Jobs</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">${totalApplications}</div>
                    <div class="stat-label">Total Applications</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">${pendingApplications}</div>
                    <div class="stat-label">Pending Applications</div>
                </div>
            </div>
        </div>

        <div class="jobs-section">
            <div class="section-header">
                <h2>Your Job Postings</h2>
                <a href="${pageContext.request.contextPath}/post-job" class="button button-primary">Post New Job</a>
            </div>
            
            <c:if test="${empty postedJobs}">
                <div class="empty-state">
                    <div class="empty-icon">📋</div>
                    <h3>No Jobs Posted Yet</h3>
                    <p>Start attracting talent by posting your first job opening.</p>
                    <a href="${pageContext.request.contextPath}/post-job" class="button button-primary">Post Your First Job</a>
                </div>
            </c:if>
            
            <c:if test="${not empty postedJobs}">
                <div class="jobs-grid">
                    <c:forEach var="job" items="${postedJobs}">
                        <div class="job-card">
                            <div class="job-card-header">
                                <h3 class="job-title">${job.title}</h3>
                                <span class="job-status ${job.status == 'ACTIVE' ? 'status-active' : 'status-inactive'}">
                                    ${job.status}
                                </span>
                            </div>
                            <div class="job-details">
                                <p class="job-location">📍 ${job.location}</p>
                                <p class="job-date">📅 Posted: ${job.postedDate}</p>
                            </div>
                            <div class="job-actions">
                                <a href="${pageContext.request.contextPath}/view-job?id=${job.id}" 
                                   class="button button-small">View</a>
                                <a href="${pageContext.request.contextPath}/edit-job?id=${job.id}" 
                                   class="button button-small button-outline">Edit</a>
                                <button onclick="deleteJob(${job.id})" 
                                        class="button button-small button-danger">Delete</button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <div class="applications-section">
            <div class="section-header">
                <h2>Job Applications</h2>
            </div>
            
            <c:if test="${empty applicationsByJob}">
                <div class="empty-state">
                    <div class="empty-icon">📝</div>
                    <h3>No Applications Yet</h3>
                    <p>When candidates apply to your jobs, they'll appear here.</p>
                </div>
            </c:if>
            
            <c:if test="${not empty applicationsByJob}">
                <c:forEach var="job" items="${postedJobs}">
                    <c:if test="${not empty applicationsByJob[job.id]}">
                        <div class="job-applications">
                            <h3>${job.title}</h3>
                            <div class="applications-list">
                                <c:forEach var="application" items="${applicationsByJob[job.id]}">
                                    <div class="application-card">
                                        <div class="application-header">
                                            <span class="application-title">Application from ${application.applicantName}</span>
                                            <span class="application-status status-${fn:toLowerCase(application.status)}">${application.status}</span>
                                        </div>
                                        <div class="application-meta">
                                            <p>📅 Applied: <fmt:formatDate value="${application.appliedDate}" pattern="MMM dd, yyyy"/></p>
                                            <p>📧 Email: ${application.applicantEmail}</p>
                                            <p>📎 Resume: <a href="${application.resumePath}" target="_blank">View Resume</a></p>
                                        </div>
                                        <div class="application-content">
                                            <p><strong>Cover Letter:</strong></p>
                                            <p>${application.coverLetter}</p>
                                        </div>
                                        <c:if test="${application.status eq 'PENDING'}">
                                            <div class="application-actions">
                                                <button type="button" 
                                                        class="btn-accept"
                                                        onclick="handleStatusUpdate(this, '${application.id}', 'ACCEPTED')">
                                                    Accept
                                                </button>
                                                <button type="button" 
                                                        class="btn-reject"
                                                        onclick="handleStatusUpdate(this, '${application.id}', 'REJECTED')">
                                                    Reject
                                                </button>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>
        </div>
    </div>

    <script>
        // Debug logging function
        function debug(message, data) {
            console.log(`[Debug] ${message}`, data || '');
        }

        // Mobile menu toggle
        document.querySelector('.menu-toggle').addEventListener('click', function() {
            document.querySelector('.nav-menu').classList.toggle('active');
        });

        function handleStatusUpdate(button, applicationId, status) {
            debug('Starting status update with params:', {
                applicationId: applicationId,
                status: status,
                buttonElement: button
            });
            
            if (!applicationId) {
                const error = 'Application ID is missing';
                debug('Error:', error);
                showError(button, error);
                return;
            }

            if (!confirm(`Are you sure you want to ${status.toLowerCase()} this application?`)) {
                debug('User cancelled the operation');
                return;
            }

            button.disabled = true;
            button.textContent = 'Processing...';

            // Encode parameters properly
            const params = new URLSearchParams();
            params.append('action', 'updateStatus');
            params.append('applicationId', applicationId);
            params.append('status', status);

            debug('Sending request with params:', params.toString());

            fetch('${pageContext.request.contextPath}/employer/dashboard', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params.toString()
            })
            .then(async response => {
                const text = await response.text();
                debug('Received response:', {
                    status: response.status,
                    text: text
                });
                
                if (!response.ok) {
                    throw new Error(text || `Server returned ${response.status}`);
                }
                
                showMessage(button, text || `Application ${status.toLowerCase()} successfully`, 'success');
                
                // Refresh the page after a short delay
                setTimeout(() => {
                    debug('Reloading page...');
                    window.location.reload();
                }, 1000);
            })
            .catch(error => {
                debug('Error occurred:', error.message);
                console.error('Error:', error);
                
                button.disabled = false;
                button.textContent = status === 'ACCEPTED' ? 'Accept' : 'Reject';
                
                showError(button, error.message || 'Error updating application status');
            });
        }

        function showMessage(button, message, type = 'success') {
            const messageDiv = document.createElement('div');
            messageDiv.className = `alert mt-2 alert-${type}`;
            messageDiv.textContent = message;
            
            // Remove any existing messages
            const existingMessage = button.parentElement.querySelector('.alert');
            if (existingMessage) {
                existingMessage.remove();
            }
            
            button.parentElement.appendChild(messageDiv);
        }

        function showError(button, message) {
            showMessage(button, message, 'danger');
        }

        // Job deletion confirmation
        function deleteJob(jobId) {
            if (confirm('Are you sure you want to delete this job posting?')) {
                fetch('${pageContext.request.contextPath}/delete-job?id=' + jobId, {
                    method: 'POST'
                }).then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        alert('Error deleting job posting');
                    }
                });
            }
        }

        // Log initial page load
        debug('Page loaded, application buttons initialized');
    </script>
</body>
</html> 