package org.example.jobp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.jobp.dao.ApplicationDAO;
import org.example.jobp.dao.JobDAO;
import org.example.jobp.model.Application;
import org.example.jobp.model.Job;
import org.example.jobp.model.User;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/jobs/apply")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10, // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class JobApplyServlet extends HttpServlet {
  private static final Logger logger = Logger.getLogger(JobApplyServlet.class.getName());
  private ApplicationDAO applicationDAO;
  private JobDAO jobDAO;

  @Override
  public void init() throws ServletException {
    try {
      applicationDAO = new ApplicationDAO();
      jobDAO = new JobDAO();
      logger.info("JobApplyServlet initialized successfully");
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
      logger.warning("User not logged in, redirecting to login");
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    User user = (User) session.getAttribute("user");
    if (!"jobseeker".equals(user.getRole())) {
      logger.warning("Non-jobseeker user attempted to access application form: " + user.getEmail());
      response.sendRedirect(request.getContextPath() + "/dashboard");
      return;
    }

    String jobId = request.getParameter("id");
    if (jobId == null || jobId.trim().isEmpty()) {
      logger.warning("Job ID is missing in the request");
      request.setAttribute("error", "Job ID is required");
      request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
      return;
    }

    try {
      logger.info("Fetching job details for ID: " + jobId);
      Job job = jobDAO.getJobById(Integer.parseInt(jobId));
      if (job == null) {
        logger.warning("No job found with ID: " + jobId);
        request.setAttribute("error", "Job not found");
        request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
        return;
      }
      request.setAttribute("job", job);
      logger.info("Forwarding to application form for job: " + job.getTitle());
      request.getRequestDispatcher("/WEB-INF/jobseeker/apply.jsp").forward(request, response);
    } catch (NumberFormatException e) {
      logger.warning("Invalid job ID format: " + jobId);
      request.setAttribute("error", "Invalid job ID format");
      request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
    } catch (Exception e) {
      logger.severe("Error loading job application form: " + e.getMessage());
      e.printStackTrace();
      request.setAttribute("error", "Error loading job application form: " + e.getMessage());
      request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
    }
  }

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("user") == null) {
      logger.warning("User not logged in during form submission");
      response.sendRedirect(request.getContextPath() + "/login");
      return;
    }

    User user = (User) session.getAttribute("user");
    if (!"jobseeker".equals(user.getRole())) {
      logger.warning("Non-jobseeker attempted to submit application: " + user.getEmail());
      response.sendRedirect(request.getContextPath() + "/dashboard");
      return;
    }

    String jobIdStr = request.getParameter("jobId");
    if (jobIdStr == null || jobIdStr.trim().isEmpty()) {
      logger.warning("Job ID is missing in the form submission");
      request.setAttribute("error", "Job ID is required");
      request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
      return;
    }

    try {
      int jobId = Integer.parseInt(jobIdStr);
      logger.info("Processing application for job ID: " + jobId);

      Job job = jobDAO.getJobById(jobId);
      if (job == null) {
        logger.warning("No job found with ID: " + jobId);
        request.setAttribute("error", "Job not found");
        request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
        return;
      }

      // Handle resume file upload
      Part filePart = request.getPart("resume");
      if (filePart == null || filePart.getSize() == 0) {
        logger.warning("No resume file uploaded");
        request.setAttribute("error", "Please upload your resume");
        request.setAttribute("job", job);
        request.getRequestDispatcher("/WEB-INF/jobseeker/apply.jsp").forward(request, response);
        return;
      }

      String fileName = getSubmittedFileName(filePart);
      if (fileName == null || !isValidFileType(fileName)) {
        logger.warning("Invalid resume file type: " + fileName);
        request.setAttribute("error", "Please upload a PDF, DOC, or DOCX file");
        request.setAttribute("job", job);
        request.getRequestDispatcher("/WEB-INF/jobseeker/apply.jsp").forward(request, response);
        return;
      }

      String uploadPath = getServletContext().getRealPath("/uploads/resumes");
      File uploadDir = new File(uploadPath);
      if (!uploadDir.exists()) {
        logger.info("Creating upload directory: " + uploadPath);
        if (!uploadDir.mkdirs()) {
          logger.severe("Failed to create upload directory: " + uploadPath);
          throw new IOException("Failed to create upload directory");
        }
      }

      String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
      String filePath = uploadPath + File.separator + uniqueFileName;
      logger.info("Saving resume to: " + filePath);
      filePart.write(filePath);

      // Create application
      Application application = new Application();
      application.setJobId(jobId);
      application.setUserId(user.getId());
      application.setResumePath("/uploads/resumes/" + uniqueFileName);
      application.setCoverLetter(request.getParameter("coverLetter"));
      application.setStatus("PENDING");

      logger.info("Creating application record in database");
      applicationDAO.createApplication(application);

      logger.info("Application submitted successfully");
      session.setAttribute("success", "Application submitted successfully!");
      response.sendRedirect(request.getContextPath() + "/applications");

    } catch (NumberFormatException e) {
      logger.warning("Invalid job ID format: " + jobIdStr);
      request.setAttribute("error", "Invalid job ID format");
      request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
    } catch (Exception e) {
      logger.severe("Error processing job application: " + e.getMessage());
      e.printStackTrace();
      request.setAttribute("error", "Failed to submit application: " + e.getMessage());
      request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
    }
  }

  private String getSubmittedFileName(Part part) {
    for (String cd : part.getHeader("content-disposition").split(";")) {
      if (cd.trim().startsWith("filename")) {
        String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
        return fileName.isEmpty() ? null : fileName;
      }
    }
    return null;
  }

  private boolean isValidFileType(String fileName) {
    if (fileName == null)
      return false;
    String lowerFileName = fileName.toLowerCase();
    return lowerFileName.endsWith(".pdf") ||
        lowerFileName.endsWith(".doc") ||
        lowerFileName.endsWith(".docx");
  }
}