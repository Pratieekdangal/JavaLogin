package org.example.jobp.dao;

import org.example.jobp.model.Application;
import org.example.jobp.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ApplicationDAO {
  private static final Logger logger = Logger.getLogger(ApplicationDAO.class.getName());
  private final Connection connection;

  public ApplicationDAO() throws SQLException {
    this.connection = DBUtil.getConnection();
  }

  public Application createApplication(Application application) throws SQLException {
    String sql = "INSERT INTO applications (job_id, user_id, resume_path, cover_letter, applied_date, status) " +
        "VALUES (?, ?, ?, ?, ?, ?)";

    try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
      stmt.setInt(1, application.getJobId());
      stmt.setInt(2, application.getUserId());
      stmt.setString(3, application.getResumePath());
      stmt.setString(4, application.getCoverLetter());
      stmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
      stmt.setString(6, "PENDING");

      int affectedRows = stmt.executeUpdate();
      if (affectedRows == 0) {
        throw new SQLException("Creating application failed, no rows affected.");
      }

      try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
        if (generatedKeys.next()) {
          application.setId(generatedKeys.getInt(1));
          return application;
        } else {
          throw new SQLException("Creating application failed, no ID obtained.");
        }
      }
    }
  }

  public List<Application> getApplicationsByUserId(int userId) throws SQLException {
    List<Application> applications = new ArrayList<>();
    String sql = "SELECT a.*, j.title as job_title, c.name as company_name " +
        "FROM applications a " +
        "JOIN jobs j ON a.job_id = j.id " +
        "JOIN companies c ON j.company_id = c.id " +
        "WHERE a.user_id = ? " +
        "ORDER BY a.applied_date DESC";

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
      stmt.setInt(1, userId);
      try (ResultSet rs = stmt.executeQuery()) {
        while (rs.next()) {
          Application app = mapResultSetToApplication(rs);
          app.setJobTitle(rs.getString("job_title"));
          app.setCompanyName(rs.getString("company_name"));
          applications.add(app);
        }
      }
    }
    return applications;
  }

  public Application getApplicationById(int applicationId) throws SQLException {
    String sql = "SELECT * FROM applications WHERE id = ?";

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
      stmt.setInt(1, applicationId);
      ResultSet rs = stmt.executeQuery();

      if (rs.next()) {
        return mapResultSetToApplication(rs);
      }
    }

    return null;
  }

  public boolean updateApplicationStatus(int applicationId, String status) throws SQLException {
    String sql = "UPDATE applications SET status = ? WHERE id = ?";

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
      stmt.setString(1, status);
      stmt.setInt(2, applicationId);

      return stmt.executeUpdate() > 0;
    }
  }

  public List<Application> getApplicationsByCompanyId(int companyId) throws SQLException {
    List<Application> applications = new ArrayList<>();
    String sql = "SELECT a.*, u.name as applicant_name, u.email as applicant_email FROM applications a " +
        "JOIN jobs j ON a.job_id = j.id " +
        "JOIN users u ON a.user_id = u.id " +
        "WHERE j.company_id = ? " +
        "ORDER BY a.applied_date DESC";

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
      stmt.setInt(1, companyId);
      try (ResultSet rs = stmt.executeQuery()) {
        while (rs.next()) {
          Application app = mapResultSetToApplication(rs);
          app.setApplicantName(rs.getString("applicant_name"));
          app.setApplicantEmail(rs.getString("applicant_email"));
          applications.add(app);
        }
      }
    }
    return applications;
  }

  private Application mapResultSetToApplication(ResultSet rs) throws SQLException {
    Application application = new Application();
    application.setId(rs.getInt("id"));
    application.setJobId(rs.getInt("job_id"));
    application.setUserId(rs.getInt("user_id"));
    application.setResumePath(rs.getString("resume_path"));
    application.setCoverLetter(rs.getString("cover_letter"));
    application.setAppliedDate(rs.getTimestamp("applied_date"));
    application.setStatus(rs.getString("status"));
    return application;
  }
}