package com.library.servlet;

import java.io.IOException;

import com.library.dao.IssuedBookDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/returnBook")
public class ReturnBookServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int issueId = Integer.parseInt(request.getParameter("issueId"));

        IssuedBookDao dao = new IssuedBookDao();

        boolean status = dao.returnBook(issueId);

        if (status) {
            response.sendRedirect("viewIssuedBooks");
        } else {
            response.getWriter().println("Return Failed");
        }
    }
}