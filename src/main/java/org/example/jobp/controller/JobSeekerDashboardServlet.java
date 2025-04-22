package org.example.jobp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.jobp.dao.JobDAO;
import org.example.jobp.dao.ApplicationDAO;
import org.example.jobp.model.Job;
import org.example.jobp.model.User;
import org.example.jobp.model.Application;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/dashboard")
public class JobSeekerDashboardServlet extends HttpServlet {
  private static final Logger logger = Logger.getLogger(JobSeekerDashboardServlet.class.getName());
  private JobDAO jobDAO;
  private ApplicationDAO applicationDAO;

  @Override
  public void init() throws ServletException {
    try {
      jobDAO = new JobDAO();
      applicationDAO = new ApplicationDAO();
    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Failed to initialize DAOs", e);
      throw new ServletException("Failed to initialize DAOs", e);
    }
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    HttpSession session = request.getSession(false);

    if (session == null || session.getAttribute("user") == null) {
      logger.warning("Unauthorized access attempt to job seeker dashboard");
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    User user = (User) session.getAttribute("user");
    if (!"jobseeker".equals(user.getRole())) {
      logger.warning("Non-job seeker attempted to access job seeker dashboard: " + user.getEmail());
      response.sendRedirect(request.getContextPath() + "/employer/dashboard");
      return;
    }

    try {
      // Set user in request for JSP
      request.setAttribute("user", user);

      // Get available jobs
      List<Job> availableJobs = jobDAO.getActiveJobs();
      logger.info("Retrieved " + availableJobs.size() + " available jobs");
      request.setAttribute("availableJobs", availableJobs);

      // Get user's applications
      List<Application> applications = applicationDAO.getApplicationsByUserId(user.getId());
      request.setAttribute("applications", applications);

      // Calculate application statistics
      int totalApplications = applications.size();
      long pendingCount = applications.stream()
          .filter(app -> "PENDING".equals(app.getStatus()))
          .count();
      long acceptedCount = applications.stream()
          .filter(app -> "ACCEPTED".equals(app.getStatus()))
          .count();

      request.setAttribute("applicationCount", totalApplications);
      request.setAttribute("pendingCount", pendingCount);
      request.setAttribute("acceptedCount", acceptedCount);

      // Forward to the dashboard JSP
      request.getRequestDispatcher("/WEB-INF/jobseeker/dashboard.jsp").forward(request, response);
    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error loading dashboard", e);
      request.setAttribute("error", "Error loading dashboard: " + e.getMessage());
      request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
    }
  }
}