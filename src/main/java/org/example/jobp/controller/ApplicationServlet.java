package org.example.jobp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.jobp.dao.ApplicationDAO;
import org.example.jobp.dao.JobDAO;
import org.example.jobp.model.Application;
import org.example.jobp.model.Job;
import org.example.jobp.model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/applications")
public class ApplicationServlet extends HttpServlet {
  private static final Logger logger = Logger.getLogger(ApplicationServlet.class.getName());
  private ApplicationDAO applicationDAO;
  private JobDAO jobDAO;

  @Override
  public void init() throws ServletException {
    try {
      applicationDAO = new ApplicationDAO();
      jobDAO = new JobDAO();
      logger.info("ApplicationServlet initialized successfully");
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
      logger.warning("Unauthorized access attempt to applications page");
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    User user = (User) session.getAttribute("user");
    try {
      List<Application> applications = applicationDAO.getApplicationsByUserId(user.getId());
      List<ApplicationDTO> applicationDTOs = new ArrayList<>();

      for (Application app : applications) {
        Job job = jobDAO.getJobById(app.getJobId());
        ApplicationDTO dto = new ApplicationDTO(app, job);
        applicationDTOs.add(dto);
      }

      request.setAttribute("applications", applicationDTOs);

      // Forward success message if present
      String successMessage = (String) session.getAttribute("success");
      if (successMessage != null) {
        request.setAttribute("success", successMessage);
        session.removeAttribute("success"); // Clear the message
      }

      request.getRequestDispatcher("/WEB-INF/jobseeker/applications.jsp").forward(request, response);
    } catch (Exception e) {
      logger.severe("Error loading applications: " + e.getMessage());
      request.setAttribute("error", "Error loading your applications: " + e.getMessage());
      request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
    }
  }

  // DTO class to combine Application and Job information
  public static class ApplicationDTO {
    private final Application application;
    private final Job job;

    public ApplicationDTO(Application application, Job job) {
      this.application = application;
      this.job = job;
    }

    public Application getApplication() {
      return application;
    }

    public Job getJob() {
      return job;
    }

    // Convenience methods for JSP
    public String getJobTitle() {
      return job != null ? job.getTitle() : "";
    }

    public String getJobDepartment() {
      return job != null ? job.getDepartment() : "";
    }

    public String getStatus() {
      return application != null ? application.getStatus() : "";
    }

    public java.sql.Timestamp getAppliedDate() {
      return application != null ? application.getAppliedDate() : null;
    }

    public int getJobId() {
      return job != null ? job.getId() : 0;
    }
  }
}