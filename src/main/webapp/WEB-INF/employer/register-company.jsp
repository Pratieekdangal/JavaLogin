<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Company - JobConnect</title>
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

        .company-form {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: 500;
        }

        input, select, textarea {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52,152,219,0.2);
        }

        .row {
            display: flex;
            gap: 1rem;
        }

        .col {
            flex: 1;
        }

        .error-message {
            color: #e74c3c;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        .alert {
            padding: 1rem;
            border-radius: 4px;
            margin-bottom: 1rem;
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .btn {
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

        .btn-primary {
            background-color: #3498db;
            color: white;
            width: 100%;
            margin-bottom: 1rem;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        .btn-secondary {
            background-color: #95a5a6;
            color: white;
            width: 100%;
        }

        .btn-secondary:hover {
            background-color: #7f8c8d;
        }

        .required::after {
            content: '*';
            color: #e74c3c;
            margin-left: 4px;
        }

        footer {
            background-color: #2c3e50;
            color: white;
            text-align: center;
            padding: 1rem;
            margin-top: 3rem;
        }

        @media (max-width: 768px) {
            .row {
                flex-direction: column;
            }
            
            .company-form {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">JobConnect</a>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/employer/dashboard">Dashboard</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="company-form">
            <h2>Register Your Company</h2>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/employer/register-company" method="POST">
                <div class="form-group">
                    <label class="required" for="companyName">Company Name</label>
                    <input type="text" id="companyName" name="companyName" required>
                </div>

                <div class="form-group">
                    <label class="required" for="industry">Industry</label>
                    <select id="industry" name="industry" required>
                        <option value="">Select Industry</option>
                        <option value="Technology">Technology</option>
                        <option value="Healthcare">Healthcare</option>
                        <option value="Finance">Finance</option>
                        <option value="Education">Education</option>
                        <option value="Manufacturing">Manufacturing</option>
                        <option value="Retail">Retail</option>
                        <option value="Services">Services</option>
                        <option value="Construction">Construction</option>
                        <option value="Entertainment">Entertainment</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="companyWebsite">Company Website</label>
                    <input type="url" id="companyWebsite" name="companyWebsite" placeholder="https://example.com">
                </div>

                <div class="form-group">
                    <label class="required" for="companyAddress">Company Address</label>
                    <textarea id="companyAddress" name="companyAddress" rows="3" required></textarea>
                </div>

                <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <label class="required" for="companySize">Company Size</label>
                            <select id="companySize" name="companySize" required>
                                <option value="">Select Company Size</option>
                                <option value="1-10">1-10 employees</option>
                                <option value="11-50">11-50 employees</option>
                                <option value="51-200">51-200 employees</option>
                                <option value="201-500">201-500 employees</option>
                                <option value="501-1000">501-1000 employees</option>
                                <option value="1000+">1000+ employees</option>
                            </select>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label for="foundedYear">Founded Year</label>
                            <input type="number" id="foundedYear" name="foundedYear" min="1800" max="2024">
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label class="required" for="companyDescription">Company Description</label>
                    <textarea id="companyDescription" name="companyDescription" rows="4" required></textarea>
                </div>

                <button type="submit" class="btn btn-primary">Register Company</button>
                <a href="${pageContext.request.contextPath}/employer/dashboard" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 JobConnect. All rights reserved.</p>
    </footer>
</body>
</html> 