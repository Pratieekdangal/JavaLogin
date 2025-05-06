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
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                    <style>
                        .dashboard-main {
                            max-width: 1100px;
                            margin: 5.5rem auto 2rem auto;
                            padding: 0 1.5rem;
                        }
                        .welcome-title {
                            font-size: 2.2rem;
                            font-weight: 800;
                            margin-bottom: 1.5rem;
                            color: var(--text-color);
                        }
                        .card {
                            background: var(--white);
                            border-radius: 1rem;
                            box-shadow: var(--shadow-md);
                            padding: 2rem;
                            margin-bottom: 2rem;
                        }
                        .stats-grid {
                            display: grid;
                            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                            gap: 1.5rem;
                            margin-bottom: 2rem;
                        }
                        .stat-card {
                            background: var(--white);
                            border-radius: 1rem;
                            box-shadow: var(--shadow-sm);
                            padding: 1.5rem 1rem;
                            text-align: center;
                        }
                        .stat-value {
                            font-size: 2.2rem;
                            font-weight: 700;
                            color: var(--primary-color);
                        }
                        .stat-label {
                            color: var(--text-light);
                            font-size: 1.1rem;
                            margin-top: 0.5rem;
                        }
                        .profile-completion-card {
                            background: var(--white);
                            border-radius: 1rem;
                            box-shadow: var(--shadow-sm);
                            padding: 1.5rem 1rem;
                        }
                        .progress-bar-bg {
                            background: #e5e7eb;
                            border-radius: 8px;
                            height: 12px;
                            width: 100%;
                            margin-top: 0.5rem;
                        }
                        .progress-bar-fill {
                            background: var(--primary-color);
                            height: 100%;
                            border-radius: 8px;
                            transition: width 0.5s;
                        }
                        .recent-applications-card {
                            background: var(--white);
                            border-radius: 1rem;
                            box-shadow: var(--shadow-sm);
                            padding: 1.5rem 1rem;
                            margin-bottom: 2rem;
                        }
                        .empty-state {
                            text-align: center;
                            color: var(--text-light);
                            margin: 2rem 0;
                        }
                        .empty-icon {
                            font-size: 2.5rem;
                            color: var(--primary-color);
                            margin-bottom: 0.5rem;
                        }
                    </style>
                </head>

                <body>
                    <!-- Top Navbar -->
                    <nav class="navbar">
                        <div class="nav-container">
                            <a class="navbar-brand" href="${pageContext.request.contextPath}/">JobConnect</a>
                            <ul class="nav-menu">
                                <li><a class="nav-link${pageContext.request.requestURI.endsWith('/dashboard') ? ' active' : ''}" href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                                <li><a class="nav-link${pageContext.request.requestURI.endsWith('/browse') ? ' active' : ''}" href="${pageContext.request.contextPath}/browse">Browse Jobs</a></li>
                                <li><a class="nav-link${pageContext.request.requestURI.endsWith('/applications') ? ' active' : ''}" href="${pageContext.request.contextPath}/applications">My Applications</a></li>
                                <li><a class="nav-link" style="color: #ef4444;" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                            </ul>
                        </div>
                    </nav>
                    <div class="dashboard-main">
                        <div class="welcome-title">Welcome, ${user.name}!</div>
                        <div class="recent-applications-card" style="background: linear-gradient(90deg, #f0f4ff 0%, #f8fafc 100%); border: none; border-radius: 1.5rem; box-shadow: 0 4px 16px rgba(37,99,235,0.08); padding: 2rem 1.5rem; margin-bottom: 2.5rem;">
                            <h3 style="margin-bottom: 1.3rem; font-size: 1.35rem; font-weight: 800; color: #2563eb; display: flex; align-items: center; gap: 0.7rem; letter-spacing: -1px;">
                                <span style="font-size: 1.6rem;">📋</span> Recent Applications
                            </h3>
                            <c:if test="${empty applications}">
                                <div class="empty-state">
                                    <div class="empty-icon">📄</div>
                                    <div>You haven't applied to any jobs yet.</div>
                                </div>
                            </c:if>
                            <c:forEach var="application" items="${applications}" varStatus="status">
                                <c:if test="${status.index lt 3}">
                                    <div class="application-card" style="display: flex; align-items: center; gap: 1.3rem; background: #fff; border-left: 6px solid ${application.status == 'PENDING' ? '#facc15' : application.status == 'ACCEPTED' ? '#4ade80' : application.status == 'REJECTED' ? '#f87171' : '#e5e7eb'}; border-radius: 1rem; box-shadow: 0 2px 8px rgba(37,99,235,0.06); margin-bottom: 1.1rem; padding: 1.1rem 1.3rem; transition: box-shadow 0.18s;">
                                        <div style="flex: 1;">
                                            <div style="font-size: 1.18rem; font-weight: 700; color: #222; display: flex; align-items: center; gap: 0.5rem;">
                                                <span style="font-size: 1.25rem; color: #2563eb;">💼</span> ${application.jobTitle}
                                            </div>
                                            <div style="margin: 0.2rem 0 0.5rem 0;">
                                                <span style="background: #e0e7ff; color: #2563eb; font-size: 0.98rem; font-weight: 600; border-radius: 1rem; padding: 0.18rem 0.9rem; margin-right: 0.5rem;">${application.companyName}</span>
                                            </div>
                                            <div style="font-size: 0.97rem; color: #64748b;">
                                                <span style="font-size:1.1rem;">📅</span> <fmt:formatDate value="${application.appliedDate}" pattern="MMM dd, yyyy" />
                                            </div>
                                        </div>
                                        <span class="status-badge status-${application.status}" title="${application.status}" style="padding: 0.45rem 1.2rem; border-radius: 1.2rem; font-size: 1.05rem; font-weight: 700; background: ${application.status == 'PENDING' ? '#facc15' : application.status == 'ACCEPTED' ? '#4ade80' : application.status == 'REJECTED' ? '#f87171' : '#e5e7eb'}; color: ${application.status == 'PENDING' ? '#92400e' : application.status == 'ACCEPTED' ? '#166534' : application.status == 'REJECTED' ? '#991b1b' : '#374151'}; min-width: 90px; text-align: center; box-shadow: 0 1px 4px rgba(37,99,235,0.04);">
                                            ${application.status}
                                        </span>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <div class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-label">Applications Submitted</div>
                                <div class="stat-value">${applicationCount}</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Pending Applications</div>
                                <div class="stat-value">${pendingCount}</div>
                            </div>
                            <div class="stat-card">
                                <div class="stat-label">Accepted Applications</div>
                                <div class="stat-value">${acceptedCount}</div>
                            </div>
                        </div>
                        <div class="profile-completion-card">
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <span style="font-weight: 500;">Profile Completion</span>
                                <span style="font-weight: 700; color: var(--primary-color);">${profileCompletion}%</span>
                            </div>
                            <div class="progress-bar-bg">
                                <div class="progress-bar-fill" style="width: ${profileCompletion}%;"></div>
                            </div>
                        </div>
                    </div>
                </body>

                </html>