package org.example.jobp.dao;

import org.example.jobp.model.User;
import org.example.jobp.util.DBUtil;
import org.example.jobp.util.PasswordHasher;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());

    public boolean isEmailTaken(String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
        logger.info("Checking if email is taken: " + email);

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                boolean taken = rs.getInt(1) > 0;
                logger.info("Email " + email + " is " + (taken ? "taken" : "available"));
                return taken;
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking email: " + e.getMessage(), e);
            e.printStackTrace();
        }
        return false;
    }

    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
        logger.info("Attempting to register user with email: " + user.getEmail());

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());

            logger.info("Executing SQL: " + sql + " with values: [name=" + user.getName() +
                    ", email=" + user.getEmail() + ", role=" + user.getRole() + "]");

            int rowsAffected = stmt.executeUpdate();
            boolean success = rowsAffected > 0;
            logger.info("Registration " + (success ? "successful" : "failed") +
                    ". Rows affected: " + rowsAffected);
            return success;

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error registering user: " + e.getMessage(), e);
            e.printStackTrace();
            return false;
        }
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        logger.info("Attempting to get user by email: " + email);

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                logger.info("User found with email: " + email);
                return user;
            }
            logger.warning("No user found with email: " + email);

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting user by email: " + e.getMessage(), e);
            e.printStackTrace();
        }
        return null;
    }
}
