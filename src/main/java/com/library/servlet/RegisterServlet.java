package com.library.servlet;

import java.io.IOException;

import com.library.dao.UserDao;
import com.library.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = new User();

        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);

        UserDao dao = new UserDao();

        boolean status = dao.addUser(user);

        if (status) {

            response.sendRedirect(
                "userLogin.jsp?msg=Registration successful! Please wait for admin approval."
            );

        } else {

            response.getWriter().println("Registration Failed");

        }
    }
}