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
import org.example.jobp.model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/employer/jobs/delete")
public class DeleteJobServlet extends HttpServlet {
  private static final Logger LOGGER = Logger.getLogger(DeleteJobServlet.class.getName());
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
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("text/plain");
    PrintWriter out = response.getWriter();
    HttpSession session = request.getSession(false);
    User user = (session != null) ? (User) session.getAttribute("user") : null;

    if (user == null || !"recruiter".equals(user.getRole())) {
      response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
      out.print("Unauthorized");
      return;
    }

    try {
      Company company = companyDAO.getCompanyByUserId(user.getId());
      if (company == null) {
        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
        out.print("No company found");
        return;
      }

      String jobIdStr = request.getParameter("id");
      if (jobIdStr == null || jobIdStr.trim().isEmpty()) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        out.print("Missing job ID");
        return;
      }

      int jobId = Integer.parseInt(jobIdStr);
      boolean deleted = jobDAO.deleteJob(jobId, company.getId());
      if (deleted) {
        response.sendRedirect(request.getContextPath() + "/employer/dashboard?deleted=1");
      } else {
        response.sendRedirect(request.getContextPath() + "/employer/dashboard?deleted=0");
      }
    } catch (Exception e) {
      LOGGER.log(Level.SEVERE, "Error deleting job", e);
      response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
      out.print("Error deleting job");
    }
  }
}