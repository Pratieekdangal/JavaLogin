<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post a Job - JobConnect</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .navbar {
            background: #fff;
            padding: 14px 0;
            box-shadow: 0 2px 8px rgba(37,99,235,0.06);
            width: 100%;
        }
        .navbar-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 24px;
        }
        .navbar .navbar-brand {
            color: #2563eb;
            font-size: 1.4rem;
            text-decoration: none;
            margin-left: 0;
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        .navbar .brand-bold {
            font-weight: 700;
            color: #2563eb;
        }
        .nav-links {
            float: right;
            margin-right: 0;
            display: flex;
            align-items: center;
            gap: 32px;
        }
        .nav-links a {
            color: #2563eb;
            text-decoration: none;
            margin-left: 0;
            font-weight: 500;
            font-size: 1rem;
            transition: color 0.2s;
        }
        .nav-links a:hover {
            color: #1e40af;
        }
        .main-wrapper {
            display: flex;
            min-height: 90vh;
        }
        .info-panel {
            background: linear-gradient(135deg, #2563eb 60%, #1e40af 100%);
            color: #fff;
            width: 38%;
            min-width: 260px;
            max-width: 400px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-end;
            padding: 0 36px;
        }
        .info-content {
            max-width: 320px;
            margin: 0 0 0 auto;
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
        .checklist {
            list-style: none;
            padding: 0;
            margin: 0 0 0 0;
        }
        .checklist li {
            margin-bottom: 16px;
            font-size: 1rem;
            display: flex;
            align-items: center;
        }
        .checkmark {
            color: #38d9a9;
            font-size: 1.2em;
            margin-right: 10px;
        }
        .form-panel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f4f4f4;
        }
        .job-form {
            width: 100%;
            max-width: 520px;
            background: #fff;
            padding: 36px 32px 28px 32px;
            border-radius: 16px;
            box-shadow: 0 4px 32px rgba(0,0,0,0.10);
            animation: fadeIn 0.7s;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .job-form h2 {
            text-align: center;
            margin-bottom: 8px;
            color: #222;
            font-size: 2rem;
        }
        .job-form .subtitle {
            text-align: center;
            color: #666;
            font-size: 1.05rem;
            margin-bottom: 26px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 7px;
            font-weight: 500;
            color: #222;
        }
        input[type="text"],
        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 11px 13px;
            border: 1.5px solid #d1d5db;
            border-radius: 7px;
            font-size: 1rem;
            background: #f9fafb;
            transition: border-color 0.2s, box-shadow 0.2s;
            margin-bottom: 2px;
        }
        input[type="text"]:focus,
        input[type="date"]:focus,
        select:focus,
        textarea:focus {
            border-color: #2563eb;
            outline: none;
            background: #fff;
            box-shadow: 0 0 0 2px #2563eb33;
        }
        textarea {
            resize: vertical;
            min-height: 80px;
        }
        .row {
            display: flex;
            gap: 18px;
        }
        .row .col-half {
            flex: 1;
        }
        .error-message, .alert-danger {
            color: #e11d48;
            background: #fef2f2;
            border: 1px solid #fecaca;
            padding: 10px 14px;
            border-radius: 6px;
            margin-bottom: 18px;
            text-align: center;
            font-size: 0.98em;
        }
        .btn-main {
            width: 100%;
            background: linear-gradient(90deg, #2563eb 60%, #60a5fa 100%);
            color: #fff;
            padding: 13px 0;
            border: none;
            border-radius: 7px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 8px;
            transition: background 0.2s;
        }
        .btn-main:hover {
            background: linear-gradient(90deg, #1e40af 60%, #2563eb 100%);
        }
        .btn-secondary {
            width: 100%;
            background: #fff;
            color: #2563eb;
            border: 1.5px solid #2563eb;
            padding: 13px 0;
            border-radius: 7px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 8px;
            transition: background 0.2s, color 0.2s;
        }
        .btn-secondary:hover {
            background: #2563eb;
            color: #fff;
        }
        @media (max-width: 1000px) {
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
            .form-panel {
                padding: 0 0 32px 0;
            }
        }
        @media (max-width: 700px) {
            .navbar-content {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
                padding: 0 8px;
            }
            .nav-links {
                gap: 16px;
            }
            .job-form {
                padding: 18px 6px 14px 6px;
            }
            .row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="navbar-content">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/"><span class="brand-bold">Job</span>Connect</a>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/employer/post-job">Post a Job</a>
                <a href="${pageContext.request.contextPath}/employer/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
    </nav>
    <div class="main-wrapper">
        <div class="info-panel">
            <div class="info-content">
                <h2>Post a Job</h2>
                <p>Reach top talent and grow your team with JobConnect. Easily create a job post and connect with thousands of qualified candidates.</p>
                <ul class="checklist">
                    <li><span class="checkmark">&#10003;</span> Attract skilled professionals</li>
                    <li><span class="checkmark">&#10003;</span> Manage applications efficiently</li>
                    <li><span class="checkmark">&#10003;</span> Promote your company brand</li>
                </ul>
            </div>
        </div>
        <div class="form-panel">
            <form class="job-form" action="${pageContext.request.contextPath}/employer/post-job" method="POST" autocomplete="off">
                <h2>Post a New Job</h2>
                <div class="subtitle">Fill in the details to create your job listing</div>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
                <div class="form-group">
                    <label for="title">Job Title<span style="color:#e11d48">*</span></label>
                    <input type="text" id="title" name="title" required placeholder="e.g., Software Engineer">
                </div>
                <div class="row">
                    <div class="form-group col-half">
                        <label for="department">Department</label>
                        <input type="text" id="department" name="department" placeholder="e.g., Engineering">
                    </div>
                    <div class="form-group col-half">
                        <label for="type">Employment Type<span style="color:#e11d48">*</span></label>
                        <select id="type" name="type" required>
                            <option value="">Select Type</option>
                            <option value="Full-time">Full-time</option>
                            <option value="Part-time">Part-time</option>
                            <option value="Contract">Contract</option>
                            <option value="Internship">Internship</option>
                            <option value="Remote">Remote</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-half">
                        <label for="experienceLevel">Experience Level<span style="color:#e11d48">*</span></label>
                        <select id="experienceLevel" name="experienceLevel" required>
                            <option value="">Select Level</option>
                            <option value="Entry Level">Entry Level</option>
                            <option value="Mid Level">Mid Level</option>
                            <option value="Senior Level">Senior Level</option>
                            <option value="Executive">Executive</option>
                        </select>
                    </div>
                    <div class="form-group col-half">
                        <label for="location">Location<span style="color:#e11d48">*</span></label>
                        <input type="text" id="location" name="location" required placeholder="e.g., New York, Remote">
                    </div>
                </div>
                <div class="form-group">
                    <label for="salary">Salary Range</label>
                    <input type="text" id="salary" name="salary" placeholder="e.g., $50,000 - $70,000 per year">
                </div>
                <div class="form-group">
                    <label for="description">Job Description<span style="color:#e11d48">*</span></label>
                    <textarea id="description" name="description" rows="4" required placeholder="Describe the job responsibilities, team, and expectations..."></textarea>
                </div>
                <div class="form-group">
                    <label for="requirements">Requirements</label>
                    <textarea id="requirements" name="requirements" rows="3" placeholder="e.g., 3+ years experience, Java, SQL, teamwork..."></textarea>
                </div>
                <div class="form-group">
                    <label for="benefits">Benefits</label>
                    <textarea id="benefits" name="benefits" rows="3" placeholder="e.g., Health insurance, Remote work, Stock options..."></textarea>
                </div>
                <div class="form-group">
                    <label for="applicationDeadline">Application Deadline</label>
                    <input type="date" id="applicationDeadline" name="applicationDeadline">
                </div>
                <div class="row" style="gap:12px; margin-top:18px;">
                    <div class="col-half">
                        <button type="submit" class="btn-main">Post Job</button>
                    </div>
                    <div class="col-half">
                        <a href="${pageContext.request.contextPath}/employer/dashboard" class="btn-secondary" style="display:block;text-align:center;text-decoration:none;">Cancel</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</body>
</html> 