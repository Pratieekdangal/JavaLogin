package org.example.jobp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.jobp.dao.CompanyDAO;
import org.example.jobp.dao.JobDAO;
import org.example.jobp.model.Company;
import org.example.jobp.model.Job;
import org.example.jobp.model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/employer/jobs/edit")
public class EditJobServlet extends HttpServlet {
  private static final Logger LOGGER = Logger.getLogger(EditJobServlet.class.getName());
  private JobDAO jobDAO;
  private CompanyDAO companyDAO;

  @Override
  public void init() throws ServletException {
    try {
      jobDAO = new JobDAO();
      companyDAO = new CompanyDAO();
    } catch (SQLException e) {
      throw new ServletException("Error initializing DAOs", e);
    }
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");

    if (user == null || !"employer".equals(user.getRole())) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    try {
      // Get the company associated with the user
      Company company = companyDAO.getCompanyByUserId(user.getId());
      if (company == null) {
        response.sendRedirect(request.getContextPath() + "/employer/dashboard");
        return;
      }

      String jobIdStr = request.getParameter("id");
      if (jobIdStr == null || jobIdStr.trim().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/employer/dashboard");
        return;
      }

      try {
        int jobId = Integer.parseInt(jobIdStr);
        Job job = jobDAO.getJobById(jobId);

        if (job == null || job.getCompanyId() != company.getId()) {
          response.sendRedirect(request.getContextPath() + "/employer/dashboard");
          return;
        }

        request.setAttribute("job", job);
        request.getRequestDispatcher("/WEB-INF/employer/edit-job.jsp").forward(request, response);
      } catch (NumberFormatException e) {
        LOGGER.log(Level.WARNING, "Invalid job ID format", e);
        response.sendRedirect(request.getContextPath() + "/employer/dashboard");
      }
    } catch (SQLException e) {
      LOGGER.log(Level.SEVERE, "Database error", e);
      throw new ServletException("Database error", e);
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");

    if (user == null || !"employer".equals(user.getRole())) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    try {
      // Get the company associated with the user
      Company company = companyDAO.getCompanyByUserId(user.getId());
      if (company == null) {
        response.sendRedirect(request.getContextPath() + "/employer/dashboard");
        return;
      }

      String jobIdStr = request.getParameter("id");
      if (jobIdStr == null || jobIdStr.trim().isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/employer/dashboard");
        return;
      }

      try {
        int jobId = Integer.parseInt(jobIdStr);
        Job existingJob = jobDAO.getJobById(jobId);

        if (existingJob == null || existingJob.getCompanyId() != company.getId()) {
          response.sendRedirect(request.getContextPath() + "/employer/dashboard");
          return;
        }

        // Parse and validate the application deadline
        String deadlineStr = request.getParameter("applicationDeadline");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Timestamp applicationDeadline = new Timestamp(dateFormat.parse(deadlineStr).getTime());

        Job job = new Job();
        job.setId(jobId);
        job.setTitle(request.getParameter("title"));
        job.setDepartment(request.getParameter("department"));
        job.setType(request.getParameter("type"));
        job.setExperienceLevel(request.getParameter("experienceLevel"));
        job.setLocation(request.getParameter("location"));
        job.setSalary(request.getParameter("salary"));
        job.setDescription(request.getParameter("description"));
        job.setRequirements(request.getParameter("requirements"));
        job.setBenefits(request.getParameter("benefits"));
        job.setStatus(request.getParameter("status"));
        job.setCompanyId(company.getId());
        job.setApplicationDeadline(applicationDeadline);

        jobDAO.updateJob(job);
        response.sendRedirect(request.getContextPath() + "/view-job?id=" + jobId);
      } catch (NumberFormatException e) {
        LOGGER.log(Level.WARNING, "Invalid job ID format", e);
        response.sendRedirect(request.getContextPath() + "/employer/dashboard");
      } catch (ParseException e) {
        LOGGER.log(Level.WARNING, "Invalid date format", e);
        request.setAttribute("error", "Invalid date format");
        doGet(request, response);
      }
    } catch (SQLException e) {
      LOGGER.log(Level.SEVERE, "Database error", e);
      throw new ServletException("Database error", e);
    }
  }
}