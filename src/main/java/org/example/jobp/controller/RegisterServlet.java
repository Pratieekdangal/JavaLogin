package org.example.jobp.controller;

import org.example.jobp.dao.UserDAO;
import org.example.jobp.model.User;
import org.example.jobp.util.PasswordHasher;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(RegisterServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set any pre-selected role from the query parameter
        String type = request.getParameter("type");
        if (type != null) {
            request.setAttribute("selectedRole", type);
        }
        // Forward to registration page
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.info("Processing registration request...");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        logger.info("Received registration data - Name: " + name + ", Email: " + email + ", Role: " + role);

        // Basic validation
        if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                role == null || role.trim().isEmpty()) {
            logger.warning("Validation failed: Empty fields detected");
            response.sendRedirect(
                    "register.jsp?error=" + java.net.URLEncoder.encode("All fields are required", "UTF-8"));
            return;
        }

        // Email format validation
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            logger.warning("Validation failed: Invalid email format - " + email);
            response.sendRedirect("register.jsp?error=" + java.net.URLEncoder.encode("Invalid email format", "UTF-8"));
            return;
        }

        // Password strength validation
        if (password.length() < 6) {
            logger.warning("Validation failed: Password too short");
            response.sendRedirect("register.jsp?error="
                    + java.net.URLEncoder.encode("Password must be at least 6 characters long", "UTF-8"));
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();

            // Check if email is already registered
            if (userDAO.isEmailTaken(email)) {
                logger.warning("Registration failed: Email already exists - " + email);
                response.sendRedirect(
                        "register.jsp?error=" + java.net.URLEncoder.encode("Email already registered", "UTF-8"));
                return;
            }

            // Create new user
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(PasswordHasher.hashPassword(password));
            user.setRole(role);

            logger.info("Attempting to register user: " + email);

            // Attempt to register
            boolean registered = userDAO.registerUser(user);

            if (registered) {
                logger.info("Registration successful for user: " + email);
                response.sendRedirect("login.jsp?message="
                        + java.net.URLEncoder.encode("Registration successful! Please login.", "UTF-8"));
            } else {
                logger.warning("Registration failed for user: " + email);
                response.sendRedirect("register.jsp?error="
                        + java.net.URLEncoder.encode("Registration failed. Please try again.", "UTF-8"));
            }

        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error during registration", e);
            response.sendRedirect("register.jsp?error="
                    + java.net.URLEncoder.encode("An error occurred: " + e.getMessage(), "UTF-8"));
        }
    }
}
