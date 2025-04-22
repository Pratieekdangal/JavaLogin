<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobConnect - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background-color: rgba(44, 62, 80, 0.95) !important;
        }

        .login-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 15px;
        }

        .login-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            padding: 40px;
        }

        .form-title {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 30px;
            text-align: center;
        }

        .welcome-text {
            text-align: center;
            color: #7f8c8d;
            margin-bottom: 30px;
            font-size: 1.1rem;
        }

        .form-control {
            border-radius: 8px;
            padding: 12px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .form-floating {
            margin-bottom: 20px;
        }

        .btn-login {
            background-color: #3498db;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
            width: 100%;
            margin-top: 20px;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }

        .forgot-password {
            text-align: right;
            margin-top: 10px;
        }

        .forgot-password a {
            color: #7f8c8d;
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        .forgot-password a:hover {
            color: #3498db;
        }

        .register-link {
            text-align: center;
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
            color: #7f8c8d;
        }

        .register-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .social-login {
            margin-top: 25px;
            text-align: center;
        }

        .social-login .divider {
            display: flex;
            align-items: center;
            margin: 15px 0;
        }

        .social-login .divider::before,
        .social-login .divider::after {
            content: "";
            flex: 1;
            border-bottom: 1px solid #e9ecef;
        }

        .social-login .divider span {
            padding: 0 10px;
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        .social-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
        }

        .btn-social {
            flex: 1;
            max-width: 120px;
            padding: 8px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            background: white;
            color: #2c3e50;
            transition: all 0.3s ease;
        }

        .btn-social:hover {
            background: #f8f9fa;
            transform: translateY(-2px);
        }

        .btn-social i {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">JobConnect</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/browse">Browse Jobs</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/register">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="login-container">
        <div class="login-card">
            <h2 class="form-title">Welcome Back</h2>
            <p class="welcome-text">Sign in to access your account</p>
            
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-floating">
                    <input type="email" class="form-control" id="email" name="email" placeholder="Email address" required>
                    <label for="email">Email address</label>
                </div>

                <div class="form-floating">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                    <label for="password">Password</label>
                </div>

                <div class="forgot-password">
                    <a href="${pageContext.request.contextPath}/forgot-password">Forgot Password?</a>
                </div>

                <button type="submit" class="btn btn-primary btn-login">Sign In</button>
            </form>

            <div class="social-login">
                <div class="divider">
                    <span>or continue with</span>
                </div>
                <div class="social-buttons">
                    <button class="btn btn-social">
                        <i class="fab fa-google"></i>
                        Google
                    </button>
                    <button class="btn btn-social">
                        <i class="fab fa-linkedin"></i>
                        LinkedIn
                    </button>
                </div>
            </div>

            <div class="register-link">
                Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 