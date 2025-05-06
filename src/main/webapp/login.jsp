<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login - JobConnect</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .main-wrapper {
            display: flex;
            width: 100%;
            max-width: 1200px;
            min-height: 600px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .info-panel {
            background: linear-gradient(135deg, #2563eb 60%, #1e40af 100%);
            color: #fff;
            width: 40%;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .info-content {
            max-width: 400px;
        }
        .info-panel h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }
        .info-panel p {
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 30px;
            color: #e0e7ff;
        }
        .form-panel {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .login-form {
            max-width: 400px;
            width: 100%;
        }
        .login-form h2 {
            font-size: 2rem;
            color: #1e40af;
            margin-bottom: 10px;
        }
        .subtitle {
            color: #666;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1.5px solid #e0e7ff;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.2s;
        }
        .form-group input:focus {
            outline: none;
            border-color: #2563eb;
        }
        .form-group input.error {
            border-color: #e11d48;
        }
        .error-message {
            color: #e11d48;
            font-size: 0.9rem;
            margin-top: 5px;
            display: none;
        }
        .error {
            background: #ffe4e6;
            color: #e11d48;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .error:before {
            content: "⚠️";
        }
        .success {
            background: #dcfce7;
            color: #15803d;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .success:before {
            content: "✓";
        }
        button[type="submit"] {
            width: 100%;
            padding: 14px;
            background: #2563eb;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        button[type="submit"]:hover {
            background: #1e40af;
        }
        .links {
            margin-top: 20px;
            text-align: center;
        }
        .links a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 500;
        }
        .links a:hover {
            text-decoration: underline;
        }
        @media (max-width: 768px) {
            .main-wrapper {
                flex-direction: column;
            }
            .info-panel {
                width: 100%;
                padding: 30px;
            }
            .form-panel {
                padding: 30px;
            }
        }
    </style>
</head>
<body>
    <div class="main-wrapper">
        <div class="info-panel">
            <div class="info-content">
                <h2>Welcome Back!</h2>
                <p>Sign in to access your JobConnect account and continue your job search or recruitment journey.</p>
            </div>
        </div>
        <div class="form-panel">
            <form class="login-form" action="${pageContext.request.contextPath}/login" method="post" autocomplete="off" onsubmit="return validateForm()">
                <h2>Login</h2>
                <div class="subtitle">Enter your credentials to continue</div>
                
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
                
                <% if (request.getParameter("message") != null) { %>
                    <div class="success">
                        <%= request.getParameter("message") %>
                    </div>
                <% } %>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="you@example.com" required autofocus>
                    <div class="error-message" id="email-error">Please enter a valid email address</div>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    <div class="error-message" id="password-error">Password is required</div>
                </div>

                <button type="submit">Login</button>

                <div class="links">
                    <p>Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a></p>
                    <p><a href="${pageContext.request.contextPath}/forgot-password">Forgot Password?</a></p>
                </div>
            </form>
        </div>
    </div>

    <script>
        function validateForm() {
            let isValid = true;
            const email = document.getElementById('email');
            const password = document.getElementById('password');
            const emailError = document.getElementById('email-error');
            const passwordError = document.getElementById('password-error');

            // Reset previous errors
            email.classList.remove('error');
            password.classList.remove('error');
            emailError.style.display = 'none';
            passwordError.style.display = 'none';

            // Email validation
            if (!email.value.trim()) {
                email.classList.add('error');
                emailError.textContent = 'Email is required';
                emailError.style.display = 'block';
                isValid = false;
            } else if (!/^[A-Za-z0-9+_.-]+@(.+)$/.test(email.value)) {
                email.classList.add('error');
                emailError.textContent = 'Please enter a valid email address';
                emailError.style.display = 'block';
                isValid = false;
            }

            // Password validation
            if (!password.value.trim()) {
                password.classList.add('error');
                passwordError.textContent = 'Password is required';
                passwordError.style.display = 'block';
                isValid = false;
            }

            return isValid;
        }

        // Clear error styling on input
        document.getElementById('email').addEventListener('input', function() {
            this.classList.remove('error');
            document.getElementById('email-error').style.display = 'none';
        });

        document.getElementById('password').addEventListener('input', function() {
            this.classList.remove('error');
            document.getElementById('password-error').style.display = 'none';
        });
    </script>
</body>
</html>