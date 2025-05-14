package com.novatech.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConfig {
    private static String url = "jdbc:postresql://localhost:5432/Novatech";
    private static String user = "postgres";
    private static String password = "5llsmu1";
    private static Connection connection;

    public static Connection getConnection() throws SQLException {
        if(connection == null || connection.isClosed()) {
            try {
                Class.forName("org.postgresql.Driver");
                connection = DriverManager.getConnection(url, user, password);
                System.out.println("Connected to database");
            } catch (ClassNotFoundException e) {
                throw new SQLException("Postgres driver not found" + e.getMessage());
            }
        }
        
        return connection;
    }
}
