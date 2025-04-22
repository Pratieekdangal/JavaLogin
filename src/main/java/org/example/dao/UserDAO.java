package org.example.dao;

import org.example.model.User;
import org.example.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
  public boolean registerUser(User user) {
    String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";

    try (Connection conn = DatabaseUtil.getConnection();
        PreparedStatement pstmt = conn.prepareStatement(sql)) {

      pstmt.setString(1, user.getName());
      pstmt.setString(2, user.getEmail());
      pstmt.setString(3, user.getPassword());
      pstmt.setString(4, user.getRole());

      int rowsAffected = pstmt.executeUpdate();
      return rowsAffected > 0;

    } catch (SQLException e) {
      e.printStackTrace();
      return false;
    }
  }

  public boolean isEmailTaken(String email) {
    String sql = "SELECT COUNT(*) FROM users WHERE email = ?";

    try (Connection conn = DatabaseUtil.getConnection();
        PreparedStatement pstmt = conn.prepareStatement(sql)) {

      pstmt.setString(1, email);
      ResultSet rs = pstmt.executeQuery();

      if (rs.next()) {
        return rs.getInt(1) > 0;
      }

    } catch (SQLException e) {
      e.printStackTrace();
    }
    return false;
  }
}