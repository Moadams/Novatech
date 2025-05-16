package com.novatech.controller.task;

import com.novatech.dao.TaskDAO;
import com.novatech.model.Task;
import com.novatech.util.LoggerUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/update-task")
public class UpdateTaskServlet extends HttpServlet {

    private final TaskDAO taskDAO = new TaskDAO();
    private final LoggerUtil logger = new LoggerUtil();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                System.out.println("getting update");
        try {
            int taskId = Integer.parseInt(request.getParameter("id"));
            Task task = taskDAO.getTaskById(taskId);
            System.out.println(task);
            if (task != null) {
                request.setAttribute("task", task);
                request.getRequestDispatcher("views/tasks/update.jsp").forward(request, response);
            } else {
                response.sendRedirect("tasks"); // Redirect if task not found
            }

        } catch (Exception e) {
            logger.logError("Error loading task for update", e);
            response.sendRedirect("tasks");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            String priority = request.getParameter("priority");

            Task task = new Task();
            task.setTaskId(id);
            task.setTitle(title);
            task.setDescription(description);
            task.setStatus(status);
            task.setPriority(priority);
            task.setUpdatedAt(new Timestamp(System.currentTimeMillis())); 

            boolean isUpdated = taskDAO.updateTask(task);

            if (isUpdated) {
                response.sendRedirect("tasks");
            } else {
                request.setAttribute("task", task);
                request.setAttribute("error", "Failed to update task.");
                request.getRequestDispatcher("views/tasks/update.jsp").forward(request, response);
            }

        } catch (Exception e) {
            logger.logError("Error updating task", e);
            request.setAttribute("error", "Error updating task: " + e.getMessage());
            request.getRequestDispatcher("views/tasks/update.jsp").forward(request, response);
        }
    }
}
