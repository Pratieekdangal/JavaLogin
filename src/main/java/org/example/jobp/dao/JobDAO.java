package org.example.jobp.dao;

import org.example.jobp.model.Job;
import org.example.jobp.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class JobDAO {
  private static final Logger logger = Logger.getLogger(JobDAO.class.getName());
  private final Connection connection;

  public JobDAO() throws SQLException {
    this.connection = DBUtil.getConnection();
  }

  public Job createJob(Job job) {
    String sql = "INSERT INTO jobs (title, department, type, experience_level, location, " +
        "salary, description, requirements, benefits, application_deadline, company_id, " +
        "posted_date, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    try (Connection conn = DBUtil.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

      stmt.setString(1, job.getTitle());
      stmt.setString(2, job.getDepartment());
      stmt.setString(3, job.getType());
      stmt.setString(4, job.getExperienceLevel());
      stmt.setString(5, job.getLocation());
      stmt.setString(6, job.getSalary());
      stmt.setString(7, job.getDescription());
      stmt.setString(8, job.getRequirements());
      stmt.setString(9, job.getBenefits());
      stmt.setTimestamp(10, job.getApplicationDeadline());
      stmt.setInt(11, job.getCompanyId());
      stmt.setTimestamp(12, job.getPostedDate());
      stmt.setString(13, job.getStatus());

      int affectedRows = stmt.executeUpdate();

      if (affectedRows == 0) {
        logger.warning("Creating job failed, no rows affected.");
        return null;
      }

      try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
        if (generatedKeys.next()) {
          job.setId(generatedKeys.getInt(1));
          logger.info("Job created successfully with ID: " + job.getId());
          return job;
        } else {
          logger.warning("Creating job failed, no ID obtained.");
          return null;
        }
      }

    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error creating job: " + e.getMessage(), e);
      return null;
    }
  }

  public List<Job> getJobsByCompanyId(int companyId) {
    List<Job> jobs = new ArrayList<>();
    String sql = "SELECT * FROM jobs WHERE company_id = ? AND status = 'active' ORDER BY posted_date DESC";

    try (Connection conn = DBUtil.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, companyId);
      ResultSet rs = stmt.executeQuery();

      while (rs.next()) {
        jobs.add(mapResultSetToJob(rs));
      }

    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error getting jobs by company ID: " + e.getMessage(), e);
    }
    return jobs;
  }

  public Job getJobById(int jobId) {
    String sql = "SELECT * FROM jobs WHERE id = ? AND status = 'active'";

    try (Connection conn = DBUtil.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, jobId);
      ResultSet rs = stmt.executeQuery();

      if (rs.next()) {
        return mapResultSetToJob(rs);
      }

    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error getting job by ID: " + e.getMessage(), e);
    }
    return null;
  }

  public List<Job> getAllActiveJobs() {
    List<Job> jobs = new ArrayList<>();
    String sql = "SELECT * FROM jobs WHERE status = 'active' ORDER BY posted_date DESC";

    try (Connection conn = DBUtil.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql)) {

      while (rs.next()) {
        jobs.add(mapResultSetToJob(rs));
      }

    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error fetching all active jobs: " + e.getMessage(), e);
    }
    return jobs;
  }

  public boolean updateJob(Job job) {
    String sql = "UPDATE jobs SET title=?, department=?, type=?, experience_level=?, " +
        "location=?, salary=?, description=?, requirements=?, benefits=?, " +
        "application_deadline=?, status=? WHERE id=? AND company_id=?";

    try (Connection conn = DBUtil.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setString(1, job.getTitle());
      stmt.setString(2, job.getDepartment());
      stmt.setString(3, job.getType());
      stmt.setString(4, job.getExperienceLevel());
      stmt.setString(5, job.getLocation());
      stmt.setString(6, job.getSalary());
      stmt.setString(7, job.getDescription());
      stmt.setString(8, job.getRequirements());
      stmt.setString(9, job.getBenefits());
      stmt.setTimestamp(10, job.getApplicationDeadline());
      stmt.setString(11, job.getStatus());
      stmt.setInt(12, job.getId());
      stmt.setInt(13, job.getCompanyId());

      int rowsAffected = stmt.executeUpdate();
      return rowsAffected > 0;

    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error updating job: " + e.getMessage(), e);
      return false;
    }
  }

  public boolean deleteJob(int jobId, int companyId) {
    String sql = "UPDATE jobs SET status='deleted' WHERE id=? AND company_id=?";

    try (Connection conn = DBUtil.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, jobId);
      stmt.setInt(2, companyId);

      int rowsAffected = stmt.executeUpdate();
      return rowsAffected > 0;

    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error deleting job: " + e.getMessage(), e);
      return false;
    }
  }

  public List<Job> getJobsByRecruiter(int recruiterId) {
    List<Job> jobs = new ArrayList<>();
    String sql = "SELECT j.* FROM jobs j " +
        "JOIN companies c ON j.company_id = c.id " +
        "WHERE c.user_id = ? " +
        "ORDER BY j.posted_date DESC";

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
      stmt.setInt(1, recruiterId);
      ResultSet rs = stmt.executeQuery();

      while (rs.next()) {
        jobs.add(mapResultSetToJob(rs));
      }

    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error getting jobs for recruiter: " + recruiterId, e);
    }

    return jobs;
  }

  public List<Job> getAllJobs() throws SQLException {
    List<Job> jobs = new ArrayList<>();
    String query = "SELECT * FROM jobs WHERE status = 'active' ORDER BY posted_date DESC";

    try (PreparedStatement stmt = connection.prepareStatement(query)) {
      logger.log(Level.INFO, "Executing query to fetch all active jobs");
      ResultSet rs = stmt.executeQuery();

      while (rs.next()) {
        Job job = new Job();
        job.setId(rs.getInt("id"));
        job.setTitle(rs.getString("title"));
        job.setDepartment(rs.getString("department"));
        job.setType(rs.getString("type"));
        job.setExperienceLevel(rs.getString("experience_level"));
        job.setLocation(rs.getString("location"));
        job.setSalary(rs.getString("salary"));
        job.setDescription(rs.getString("description"));
        job.setRequirements(rs.getString("requirements"));
        job.setBenefits(rs.getString("benefits"));
        job.setApplicationDeadline(rs.getTimestamp("application_deadline"));
        job.setCompanyId(rs.getInt("company_id"));
        job.setPostedDate(rs.getTimestamp("posted_date"));
        job.setStatus(rs.getString("status"));

        jobs.add(job);
      }

      logger.log(Level.INFO, "Successfully retrieved {0} jobs", jobs.size());
      return jobs;
    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error retrieving jobs: " + e.getMessage(), e);
      throw e;
    }
  }

  public List<Job> getActiveJobs() throws SQLException {
    List<Job> jobs = new ArrayList<>();
    String sql = "SELECT j.*, c.name as company_name FROM jobs j " +
        "JOIN companies c ON j.company_id = c.id " +
        "WHERE j.status = 'ACTIVE' " +
        "ORDER BY j.posted_date DESC";

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
      try (ResultSet rs = stmt.executeQuery()) {
        while (rs.next()) {
          Job job = mapResultSetToJob(rs);
          job.setCompanyName(rs.getString("company_name"));
          jobs.add(job);
        }
      }
    }
    return jobs;
  }

  private Job mapResultSetToJob(ResultSet rs) throws SQLException {
    Job job = new Job();
    job.setId(rs.getInt("id"));
    job.setTitle(rs.getString("title"));
    job.setDepartment(rs.getString("department"));
    job.setType(rs.getString("type"));
    job.setExperienceLevel(rs.getString("experience_level"));
    job.setLocation(rs.getString("location"));
    job.setSalary(rs.getString("salary"));
    job.setDescription(rs.getString("description"));
    job.setRequirements(rs.getString("requirements"));
    job.setBenefits(rs.getString("benefits"));
    job.setApplicationDeadline(rs.getTimestamp("application_deadline"));
    job.setCompanyId(rs.getInt("company_id"));
    job.setPostedDate(rs.getTimestamp("posted_date"));
    job.setStatus(rs.getString("status"));
    return job;
  }
}