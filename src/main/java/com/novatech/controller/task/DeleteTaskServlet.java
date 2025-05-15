package com.novatech.controller.task;

import com.novatech.dao.TaskDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteTaskServlet extends HttpServlet {
    private TaskDAO taskDao = new TaskDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("id"));
        taskDao.deleteTask(taskId);
        response.sendRedirect("tasks");
    }
}
