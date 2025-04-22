<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobConnect - Your Gateway to Career Opportunities</title>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a class="navbar-brand" href="#">JobConnect</a>
            <button class="menu-toggle">☰</button>
            <ul class="nav-menu">
                <li><a class="nav-link" href="#features">Features</a></li>
                <li><a class="nav-link" href="${pageContext.request.contextPath}/browse">Browse Jobs</a></li>
                <li><a class="nav-link" href="${pageContext.request.contextPath}/register">Register</a></li>
                <li><a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a></li>
            </ul>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <h1 class="hero-title">Find Your Dream Job Today</h1>
            <p class="hero-subtitle">Connect with top employers and discover exciting career opportunities</p>
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/register?type=jobseeker" class="button button-primary">
                    Find Jobs
                </a>
                <a href="${pageContext.request.contextPath}/register?type=employer" class="button button-outline">
                    Post Jobs
                </a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features" id="features">
        <h2 class="section-title">Why Choose JobConnect?</h2>
        <div class="features-grid">
            <div class="feature-card">
                <h4>Easy Job Search</h4>
                <p>Find relevant job opportunities matching your skills and experience.</p>
            </div>
            <div class="feature-card">
                <h4>Top Employers</h4>
                <p>Connect with leading companies looking for talented professionals.</p>
            </div>
            <div class="feature-card">
                <h4>Career Growth</h4>
                <p>Take your career to the next level with exciting opportunities.</p>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="features">
        <div class="container text-center">
            <h2 class="section-title">Ready to Start Your Journey?</h2>
            <p class="mb-4">Join thousands of professionals who have found their dream jobs through JobConnect</p>
            <a href="${pageContext.request.contextPath}/register" class="button button-primary">
                Get Started Now
            </a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="footer-content">
            <div>
                <h5>JobConnect</h5>
                <p>Your Gateway to Career Opportunities</p>
            </div>
            <div class="footer-links">
                <a href="#" class="footer-link">About</a>
                <a href="#" class="footer-link">Contact</a>
                <a href="#" class="footer-link">Privacy Policy</a>
            </div>
        </div>
    </footer>

    <script>
        document.querySelector('.menu-toggle').addEventListener('click', function() {
            document.querySelector('.nav-menu').classList.toggle('active');
        });
    </script>
</body>
</html>