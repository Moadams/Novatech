package com.novatech.controller.task;

import java.io.IOException;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.novatech.dao.TaskDAO;
import com.novatech.model.Task;


public class TaskApiServlet extends HttpServlet {
    private TaskDAO taskDAO = new TaskDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // GET /tasks or GET /tasks/{id}
        String pathInfo = req.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Return all tasks (could be filtered by userId via query param)
            int userId = Integer.parseInt(req.getParameter("userId")); // e.g. ?userId=5
            List<Task> tasks = taskDAO.getTasksByUserId(userId);
            writeJsonResponse(resp, tasks);
        } else {
            // GET /tasks/{id}
            int id = Integer.parseInt(pathInfo.substring(1));
            Task task = taskDAO.getTaskById(id);
            writeJsonResponse(resp, task);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // POST /tasks
        Task task = parseJsonRequest(req);
        boolean created = taskDAO.createTask(task);
        resp.setStatus(created ? HttpServletResponse.SC_CREATED : HttpServletResponse.SC_BAD_REQUEST);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // PUT /tasks/{id}
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing task ID");
            return;
        }
        Task updatedTask = parseJsonRequest(req);
        updatedTask.setTaskId(Integer.parseInt(pathInfo.substring(1))); // extract ID from URL
        boolean updated = taskDAO.updateTask(updatedTask);
        resp.setStatus(updated ? HttpServletResponse.SC_OK : HttpServletResponse.SC_NOT_FOUND);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // DELETE /tasks/{id}
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing task ID");
            return;
        }
        int taskId = Integer.parseInt(pathInfo.substring(1));
        boolean deleted = taskDAO.deleteTask(taskId);
        resp.setStatus(deleted ? HttpServletResponse.SC_NO_CONTENT : HttpServletResponse.SC_NOT_FOUND);
    }

    private void writeJsonResponse(HttpServletResponse resp, Object data) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        new ObjectMapper().writeValue(resp.getWriter(), data); // uses Jackson
    }

    private Task parseJsonRequest(HttpServletRequest req) throws IOException {
        return new ObjectMapper().readValue(req.getReader(), Task.class); // assumes Jackson
    }
}
