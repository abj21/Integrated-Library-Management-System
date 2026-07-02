package com.library.servlet;

import java.io.IOException;

import com.library.dao.BookDao;
import com.library.dao.IssuedBookDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/reports")
public class ReportsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        BookDao bookDao = new BookDao();
        IssuedBookDao issuedDao = new IssuedBookDao();

        request.setAttribute("totalBooks", bookDao.getTotalBooks());
        request.setAttribute("booksIssued", bookDao.getIssuedBooksCount());
        request.setAttribute("returnedBooks", bookDao.getReturnedBooksCount());
        request.setAttribute("fineCollection", bookDao.getTotalFine());

        request.setAttribute("mostBorrowedBook",
                issuedDao.getMostBorrowedBook());

        request.setAttribute("overdueBooks",
                issuedDao.getOverdueBooksCount());

        request.getRequestDispatcher("reports.jsp")
               .forward(request, response);
    }
}