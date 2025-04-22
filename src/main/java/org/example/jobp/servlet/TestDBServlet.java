package org.example.jobp.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.jobp.util.DBUtil;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/test-db")
public class TestDBServlet extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    out.println("<html><body>");
    out.println("<h2>Database Connection Test</h2>");

    try {
      Connection conn = DBUtil.getConnection();
      out.println("<p style='color: green;'>Database connection successful!</p>");
      out.println("<p>Database: " + conn.getCatalog() + "</p>");
      out.println("<p>URL: " + conn.getMetaData().getURL() + "</p>");
      out.println("<p>Database Product: " + conn.getMetaData().getDatabaseProductName() + "</p>");
      out.println("<p>Database Version: " + conn.getMetaData().getDatabaseProductVersion() + "</p>");
      conn.close();
    } catch (Exception e) {
      out.println("<p style='color: red;'>Error connecting to database:</p>");
      out.println("<p>" + e.getMessage() + "</p>");
      e.printStackTrace();
    }

    out.println("</body></html>");
  }
}