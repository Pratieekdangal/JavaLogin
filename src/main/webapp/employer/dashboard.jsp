<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employer Dashboard - JobConnect</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .main-wrapper {
            display: flex;
            min-height: 90vh;
        }
        .info-panel {
            background: linear-gradient(135deg, #2563eb 60%, #1e40af 100%);
            color: #fff;
            width: 32%;
            min-width: 240px;
            max-width: 340px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: flex-end;
            padding: 0 32px;
        }
        .info-content {
            max-width: 280px;
            margin: 40px 0 0 auto;
        }
        .info-panel h2 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 18px;
        }
        .info-panel p {
            font-size: 1.08rem;
            margin-bottom: 24px;
            color: #e0e7ff;
        }
        .quick-actions {
            margin-top: 32px;
        }
        .quick-action-btn {
            display: block;
            width: 100%;
            background: linear-gradient(90deg, #2563eb 60%, #60a5fa 100%);
            color: #fff;
            border: none;
            border-radius: 7px;
            font-size: 1.1rem;
            font-weight: 600;
            padding: 13px 0;
            margin-bottom: 18px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: background 0.2s;
        }
        .quick-action-btn:hover {
            background: linear-gradient(90deg, #1e40af 60%, #2563eb 100%);
        }
        .dashboard-panel {
            flex: 1;
            display: flex;
            flex-direction: column;
            padding: 40px 0 40px 0;
            max-width: 100vw;
        }
        .welcome-section {
            background: linear-gradient(135deg, #2563eb, #60a5fa);
            color: white;
            padding: 28px 32px 20px 32px;
            border-radius: 14px;
            margin-bottom: 32px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
        }
        .welcome-section h2 {
            margin: 0 0 8px 0;
            font-size: 1.7rem;
        }
        .welcome-section p {
            margin: 0;
            font-size: 1.08rem;
        }
        .card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            padding: 24px 28px 18px 28px;
            margin-bottom: 28px;
        }
        .card h4 {
            margin-top: 0;
            margin-bottom: 12px;
            color: #222;
        }
        .card hr {
            border: none;
            border-top: 1.5px solid #e0e7ff;
            margin: 10px 0 18px 0;
        }
        .company-profile-row {
            display: flex;
            gap: 32px;
        }
        .company-profile-col {
            flex: 1;
        }
        .edit-btn {
            display: inline-block;
            background: #fff;
            color: #2563eb;
            border: 1.5px solid #2563eb;
            border-radius: 7px;
            font-size: 1rem;
            font-weight: 500;
            padding: 8px 18px;
            margin-top: 10px;
            text-decoration: none;
            transition: background 0.2s, color 0.2s;
        }
        .edit-btn:hover {
            background: #2563eb;
            color: #fff;
        }
        .job-list {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            padding: 24px 28px 18px 28px;
        }
        .job-list h4 {
            margin-top: 0;
            margin-bottom: 12px;
            color: #222;
        }
        .job-list hr {
            border: none;
            border-top: 1.5px solid #e0e7ff;
            margin: 10px 0 18px 0;
        }
        .job-card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(270px, 1fr));
            gap: 32px;
        }
        .job-card {
            background: #fff;
            border: 1.5px solid #e0e7ff;
            border-radius: 14px;
            box-shadow: 0 2px 8px rgba(37,99,235,0.06);
            padding: 20px 18px 16px 18px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 170px;
            position: relative;
            transition: box-shadow 0.2s, border-color 0.2s;
        }
        .job-card:hover {
            box-shadow: 0 4px 16px rgba(37,99,235,0.13);
            border-color: #2563eb;
        }
        .job-card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 10px;
        }
        .job-title {
            font-weight: 700;
            font-size: 1.08rem;
            color: #222;
        }
        .status-badge {
            background: #f4f4f4;
            color: #888;
            font-size: 0.85rem;
            border-radius: 12px;
            padding: 3px 12px;
            font-weight: 500;
            margin-left: 8px;
            text-transform: capitalize;
        }
        .status-badge.active {
            background: #e0f7fa;
            color: #15803d;
        }
        .status-badge.closed {
            background: #ffe4e6;
            color: #e11d48;
        }
        .job-card-body {
            margin-top: 6px;
        }
        .job-meta {
            font-size: 0.97rem;
            color: #444;
            margin-bottom: 12px;
        }
        .job-actions {
            margin-top: 1rem;
            display: flex;
            gap: 1.2rem;
        }
        .button-view {
            background: #fff;
            color: #2563eb;
            border: 1.5px solid #d1d5db;
            border-radius: 0.6rem;
            padding: 0.6rem 1.5rem;
            font-size: 1.05rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: none;
            transition: border 0.16s, color 0.16s, background 0.16s, transform 0.16s;
            outline: none;
        }
        .button-view:hover {
            border: 1.5px solid #2563eb;
            color: #1746b3;
            background: #f3f6fd;
            transform: translateY(-1px) scale(1.03);
        }
        .button-apply {
            background: #22c55e;
            color: #fff;
            border: none;
            border-radius: 0.6rem;
            padding: 0.6rem 1.7rem;
            font-size: 1.05rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            box-shadow: 0 2px 8px rgba(34,197,94,0.10);
            transition: background 0.16s, transform 0.16s;
            outline: none;
        }
        .button-apply:hover {
            background: #15803d;
            transform: translateY(-1px) scale(1.03);
        }
        .button-view .icon, .button-apply .icon {
            font-size: 0.95em;
            display: inline-block;
            vertical-align: middle;
            margin-bottom: 1px;
        }
        .action-links {
            display: flex;
            gap: 18px;
            align-items: center;
        }
        .view-link {
            color: #6d28d9;
            font-weight: 500;
            text-decoration: none;
            font-size: 1rem;
        }
        .view-link:hover {
            text-decoration: underline;
        }
        .edit-link {
            color: #2563eb;
            font-weight: 500;
            text-decoration: none;
            font-size: 1rem;
        }
        .edit-link:hover {
            text-decoration: underline;
        }
        .btn-group {
            display: flex;
            gap: 8px;
        }
        .btn-sm {
            padding: 6px 14px;
            font-size: 0.98rem;
            border-radius: 6px;
            border: 1.5px solid #2563eb;
            background: #fff;
            color: #2563eb;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.2s, color 0.2s;
        }
        .btn-sm:hover {
            background: #2563eb;
            color: #fff;
        }
        .btn-sm.btn-outline-danger {
            border-color: #e11d48;
            color: #e11d48;
        }
        .btn-sm.btn-outline-danger:hover {
            background: #e11d48;
            color: #fff;
        }
        .text-muted {
            color: #888;
        }
        @media (max-width: 1100px) {
            .main-wrapper {
                flex-direction: column;
            }
            .info-panel {
                width: 100%;
                max-width: none;
                min-width: 0;
                align-items: center;
                padding: 36px 0 18px 0;
            }
            .info-content {
                margin: 0 auto;
            }
            .dashboard-panel {
                padding: 0 0 32px 0;
            }
        }
        @media (max-width: 700px) {
            .dashboard-panel, .job-list, .card, .welcome-section {
                padding: 12px 4px 8px 4px;
            }
            .main-wrapper {
                flex-direction: column;
            }
            .company-profile-row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</head>
<body>
    <c:choose>
        <c:when test="${param.deleted == '1'}">
            <div style="background:#e6ffed;color:#15803d;padding:16px 24px;border-radius:8px;margin:24px auto 0 auto;max-width:800px;font-weight:600;box-shadow:0 2px 8px rgba(21,128,61,0.08);text-align:center;">Job deleted successfully.</div>
        </c:when>
        <c:when test="${param.deleted == '0'}">
            <div style="background:#ffeaea;color:#e11d48;padding:16px 24px;border-radius:8px;margin:24px auto 0 auto;max-width:800px;font-weight:600;box-shadow:0 2px 8px rgba(225,29,72,0.08);text-align:center;">Failed to delete job. Please try again.</div>
        </c:when>
    </c:choose>
    <div class="main-wrapper">
        <div class="info-panel">
            <div class="info-content">
                <h2>Employer Dashboard</h2>
                <p>Welcome to your dashboard! Manage your company, post jobs, and review applications all in one place.</p>
                <ul class="checklist">
                    <li><span class="checkmark">&#10003;</span> Post and manage jobs easily</li>
                    <li><span class="checkmark">&#10003;</span> Track applications in real time</li>
                    <li><span class="checkmark">&#10003;</span> Edit your company profile</li>
                </ul>
                <div class="quick-actions">
                    <c:choose>
                        <c:when test="${empty company}">
                            <a href="${pageContext.request.contextPath}/employer/register-company" class="quick-action-btn">Register Company</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/employer/post-job" class="quick-action-btn">Post a New Job</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <div class="form-panel">
            <div class="dashboard-panel">
                <div class="welcome-section">
                    <h2>Welcome, ${user.name}!</h2>
                    <p>Manage your company profile and job postings from your dashboard</p>
                </div>
                <c:if test="${not empty company}">
                    <div class="card">
                        <h4>Company Profile</h4>
                        <hr>
                        <div class="company-profile-row">
                            <div class="company-profile-col">
                                <p><strong>Company Name:</strong> ${company.name}</p>
                                <p><strong>Industry:</strong> ${company.industry}</p>
                                <p><strong>Size:</strong> ${company.size}</p>
                            </div>
                            <div class="company-profile-col">
                                <p><strong>Location:</strong> ${company.address}</p>
                                <c:if test="${not empty company.website}">
                                    <p><strong>Website:</strong> <a href="${company.website}" target="_blank">${company.website}</a></p>
                                </c:if>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/employer/edit-company" class="edit-btn">Edit Profile</a>
                    </div>
                </c:if>
                <div class="job-list">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px;">
                        <h4 style="margin: 0;">Your Job Postings</h4>
                        <a href="${pageContext.request.contextPath}/employer/post-job" class="quick-action-btn" style="width:auto;min-width:140px;box-shadow:0 2px 6px rgba(37,99,235,0.08);font-size:1rem;padding:10px 24px;">Post New Job</a>
                    </div>
                    <hr>
                    <c:choose>
                        <c:when test="${empty jobPostings}">
                            <p class="text-center text-muted">No active job postings. Start by posting a new job.</p>
                        </c:when>
                        <c:otherwise>
                            <div class="job-card-grid">
                                <c:forEach items="${jobPostings}" var="job">
                                    <div class="job-card">
                                        <div class="job-card-header">
                                            <span class="job-title">${job.title}</span>
                                            <span class="status-badge <c:out value='${job.status}'/>">${job.status}</span>
                                        </div>
                                        <div class="job-card-body">
                                            <div class="job-meta">
                                                <span class="job-location">&#128205; ${job.location}</span><br>
                                                <span class="job-date">&#128197; Posted: ${job.postedDate}</span>
                                            </div>
                                            <div class="job-actions">
                                                <div class="action-links">
                                                    <a href="${pageContext.request.contextPath}/employer/applications?jobId=${job.id}" class="view-link">View</a>
                                                    <a href="${pageContext.request.contextPath}/employer/jobs/edit?id=${job.id}" class="edit-link">Edit</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 