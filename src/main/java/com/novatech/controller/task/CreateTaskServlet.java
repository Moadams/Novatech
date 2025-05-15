package com.novatech.controller.task;

import com.novatech.dao.TaskDAO;
import com.novatech.model.Task;
import com.novatech.util.DatabaseConfig;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

public class CreateTaskServlet extends HttpServlet {
    private TaskDAO taskDAO = new TaskDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("views/tasks/create.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String priority = request.getParameter("priority");
        Date dueDate = Date.valueOf(request.getParameter("dueDate"));
        int userId = (int) request.getSession().getAttribute("userId");
        int task_id = generateTaskId();

        Task task = new Task(task_id, userId, title, description, status, priority, dueDate);
       

        boolean success = taskDAO.createTask(task);
        if(success){
            response.sendRedirect("tasks");
        }else{
            request.setAttribute("error", "Task creation failed.");
            request.getRequestDispatcher("views/tasks/create.jsp").forward(request, response);
        }
    }

     public int generateTaskId() {
        String query = "SELECT MAX(id) FROM tasks";

        try (Connection connection = DatabaseConfig.getConnection();
            Statement statement = connection.createStatement();
         ResultSet rs = statement.executeQuery(query)) {

        if (rs.next()) {
            int lastNumber = rs.getInt(1);
            return Math.abs(lastNumber + 1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        System.err.println("Error generating task number: " + e.getMessage());
    }

    
    return (int) Math.abs(System.currentTimeMillis());
}
}
