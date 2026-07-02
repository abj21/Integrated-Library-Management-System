package com.library.servlet;

import java.io.IOException;
import java.util.List;

import com.library.dao.UserDao;
import com.library.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/viewUsers")
public class ViewUsersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        UserDao dao = new UserDao();

        List<User> users = dao.getAllUsers();

        request.setAttribute("users", users);

        request.getRequestDispatcher("viewUsers.jsp")
               .forward(request, response);
    }
}