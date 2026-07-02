package com.library.servlet;

import java.io.IOException;

import com.library.dao.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/userLogin")
public class UserLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDao dao = new UserDao();

        String userStatus = dao.getUserStatus(email, password);

        if ("Approved".equalsIgnoreCase(userStatus)) {

            int userId = dao.getUserIdByEmail(email);

            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            session.setAttribute("userId", userId);

            response.sendRedirect("userDashboard.jsp");

        } else if ("Pending".equalsIgnoreCase(userStatus)) {

            request.setAttribute("error",
                    "Your account is awaiting admin approval.");

            request.getRequestDispatcher("userLogin.jsp")
                   .forward(request, response);

        } else {

            request.setAttribute("error",
                    "Invalid Email or Password");

            request.getRequestDispatcher("userLogin.jsp")
                   .forward(request, response);

        }
    }
}