<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User Registration</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }
        .navbar {
            background: #222;
            padding: 14px 0;
        }
        .navbar .navbar-brand {
            color: #fff;
            font-size: 1.4rem;
            text-decoration: none;
            margin-left: 32px;
            font-weight: 600;
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
        .register-form {
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
        .register-form h2 {
            text-align: center;
            margin-bottom: 8px;
            color: #222;
            font-size: 2rem;
        }
        .register-form .subtitle {
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
        input[type="email"],
        input[type="password"] {
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
        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #2563eb;
            outline: none;
            background: #fff;
            box-shadow: 0 0 0 2px #2563eb33;
        }
        .password-wrapper {
            position: relative;
        }
        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.1em;
            color: #888;
        }
        .role-group {
            display: flex;
            gap: 18px;
            margin-top: 6px;
        }
        .role-group label {
            display: flex;
            align-items: center;
            font-weight: 400;
            margin: 0;
            color: #444;
        }
        .role-group input[type="radio"] {
            margin-right: 6px;
        }
        button[type="submit"] {
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
        button[type="submit"]:hover {
            background: linear-gradient(90deg, #1e40af 60%, #2563eb 100%);
        }
        .error {
            color: #e11d48;
            background: #fef2f2;
            border: 1px solid #fecaca;
            padding: 10px 14px;
            border-radius: 6px;
            margin-bottom: 16px;
            text-align: center;
            font-size: 0.98em;
        }
        .success {
            color: #15803d;
            background: #dcfce7;
            border: 1px solid #bbf7d0;
            padding: 10px 14px;
            border-radius: 6px;
            margin-bottom: 16px;
            text-align: center;
            font-size: 0.98em;
        }
        .login-link {
            text-align: center;
            margin-top: 18px;
            font-size: 1em;
        }
        .login-link a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 500;
        }
        .login-link a:hover {
            text-decoration: underline;
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
            .register-form {
                padding: 18px 6px 14px 6px;
            }
            .main-wrapper {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="main-wrapper">
        <div class="info-panel">
            <div class="info-content">
                <h2>Create Your Account</h2>
                <p>Join JobConnect to find your dream job or hire top talent.</p>
                <ul class="checklist">
                    <li><span class="checkmark">&#10003;</span> Access to thousands of jobs</li>
                    <li><span class="checkmark">&#10003;</span> Connect with top employers</li>
                    <li><span class="checkmark">&#10003;</span> Create a professional profile</li>
                </ul>
            </div>
        </div>
        <div class="form-panel">
            <form class="register-form" action="register" method="post" autocomplete="off">
                <h2>Create Your Account</h2>
                <div class="subtitle">Enter your details to get started</div>
                <% if (request.getParameter("error") != null) { %>
                    <div class="error">
                        <%= request.getParameter("error") %>
                    </div>
                <% } else if (request.getParameter("message") != null) { %>
                    <div class="success">
                        <%= request.getParameter("message") %>
                    </div>
                <% } %>
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" placeholder="Enter your full name" required autofocus>
                </div>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="you@example.com" required>
                </div>
                <div class="form-group password-wrapper">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Create a password" required minlength="6">
                    <button type="button" class="toggle-password" onclick="togglePassword()" tabindex="-1" aria-label="Show or hide password">👁️</button>
                </div>
                <div class="form-group">
                    <label>Register as</label>
                    <div class="role-group">
                        <label><input type="radio" id="recruiter" name="role" value="recruiter" required> Recruiter</label>
                        <label><input type="radio" id="jobseeker" name="role" value="jobseeker"> Job Seeker</label>
                    </div>
                </div>
                <button type="submit">Register</button>
                <div class="login-link">
                    Already have an account? <a href="login.jsp">Login here</a>
                </div>
            </form>
        </div>
    </div>
    <script>
        function togglePassword() {
            var pwd = document.getElementById('password');
            if (pwd.type === 'password') {
                pwd.type = 'text';
            } else {
                pwd.type = 'password';
            }
        }
    </script>
</body>
</html>
