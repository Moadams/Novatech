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

    public Task getTaskById(int id) {
        String query = "SELECT * FROM tasks WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
    
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
    
            if (rs.next()) {
                Task task = new Task();
                task.setTaskId(rs.getInt("id"));
                task.setTitle(rs.getString("title"));
                task.setDescription(rs.getString("description"));
                task.setPriority(rs.getString("priority"));
                task.setStatus(rs.getString("status"));
                task.setCreatedAt(rs.getTimestamp("created_at"));
                task.setUpdatedAt(rs.getTimestamp("updated_at"));
                return task;
            }
    
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    

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
        task.setPriority(rs.getString("priority"));
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

           
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            logger.logError("Error creating task: " + e.getMessage(), e);
            e.printStackTrace();
            return false;
        }
    }


    public boolean deleteTask(int taskId) {
        String query = "DELETE FROM tasks WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, taskId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting task: " + e.getMessage());
            return false;
        }
    }

    public boolean updateTask(Task task) {
        String query = "UPDATE tasks SET title = ?, description = ?, status = ?, priority = ?, updated_at = ? WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
    
            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            stmt.setString(3, task.getStatus());
            stmt.setString(4, task.getPriority());
            stmt.setTimestamp(5, task.getUpdatedAt());
            stmt.setInt(6, task.getTaskId());
    
            return stmt.executeUpdate() > 0;
    
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
