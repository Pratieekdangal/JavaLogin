<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobConnect - Registration</title>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="register-page">
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">JobConnect</a>
            <button class="menu-toggle">☰</button>
            <ul class="nav-menu">
                <li><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
                <li><a class="nav-link" href="${pageContext.request.contextPath}/browse">Browse Jobs</a></li>
                <li><a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a></li>
            </ul>
        </div>
    </nav>

    <div class="register-container">
        <div class="register-content">
            <div class="register-header">
                <h1 class="register-title">Create Your Account</h1>
                <p class="register-subtitle">Join thousands of professionals in finding their dream career</p>
            </div>

            <div class="register-form-container">
                <form action="${pageContext.request.contextPath}/register" method="post" class="register-form">
                    <div class="form-group">
                        <label class="form-label" for="fullName">Full Name</label>
                        <div class="input-group">
                            <span class="input-icon">👤</span>
                            <input type="text" class="form-input with-icon" id="fullName" name="name" required 
                                placeholder="Enter your full name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="email">Email Address</label>
                        <div class="input-group">
                            <span class="input-icon">✉️</span>
                            <input type="email" class="form-input with-icon" id="email" name="email" required 
                                placeholder="Enter your email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="password">Password</label>
                        <div class="input-group">
                            <span class="input-icon">🔒</span>
                            <input type="password" class="form-input with-icon" id="password" name="password" required 
                                placeholder="Create a strong password">
                        </div>
                        <div class="password-strength-meter">
                            <div class="strength-bar"></div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">I want to</label>
                        <div class="role-options">
                            <label class="role-card ${param.type == 'jobseeker' ? 'selected' : ''}">
                                <input type="radio" name="role" value="jobseeker" ${param.type == 'jobseeker' ? 'checked' : ''}>
                                <div class="role-content">
                                    <div class="role-icon">🎯</div>
                                    <div class="role-info">
                                        <h3>Find a Job</h3>
                                        <p>Search and apply for jobs</p>
                                    </div>
                                </div>
                            </label>
                            <label class="role-card ${param.type == 'employer' ? 'selected' : ''}">
                                <input type="radio" name="role" value="recruiter" ${param.type == 'employer' ? 'checked' : ''}>
                                <div class="role-content">
                                    <div class="role-icon">🏢</div>
                                    <div class="role-info">
                                        <h3>Hire Talent</h3>
                                        <p>Post jobs and find talent</p>
                                    </div>
                                </div>
                            </label>
                        </div>
                    </div>

                    <button type="submit" class="button button-primary w-100">Create Account</button>
                </form>

                <div class="form-footer">
                    <p class="text-center">
                        Already have an account? <a href="${pageContext.request.contextPath}/login" class="form-link">Login here</a>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Toggle mobile menu
        document.querySelector('.menu-toggle').addEventListener('click', function() {
            document.querySelector('.nav-menu').classList.toggle('active');
        });

        // Role card selection
        document.querySelectorAll('.role-card').forEach(card => {
            card.addEventListener('click', function() {
                document.querySelectorAll('.role-card').forEach(c => c.classList.remove('selected'));
                this.classList.add('selected');
            });
        });

        // Simple password strength meter
        const passwordInput = document.getElementById('password');
        const strengthBar = document.querySelector('.strength-bar');

        passwordInput.addEventListener('input', function() {
            const strength = calculatePasswordStrength(this.value);
            updateStrengthBar(strength);
        });

        function calculatePasswordStrength(password) {
            let strength = 0;
            if (password.length >= 8) strength += 25;
            if (password.match(/[A-Z]/)) strength += 25;
            if (password.match(/[0-9]/)) strength += 25;
            if (password.match(/[^A-Za-z0-9]/)) strength += 25;
            return strength;
        }

        function updateStrengthBar(strength) {
            strengthBar.style.width = strength + '%';
            if (strength <= 25) {
                strengthBar.style.backgroundColor = '#ff4444';
            } else if (strength <= 50) {
                strengthBar.style.backgroundColor = '#ffbb33';
            } else if (strength <= 75) {
                strengthBar.style.backgroundColor = '#00C851';
            } else {
                strengthBar.style.backgroundColor = '#007E33';
            }
        }
    </script>
</body>
</html> 