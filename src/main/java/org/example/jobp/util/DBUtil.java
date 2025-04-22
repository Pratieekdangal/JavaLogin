package org.example.jobp.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBUtil {
  private static final Logger logger = Logger.getLogger(DBUtil.class.getName());
  private static final Properties properties = new Properties();
  private static String url;
  private static String username;
  private static String password;

  static {
    try {
      logger.setLevel(Level.INFO);
      logger.info("Initializing DBUtil...");

      // Load the database.properties file
      try (InputStream input = DBUtil.class.getClassLoader().getResourceAsStream("database.properties")) {
        if (input == null) {
          logger.severe("database.properties file not found in classpath!");
          throw new RuntimeException("Unable to find database.properties");
        }

        properties.load(input);
        logger.info("Successfully loaded database.properties");

        url = properties.getProperty("db.url");
        username = properties.getProperty("db.username");
        password = properties.getProperty("db.password");

        // Test loading the JDBC driver
        try {
          Class.forName(properties.getProperty("db.driver"));
          logger.info("Successfully loaded JDBC driver");
        } catch (ClassNotFoundException e) {
          logger.severe("Failed to load JDBC driver: " + e.getMessage());
          throw new RuntimeException("Failed to load JDBC driver", e);
        }

        // Test the connection
        testConnection();

      } catch (IOException e) {
        logger.severe("Error loading database.properties: " + e.getMessage());
        throw new RuntimeException("Error loading database.properties", e);
      }
    } catch (Exception e) {
      logger.severe("Error during DBUtil initialization: " + e.getMessage());
      throw new RuntimeException("Failed to initialize DBUtil", e);
    }
  }

  private static void testConnection() {
    logger.info("Testing database connection...");
    try (Connection conn = DriverManager.getConnection(url, username, password)) {
      logger.info("Successfully connected to database!");
      logger.info("Database product: " + conn.getMetaData().getDatabaseProductName());
      logger.info("Database version: " + conn.getMetaData().getDatabaseProductVersion());
    } catch (SQLException e) {
      logger.severe("Failed to connect to database!");
      logger.severe("Connection URL: " + url);
      logger.severe("Username: " + username);
      logger.severe("Error: " + e.getMessage());
      logger.severe("SQLState: " + e.getSQLState());
      logger.severe("Error Code: " + e.getErrorCode());
      throw new RuntimeException("Failed to connect to database", e);
    }
  }

  public static Connection getConnection() throws SQLException {
    try {
      Connection conn = DriverManager.getConnection(url, username, password);
      if (conn == null) {
        logger.severe("DriverManager.getConnection() returned null!");
        throw new SQLException("Unable to establish database connection - connection is null");
      }
      return conn;
    } catch (SQLException e) {
      logger.severe("Failed to get database connection!");
      logger.severe("Error: " + e.getMessage());
      logger.severe("SQLState: " + e.getSQLState());
      logger.severe("Error Code: " + e.getErrorCode());
      throw e;
    }
  }
}