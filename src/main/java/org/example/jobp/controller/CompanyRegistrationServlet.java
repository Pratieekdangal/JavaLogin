package org.example.jobp.controller;

import org.example.jobp.dao.CompanyDAO;
import org.example.jobp.model.Company;
import org.example.jobp.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/employer/register-company")
public class CompanyRegistrationServlet extends HttpServlet {
  private static final Logger logger = Logger.getLogger(CompanyRegistrationServlet.class.getName());
  private CompanyDAO companyDAO;

  @Override
  public void init() throws ServletException {
    super.init();
    try {
      companyDAO = new CompanyDAO();
    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Failed to initialize CompanyDAO", e);
      throw new ServletException("Failed to initialize CompanyDAO", e);
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
      // Check if user already has a registered company
      Company existingCompany = companyDAO.getCompanyByUserId(user.getId());
      if (existingCompany != null) {
        response.sendRedirect(request.getContextPath() + "/employer/post-job");
        return;
      }

      request.getRequestDispatcher("/WEB-INF/employer/register-company.jsp").forward(request, response);
    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error checking existing company for user: " + user.getId(), e);
      request.setAttribute("error", "An error occurred while checking company registration. Please try again.");
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
      // Create company object from form data
      Company company = new Company();
      company.setName(request.getParameter("companyName"));
      company.setWebsite(request.getParameter("companyWebsite"));
      company.setAddress(request.getParameter("companyAddress"));
      company.setSize(request.getParameter("companySize"));
      company.setIndustry(request.getParameter("industry"));

      String foundedYearStr = request.getParameter("foundedYear");
      if (foundedYearStr != null && !foundedYearStr.trim().isEmpty()) {
        company.setFoundedYear(Integer.parseInt(foundedYearStr));
      }

      company.setDescription(request.getParameter("companyDescription"));
      company.setUserId(user.getId());

      // Validate required fields
      if (company.getName() == null || company.getName().trim().isEmpty() ||
          company.getAddress() == null || company.getAddress().trim().isEmpty() ||
          company.getSize() == null || company.getSize().trim().isEmpty() ||
          company.getDescription() == null || company.getDescription().trim().isEmpty() ||
          company.getIndustry() == null || company.getIndustry().trim().isEmpty()) {

        request.setAttribute("error", "Please fill in all required fields");
        request.getRequestDispatcher("/WEB-INF/employer/register-company.jsp").forward(request, response);
        return;
      }

      // Register the company
      Company registeredCompany = companyDAO.createCompany(company);

      if (registeredCompany != null) {
        // Store company in session for future use
        session.setAttribute("company", registeredCompany);
        response.sendRedirect(request.getContextPath() + "/employer/post-job");
      } else {
        request.setAttribute("error", "Failed to register company. Please try again.");
        request.getRequestDispatcher("/WEB-INF/employer/register-company.jsp").forward(request, response);
      }

    } catch (NumberFormatException e) {
      logger.warning("Invalid founded year format: " + e.getMessage());
      request.setAttribute("error", "Invalid founded year format");
      request.getRequestDispatcher("/WEB-INF/employer/register-company.jsp").forward(request, response);
    } catch (Exception e) {
      logger.severe("Error during company registration: " + e.getMessage());
      request.setAttribute("error", "An error occurred during registration. Please try again.");
      request.getRequestDispatcher("/WEB-INF/employer/register-company.jsp").forward(request, response);
    }
  }
}