package org.example.jobp.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet(name = "LogoutServlet", value = "/logout")
public class LogoutServlet extends HttpServlet {
        private static final Logger logger = Logger.getLogger(LogoutServlet.class.getName());

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                HttpSession session = request.getSession(false);

                if (session != null) {
                        // Log the logout action
                        if (session.getAttribute("user") != null) {
                                logger.info("User logged out successfully");
                        }

                        // Invalidate the session
                        session.invalidate();
                }

                // Redirect to login page
                response.sendRedirect(request.getContextPath() + "/login");
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                doGet(request, response);
        }
}