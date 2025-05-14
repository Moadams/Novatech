package com.novatech.controller.auth;



import javax.servlet.*;
import javax.servlet.http.*;

import com.novatech.dao.UserDAO;
import com.novatech.model.User;
import com.novatech.util.DatabaseConfig;
import com.novatech.util.ValidationUtil;

import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("views/auth/signup.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        Integer userId = generateUserId();

        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Invalid email format.");
            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
            return;
        }

        if (!ValidationUtil.isValidPassword(password)) {
            request.setAttribute("error", "Password must be at least 8 characters long.");
            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
            return;
        }

        if (userDAO.userExists(username)) {
            request.setAttribute("error", "Username already exists.");
            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
            return;
        }


        User user = new User(userId, username, password, email);

        boolean success = userDAO.addUser(user);

        if (success) {
            response.sendRedirect("login");
        } else {
            request.setAttribute("error", "Registration failed. Try again.");
            request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
        }
    }

    public int generateUserId() {
        String query = "SELECT MAX(id) FROM users";

        try (Connection connection = DatabaseConfig.getConnection();
            Statement statement = connection.createStatement();
         ResultSet rs = statement.executeQuery(query)) {

        if (rs.next()) {
            int lastNumber = rs.getInt(1);
            return Math.abs(lastNumber + 1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        System.err.println("Error generating user number: " + e.getMessage());
    }

    
    return (int) Math.abs(System.currentTimeMillis());
}
}
