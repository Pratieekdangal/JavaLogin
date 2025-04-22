package org.example.jobp.dao;

import org.example.jobp.model.Company;
import org.example.jobp.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CompanyDAO {
  private static final Logger logger = Logger.getLogger(CompanyDAO.class.getName());
  private final Connection connection;

  public CompanyDAO() throws SQLException {
    this.connection = DBUtil.getConnection();
  }

  public Company createCompany(Company company) throws SQLException {
    String sql = "INSERT INTO companies (name, industry, description, user_id, website, address, size, founded_year) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
      stmt.setString(1, company.getName());
      stmt.setString(2, company.getIndustry());
      stmt.setString(3, company.getDescription());
      stmt.setInt(4, company.getUserId());
      stmt.setString(5, company.getWebsite());
      stmt.setString(6, company.getAddress());
      stmt.setString(7, company.getSize());
      stmt.setObject(8, company.getFoundedYear());

      int affectedRows = stmt.executeUpdate();

      if (affectedRows == 0) {
        throw new SQLException("Creating company failed, no rows affected.");
      }

      try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
        if (generatedKeys.next()) {
          company.setId(generatedKeys.getInt(1));
          logger.info("Company created successfully with ID: " + company.getId());
          return company;
        } else {
          throw new SQLException("Creating company failed, no ID obtained.");
        }
      }

    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error creating company: " + company.getName(), e);
      throw e;
    }
  }

  public Company getCompanyById(int companyId) {
    String sql = "SELECT * FROM companies WHERE id = ?";

    try (Connection conn = DBUtil.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {

      stmt.setInt(1, companyId);
      ResultSet rs = stmt.executeQuery();

      if (rs.next()) {
        return mapResultSetToCompany(rs);
      }

    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error getting company by ID: " + e.getMessage(), e);
    }
    return null;
  }

  public Company getCompanyByUserId(int userId) throws SQLException {
    String sql = "SELECT * FROM companies WHERE user_id = ?";

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
      stmt.setInt(1, userId);
      try (ResultSet rs = stmt.executeQuery()) {
        if (rs.next()) {
          return mapResultSetToCompany(rs);
        }
      }
    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error getting company by user ID: " + userId, e);
      throw e;
    }
    return null;
  }

  public boolean updateCompany(Company company) throws SQLException {
    String sql = "UPDATE companies SET name = ?, industry = ?, website = ?, " +
        "address = ?, size = ?, founded_year = ?, description = ? WHERE id = ?";

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
      stmt.setString(1, company.getName());
      stmt.setString(2, company.getIndustry());
      stmt.setString(3, company.getWebsite());
      stmt.setString(4, company.getAddress());
      stmt.setString(5, company.getSize());
      stmt.setObject(6, company.getFoundedYear());
      stmt.setString(7, company.getDescription());
      stmt.setInt(8, company.getId());

      int affectedRows = stmt.executeUpdate();
      return affectedRows > 0;

    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error updating company: " + company.getId(), e);
      throw e;
    }
  }

  public List<Company> getAllCompanies() {
    List<Company> companies = new ArrayList<>();
    String sql = "SELECT * FROM companies ORDER BY name";

    try (Connection conn = DBUtil.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql)) {

      while (rs.next()) {
        companies.add(mapResultSetToCompany(rs));
      }

    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error fetching all companies: " + e.getMessage(), e);
    }
    return companies;
  }

  public int getTotalApplicationsForCompany(int companyId) throws SQLException {
    String sql = "SELECT COUNT(*) as total FROM applications a " +
        "JOIN jobs j ON a.job_id = j.id " +
        "WHERE j.company_id = ?";

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
      stmt.setInt(1, companyId);
      try (ResultSet rs = stmt.executeQuery()) {
        if (rs.next()) {
          return rs.getInt("total");
        }
      }
    } catch (SQLException e) {
      logger.log(Level.SEVERE, "Error getting total applications for company ID: " + companyId, e);
      throw e;
    }
    return 0;
  }

  private Company mapResultSetToCompany(ResultSet rs) throws SQLException {
    Company company = new Company();
    company.setId(rs.getInt("id"));
    company.setName(rs.getString("name"));
    company.setIndustry(rs.getString("industry"));
    company.setWebsite(rs.getString("website"));
    company.setAddress(rs.getString("address"));
    company.setSize(rs.getString("size"));
    company.setFoundedYear(rs.getInt("founded_year"));
    company.setDescription(rs.getString("description"));
    company.setUserId(rs.getInt("user_id"));
    company.setCreatedAt(rs.getTimestamp("created_at"));
    company.setUpdatedAt(rs.getTimestamp("updated_at"));
    return company;
  }
}