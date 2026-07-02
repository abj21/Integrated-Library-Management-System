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

@WebServlet("/borrowHistory")
public class BorrowHistoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        IssuedBookDao dao = new IssuedBookDao();

        List<IssuedBook> history = dao.getBorrowHistory();

        request.setAttribute("history", history);

        request.getRequestDispatcher("borrowHistory.jsp")
               .forward(request, response);
    }
}