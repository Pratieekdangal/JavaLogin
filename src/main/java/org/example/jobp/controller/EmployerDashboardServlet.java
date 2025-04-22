package org.example.jobp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.jobp.dao.JobDAO;
import org.example.jobp.dao.CompanyDAO;
import org.example.jobp.dao.ApplicationDAO;
import org.example.jobp.model.Job;
import org.example.jobp.model.User;
import org.example.jobp.model.Company;
import org.example.jobp.model.Application;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/employer/dashboard")
public class EmployerDashboardServlet extends HttpServlet {
  private static final Logger logger = Logger.getLogger(EmployerDashboardServlet.class.getName());
  private JobDAO jobDAO;
  private CompanyDAO companyDAO;
  private ApplicationDAO applicationDAO;

  @Override
  public void init() throws ServletException {
    super.init();
    try {
      jobDAO = new JobDAO();
      companyDAO = new CompanyDAO();
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
      logger.warning("Unauthorized access attempt to employer dashboard");
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    User user = (User) session.getAttribute("user");
    if (!"recruiter".equals(user.getRole())) {
      logger.warning("Non-recruiter attempted to access employer dashboard: " + user.getEmail());
      response.sendRedirect(request.getContextPath() + "/dashboard");
      return;
    }

    try {
      // Get company information
      Company company = companyDAO.getCompanyByUserId(user.getId());
      if (company == null) {
        // If no company is registered, redirect to company registration
        response.sendRedirect(request.getContextPath() + "/employer/register-company");
        return;
      }

      // Get posted jobs
      List<Job> postedJobs = jobDAO.getJobsByRecruiter(user.getId());

      // Get applications for all jobs
      List<Application> applications = applicationDAO.getApplicationsByCompanyId(company.getId());

      // Group applications by job
      Map<Integer, List<Application>> applicationsByJob = applications.stream()
          .collect(Collectors.groupingBy(Application::getJobId));

      // Get company statistics
      int totalJobPostings = postedJobs.size();
      int activeJobPostings = (int) postedJobs.stream()
          .filter(job -> "ACTIVE".equals(job.getStatus()))
          .count();
      int totalApplications = applications.size();
      int pendingApplications = (int) applications.stream()
          .filter(app -> "PENDING".equals(app.getStatus()))
          .count();

      // Set attributes for the JSP
      request.setAttribute("company", company);
      request.setAttribute("postedJobs", postedJobs);
      request.setAttribute("applicationsByJob", applicationsByJob);
      request.setAttribute("totalJobPostings", totalJobPostings);
      request.setAttribute("activeJobPostings", activeJobPostings);
      request.setAttribute("totalApplications", totalApplications);
      request.setAttribute("pendingApplications", pendingApplications);

      request.getRequestDispatcher("/WEB-INF/employer/dashboard.jsp").forward(request, response);
    } catch (Exception e) {
      logger.severe("Error loading employer dashboard: " + e.getMessage());
      request.setAttribute("error", "Error loading employer dashboard: " + e.getMessage());
      request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    response.setContentType("text/plain;charset=UTF-8");

    try {
      HttpSession session = request.getSession(false);
      if (session == null || session.getAttribute("user") == null) {
        logger.warning("Unauthorized access attempt to update application status");
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.getWriter().write("Please log in to continue");
        return;
      }

      User user = (User) session.getAttribute("user");
      if (!"recruiter".equals(user.getRole())) {
        logger.warning("Non-recruiter user attempted to update application status: " + user.getEmail());
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        response.getWriter().write("Access denied: Recruiter role required");
        return;
      }

      String action = request.getParameter("action");
      String applicationId = request.getParameter("applicationId");
      String status = request.getParameter("status");

      logger.info("Received status update request - Action: " + action +
          ", ApplicationId: " + applicationId +
          ", Status: " + status +
          ", User: " + user.getEmail());

      if (!"updateStatus".equals(action)) {
        logger.warning("Invalid action received: " + action);
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("Invalid action specified");
        return;
      }

      if (applicationId == null || applicationId.trim().isEmpty()) {
        logger.warning("Application ID is missing or empty");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("Application ID is required");
        return;
      }

      if (status == null || status.trim().isEmpty()) {
        logger.warning("Status is missing or empty");
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("Status is required");
        return;
      }

      int appId;
      try {
        appId = Integer.parseInt(applicationId.trim());
      } catch (NumberFormatException e) {
        logger.warning("Invalid application ID format: " + applicationId);
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("Invalid application ID format");
        return;
      }

      // Validate status value
      if (!status.equals("ACCEPTED") && !status.equals("REJECTED")) {
        logger.warning("Invalid status value received: " + status);
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.getWriter().write("Invalid status value: must be ACCEPTED or REJECTED");
        return;
      }

      // Verify application exists
      Application application = applicationDAO.getApplicationById(appId);
      if (application == null) {
        logger.warning("Application not found with ID: " + appId);
        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        response.getWriter().write("Application not found");
        return;
      }

      // Get company information
      Company company = companyDAO.getCompanyByUserId(user.getId());
      if (company == null) {
        logger.warning("Company not found for user: " + user.getEmail());
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        response.getWriter().write("Company information not found");
        return;
      }

      // Verify the application belongs to a job from this company
      Job job = jobDAO.getJobById(application.getJobId());
      if (job == null || job.getCompanyId() != company.getId()) {
        logger.warning("Unauthorized attempt to update application for different company. " +
            "User: " + user.getEmail() + ", Application: " + appId);
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        response.getWriter().write("Not authorized to update this application");
        return;
      }

      // Update the status
      logger.info("Updating application " + appId + " to status: " + status);
      applicationDAO.updateApplicationStatus(appId, status);
      logger.info("Successfully updated application " + appId + " status to " + status);

      response.setStatus(HttpServletResponse.SC_OK);
      response.getWriter().write("Application status updated successfully");

    } catch (SQLException e) {
      logger.severe("Database error while updating application status: " + e.getMessage());
      response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      response.getWriter().write("Database error occurred: " + e.getMessage());
    } catch (Exception e) {
      logger.severe("Unexpected error updating application status: " + e.getMessage());
      e.printStackTrace();
      response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      response.getWriter().write("An unexpected error occurred: " + e.getMessage());
    }
  }
}