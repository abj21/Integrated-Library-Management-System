package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.library.model.Book;
import com.library.util.DBConnection;

public class BookDao {

    // Add Book
    public boolean addBook(Book book) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "INSERT INTO books(title, author, quantity) VALUES(?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setInt(3, book.getQuantity());

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }

    // View All Books
    public List<Book> getAllBooks() {

        List<Book> books = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM books";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Book book = new Book();

                book.setId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setQuantity(rs.getInt("quantity"));

                books.add(book);
            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return books;
    }

    // Delete Book
    public boolean deleteBook(int id) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "DELETE FROM books WHERE book_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }

    // Search Books By Book ID / Title / Author
    public List<Book> searchBooks(String keyword) {

        List<Book> books = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "SELECT * FROM books WHERE " +
                    "CAST(book_id AS CHAR) LIKE ? OR " +
                    "title LIKE ? OR " +
                    "author LIKE ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Book book = new Book();

                book.setId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setQuantity(rs.getInt("quantity"));

                books.add(book);
            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return books;
    }

    // Total Books
    public int getTotalBooks() {

        int total = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement("SELECT COUNT(*) FROM books");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getInt(1);
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    // Books Issued
    public int getIssuedBooksCount() {

        int total = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement("SELECT COUNT(*) FROM issued_books WHERE status='Issued'");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getInt(1);
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    // Returned Books
    public int getReturnedBooksCount() {

        int total = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement("SELECT COUNT(*) FROM issued_books WHERE status='Returned'");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getInt(1);
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    // Total Fine Collection
    public double getTotalFine() {

        double total = 0;

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement("SELECT SUM(fine) FROM issued_books");

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                total = rs.getDouble(1);
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return total;
    }

}