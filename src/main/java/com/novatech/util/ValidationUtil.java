package com.novatech.util;

import java.util.regex.Pattern;

/**
 * Utility class for validating user input.
 */

public class ValidationUtil {
    
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$"
    );
    
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_-]{3,20}$");
    
    // Validate email format
    public static boolean isValidEmail(String email) {
        if (email == null) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }
    
    // Validate username format (alphanumeric, 3-20 chars)
    public static boolean isValidUsername(String username) {
        if (username == null) {
            return false;
        }
        return USERNAME_PATTERN.matcher(username).matches();
    }
    
    // Validate password strength (at least 8 chars)
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 8;
    }
    
    // Validate task title (not empty, max 100 chars)
    public static boolean isValidTaskTitle(String title) {
        return title != null && !title.trim().isEmpty() && title.length() <= 100;
    }
    
    // Validate date format (YYYY-MM-DD)
    public static boolean isValidDateFormat(String date) {
        return date != null && date.matches("\\d{4}-\\d{2}-\\d{2}");
    }
}