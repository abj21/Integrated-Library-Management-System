package com.library.servlet;

import java.io.IOException;

import com.library.dao.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDao dao = new UserDao();

        if (dao.validateUser(email, password)) {

            int userId = dao.getUserIdByEmail(email);

            HttpSession session = request.getSession();
            session.setAttribute("user", email);        // Keep existing
            session.setAttribute("userEmail", email);   // New
            session.setAttribute("userId", userId);     // New

            response.sendRedirect("dashboard.jsp");

        } else {

            response.sendRedirect("login.jsp?error=1");
        }
    }
}