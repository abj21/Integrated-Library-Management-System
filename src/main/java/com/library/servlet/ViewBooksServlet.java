package com.library.servlet;

import java.io.IOException;
import java.util.List;

import com.library.dao.BookDao;
import com.library.model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/viewBooks")
public class ViewBooksServlet extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        BookDao dao = new BookDao();

        List<Book> books = dao.getAllBooks();

        request.setAttribute("books", books);

        request.getRequestDispatcher("viewBooks.jsp")
               .forward(request, response);
    }
}