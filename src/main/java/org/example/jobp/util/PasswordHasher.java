package org.example.jobp.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordHasher {

  public static String hashPassword(String plainTextPassword) {
    return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
  }

  public static boolean verifyPassword(String plainTextPassword, String hashedPassword) {
    try {
      return BCrypt.checkpw(plainTextPassword, hashedPassword);
    } catch (IllegalArgumentException e) {
      // This can happen if the stored hash is invalid
      return false;
    }
  }
}