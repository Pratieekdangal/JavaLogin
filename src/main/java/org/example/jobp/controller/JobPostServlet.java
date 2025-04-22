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
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/employer/post-job")
public class JobPostServlet extends HttpServlet {
  private static final Logger logger = Logger.getLogger(JobPostServlet.class.getName());
  private JobDAO jobDAO;
  private CompanyDAO companyDAO;

  @Override
  public void init() throws ServletException {
    super.init();
    try {
      jobDAO = new JobDAO();
      companyDAO = new CompanyDAO();
    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Failed to initialize JobDAO or CompanyDAO", e);
      throw new ServletException("Failed to initialize JobDAO or CompanyDAO", e);
    }
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");

    if (user == null || !"recruiter".equals(user.getRole())) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    try {
      // Check if the recruiter has a registered company
      Company company = companyDAO.getCompanyByUserId(user.getId());
      if (company == null) {
        response.sendRedirect(request.getContextPath() + "/employer/register-company");
        return;
      }

      request.getRequestDispatcher("/employer/post-job.jsp").forward(request, response);
    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error retrieving company for user: " + user.getId(), e);
      request.setAttribute("error", "An error occurred while retrieving company information. Please try again.");
      request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");

    if (user == null || !"recruiter".equals(user.getRole())) {
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    try {
      Company company = companyDAO.getCompanyByUserId(user.getId());
      if (company == null) {
        response.sendRedirect(request.getContextPath() + "/employer/register-company");
        return;
      }

      Job job = new Job();
      job.setTitle(request.getParameter("title"));
      job.setDepartment(request.getParameter("department"));
      job.setType(request.getParameter("type"));
      job.setExperienceLevel(request.getParameter("experienceLevel"));
      job.setLocation(request.getParameter("location"));
      job.setSalary(request.getParameter("salary"));
      job.setDescription(request.getParameter("description"));
      job.setRequirements(request.getParameter("requirements"));
      job.setBenefits(request.getParameter("benefits"));

      // Parse application deadline
      String deadlineStr = request.getParameter("applicationDeadline");
      if (deadlineStr != null && !deadlineStr.trim().isEmpty()) {
        job.setApplicationDeadline(Timestamp.valueOf(deadlineStr + " 23:59:59"));
      }

      job.setCompanyId(company.getId());
      job.setStatus("active");
      job.setPostedDate(new Timestamp(System.currentTimeMillis()));

      // Validate required fields
      if (job.getTitle() == null || job.getTitle().trim().isEmpty() ||
          job.getDescription() == null || job.getDescription().trim().isEmpty() ||
          job.getLocation() == null || job.getLocation().trim().isEmpty()) {

        request.setAttribute("error", "Please fill in all required fields");
        request.getRequestDispatcher("/employer/post-job.jsp").forward(request, response);
        return;
      }

      // Post the job
      Job postedJob = jobDAO.createJob(job);

      if (postedJob != null) {
        session.setAttribute("success", "Job posted successfully!");
        response.sendRedirect(request.getContextPath() + "/employer/dashboard");
      } else {
        request.setAttribute("error", "Failed to post job. Please try again.");
        request.getRequestDispatcher("/employer/post-job.jsp").forward(request, response);
      }

    } catch (IllegalArgumentException e) {
      logger.warning("Invalid date format: " + e.getMessage());
      request.setAttribute("error", "Invalid date format for application deadline");
      request.getRequestDispatcher("/employer/post-job.jsp").forward(request, response);
    } catch (Exception e) {
      logger.severe("Error during job posting: " + e.getMessage());
      request.setAttribute("error", "An error occurred while posting the job. Please try again.");
      request.getRequestDispatcher("/employer/post-job.jsp").forward(request, response);
    }
  }
}