<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Jobs - JobConnect</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .browse-main {
            max-width: 1100px;
            margin: 5.5rem auto 2rem auto;
            padding: 0 1.5rem;
        }
        .sort-form {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
        }
        .sort-form label {
            font-weight: 500;
            margin-right: 0.5rem;
        }
        .sort-form select {
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            border: 1px solid #e5e7eb;
            font-size: 1rem;
        }
        .jobs-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
        }
        @media (max-width: 900px) {
            .jobs-grid {
                grid-template-columns: 1fr;
            }
        }
        .job-card {
            background: var(--white);
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 1rem;
            padding: 1.5rem;
            box-shadow: var(--shadow-sm);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: box-shadow 0.2s;
        }
        .job-card:hover {
            box-shadow: var(--shadow-md);
        }
        .job-card-header {
            display: flex;
            flex-direction: column;
            margin-bottom: 1rem;
        }
        .job-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.3rem;
        }
        .company-name {
            color: var(--text-light);
            font-size: 1rem;
            margin-bottom: 0.5rem;
        }
        .job-meta {
            color: var(--text-light);
            font-size: 0.95rem;
            margin-bottom: 0.5rem;
        }
        .job-actions {
            margin-top: 1rem;
            display: flex;
            gap: 2.2rem;
        }
        .empty-state {
            text-align: center;
            color: var(--text-light);
            margin: 4rem 0;
        }
        .empty-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
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
    </style>
</head>
<body>
<!-- Top Navbar -->
<nav class="navbar">
    <div class="nav-container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">JobConnect</a>
        <ul class="nav-menu">
            <li><a class="nav-link" href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
            <li><a class="nav-link active" href="${pageContext.request.contextPath}/browse">Browse Jobs</a></li>
            <li><a class="nav-link" href="${pageContext.request.contextPath}/applications">My Applications</a></li>
            <li><a class="nav-link" style="color: #ef4444;" href="${pageContext.request.contextPath}/logout">Logout</a></li>
        </ul>
    </div>
</nav>
<div class="browse-main">
    <h1 style="font-size:2rem;font-weight:800;margin-bottom:1.5rem;">Browse Jobs</h1>
    <form class="sort-form" method="get" action="${pageContext.request.contextPath}/browse">
        <label for="sort">Sort by:</label>
        <select name="sort" id="sort" onchange="this.form.submit()">
            <option value="newest" ${sort == 'newest' ? 'selected' : ''}>Newest</option>
            <option value="oldest" ${sort == 'oldest' ? 'selected' : ''}>Oldest</option>
            <option value="relevant" ${sort == 'relevant' ? 'selected' : ''}>Most Relevant</option>
        </select>
    </form>
    <c:choose>
        <c:when test="${empty jobs}">
            <div class="empty-state">
                <div class="empty-icon">🔍</div>
                <div>No jobs found. Please check back later!</div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="jobs-grid">
                <c:forEach var="job" items="${jobs}">
                    <div class="job-card">
                        <div class="job-card-header">
                            <div class="job-title">${job.title}</div>
                            <div class="company-name">${job.companyName}</div>
                        </div>
                        <div class="job-meta">
                            📍 ${job.location} &nbsp;|&nbsp;
                            <fmt:formatDate value="${job.postedDate}" pattern="MMM dd, yyyy" />
                        </div>
                        <div class="job-actions">
                            <a href="${pageContext.request.contextPath}/view-job?id=${job.id}" class="button-view"><span class="icon">&#128065;</span>View Details</a>
                            <a href="${pageContext.request.contextPath}/jobs/apply?id=${job.id}" class="button-apply">Apply Now <span class="icon">&#8594;</span></a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html> 