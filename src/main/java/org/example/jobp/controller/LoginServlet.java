package org.example.jobp.controller;

import org.example.jobp.dao.UserDAO;
import org.example.jobp.model.User;
import org.example.jobp.util.PasswordHasher;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;

public class LoginServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(LoginServlet.class.getName());
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            // User is already logged in, redirect based on role
            User user = (User) session.getAttribute("user");
            redirectBasedOnRole(response, user, request.getContextPath());
            return;
        }
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = userDAO.getUserByEmail(email);
            if (user != null && PasswordHasher.verifyPassword(password, user.getPassword())) {
                // Login successful
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                logger.info("User logged in successfully: " + email);

                // Redirect based on user role
                redirectBasedOnRole(response, user, request.getContextPath());
            } else {
                // Login failed
                logger.warning("Login failed for email: " + email);
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            logger.severe("Error during login: " + e.getMessage());
            request.setAttribute("error", "An error occurred during login");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void redirectBasedOnRole(HttpServletResponse response, User user, String contextPath)
            throws IOException {
        switch (user.getRole()) {
            case "recruiter":
                response.sendRedirect(contextPath + "/employer/dashboard");
                break;
            case "admin":
                response.sendRedirect(contextPath + "/admin/dashboard");
                break;
            default:
                response.sendRedirect(contextPath + "/dashboard");
                break;
        }
    }
}