package com.library.servlet;

import java.io.IOException;

import com.library.dao.BookDao;
import com.library.model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/addBook")
public class AddBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Book book = new Book();
        book.setTitle(title);
        book.setAuthor(author);
        book.setQuantity(quantity);

        BookDao bookDao = new BookDao();

        try {
            bookDao.addBook(book);

            // Forward to success page
            request.getRequestDispatcher("success.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            response.getWriter().println(
                "<h2>Error adding book!</h2>"
            );
        }
    }
}