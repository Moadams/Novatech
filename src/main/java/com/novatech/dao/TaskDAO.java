package com.novatech.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.novatech.model.Task;
import com.novatech.util.DatabaseConfig;
import com.novatech.util.LoggerUtil;

public class TaskDAO {
    LoggerUtil logger = new LoggerUtil();
    public List<Task> getTasksByUserId(int userId) {
        String sql = "SELECT * FROM tasks WHERE user_id = ? ORDER BY due_date ASC";
        try (Connection connection = DatabaseConfig.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            List<Task> tasks = new ArrayList<>();
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                Task task = extractTaskFromResultSet(resultSet);
                tasks.add(task);
            }
            return tasks;

        } catch (Exception e) {
            logger.logError("Error retrieving tasks: " + e.getMessage(), e);
            e.printStackTrace();
            return null;
        }
    }
    
    private Task extractTaskFromResultSet(ResultSet rs) throws SQLException {
        Task task = new Task();
        task.setTaskId(rs.getInt("id"));
        task.setUserId(rs.getInt("user_id"));
        task.setTitle(rs.getString("title"));
        task.setDescription(rs.getString("description"));
        task.setStatus(rs.getString("status"));
        task.setDueDate(rs.getDate("due_date"));
        task.setCreatedAt(rs.getTimestamp("created_at"));
        task.setUpdatedAt(rs.getTimestamp("updated_at"));
        return task;
    }

    public boolean createTask(Task task) {
        String sql = "INSERT INTO tasks (id, user_id, title, description, status, priority, due_date, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConfig.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, task.getTaskId());
            statement.setInt(2, task.getUserId());
            statement.setString(3, task.getTitle());
            statement.setString(4, task.getDescription());
            statement.setString(5, task.getStatus());
            statement.setString(6, task.getPriority());
            statement.setDate(7, task.getDueDate());
            statement.setTimestamp(8, task.getCreatedAt());
            statement.setTimestamp(9, task.getUpdatedAt());

            System.out.println("created at: " + task.getCreatedAt());
            System.out.println("updated at" + task.getUpdatedAt());
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            logger.logError("Error creating task: " + e.getMessage(), e);
            e.printStackTrace();
            return false;
        }
    }
}
