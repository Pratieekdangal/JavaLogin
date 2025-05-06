package org.example.jobp.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.jobp.dao.JobDAO;
import org.example.jobp.model.Job;
import org.example.jobp.model.User;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/browse")
public class BrowseJobsServlet extends HttpServlet {
  private JobDAO jobDAO;

  @Override
  public void init() throws ServletException {
    try {
      jobDAO = new JobDAO();
    } catch (SQLException e) {
      throw new ServletException("Failed to initialize JobDAO", e);
    }
  }

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    User user = (session != null) ? (User) session.getAttribute("user") : null;

    String sort = request.getParameter("sort");
    if (sort == null)
      sort = "newest";
    List<Job> jobs;
    try {
      // TODO: Implement sorting by 'oldest' and 'relevant' if needed
      jobs = jobDAO.getActiveJobs();
    } catch (Exception e) {
      request.setAttribute("error", "Error loading jobs: " + e.getMessage());
      request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
      return;
    }
    request.setAttribute("jobs", jobs);
    request.setAttribute("sort", sort);
    request.getRequestDispatcher("/WEB-INF/jobseeker/browse.jsp").forward(request, response);
  }
}