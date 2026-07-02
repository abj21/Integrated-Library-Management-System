package com.library.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.library.dao.BookDao;
import com.library.model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/searchBook")
public class SearchBookServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        BookDao dao = new BookDao();

        List<Book> books = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            books = dao.searchBooks(keyword.trim());
        }

        request.setAttribute("books", books);

        request.getRequestDispatcher("searchResults.jsp")
               .forward(request, response);
    }
}