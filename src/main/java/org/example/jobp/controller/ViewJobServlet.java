package org.example.jobp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.jobp.dao.JobDAO;
import org.example.jobp.dao.CompanyDAO;
import org.example.jobp.model.Job;
import org.example.jobp.model.Company;
import org.example.jobp.model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/view-job")
public class ViewJobServlet extends HttpServlet {
  private static final Logger logger = Logger.getLogger(ViewJobServlet.class.getName());
  private JobDAO jobDAO;
  private CompanyDAO companyDAO;

  @Override
  public void init() throws ServletException {
    try {
      jobDAO = new JobDAO();
      companyDAO = new CompanyDAO();
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
      response.sendRedirect(request.getContextPath() + "/login");
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

      if (job == null) {
        request.setAttribute("error", "Job not found");
        request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
        return;
      }

      Company company = companyDAO.getCompanyById(job.getCompanyId());
      if (company == null) {
        request.setAttribute("error", "Company information not found");
        request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
        return;
      }

      request.setAttribute("job", job);
      request.setAttribute("company", company);
      request.getRequestDispatcher("/WEB-INF/employer/view-job.jsp").forward(request, response);

    } catch (NumberFormatException e) {
      logger.warning("Invalid job ID format: " + jobIdStr);
      response.sendRedirect(request.getContextPath() + "/employer/dashboard");
    }
  }
}