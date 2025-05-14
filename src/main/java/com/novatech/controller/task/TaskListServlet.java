package com.novatech.controller.task;

import com.novatech.dao.TaskDAO;
import com.novatech.model.Task;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;


public class TaskListServlet extends HttpServlet {
    private TaskDAO taskDao = new TaskDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        List<Task> tasks = taskDao.getTasksByUserId(userId);
        request.setAttribute("tasks", tasks);
        RequestDispatcher dispatcher = request.getRequestDispatcher("views/tasks/list.jsp");
        dispatcher.forward(request, response);
    }
}
