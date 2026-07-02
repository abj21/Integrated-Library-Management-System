package com.library.servlet;

import java.io.IOException;

import com.library.dao.IssuedBookDao;
import com.library.model.IssuedBook;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/IssueBookServlet")
public class IssueBookServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int userId =
                    Integer.parseInt(request.getParameter("userId"));

            int bookId =
                    Integer.parseInt(request.getParameter("bookId"));

            String issueDate =
                    request.getParameter("issueDate");

            String returnDate =
                    request.getParameter("returnDate");

            IssuedBook book = new IssuedBook();

            book.setUserId(userId);
            book.setBookId(bookId);
            book.setIssueDate(issueDate);
            book.setReturnDate(returnDate);

            IssuedBookDao dao = new IssuedBookDao();

            boolean status = dao.issueBook(book);

            if (status) {

                response.sendRedirect("issueSuccess.jsp");

            } else {

                response.getWriter().println("Book Issue Failed");

            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println("Error : " + e.getMessage());

        }
    }
}