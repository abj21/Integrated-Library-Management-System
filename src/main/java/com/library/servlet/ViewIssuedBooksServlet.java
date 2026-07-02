package com.library.servlet;

import java.io.IOException;
import java.util.List;

import com.library.dao.IssuedBookDao;
import com.library.model.IssuedBook;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/viewIssuedBooks")
public class ViewIssuedBooksServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");

        IssuedBookDao dao = new IssuedBookDao();

        List<IssuedBook> issuedBooks = dao.getIssuedBooksByUser(userId);

        request.setAttribute("issuedBooks", issuedBooks);

        request.getRequestDispatcher("viewIssuedBooks.jsp")
               .forward(request, response);
    }
}