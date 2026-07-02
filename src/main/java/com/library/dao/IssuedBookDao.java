package com.library.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.library.model.IssuedBook;
import com.library.util.DBConnection;

public class IssuedBookDao {

    // Issue Book
    public boolean issueBook(IssuedBook issuedBook) {

        boolean status = false;

        String sql =
                "INSERT INTO issued_books(user_id, book_id, issue_date, return_date, status, fine) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, issuedBook.getUserId());
            ps.setInt(2, issuedBook.getBookId());
            ps.setDate(3, Date.valueOf(issuedBook.getIssueDate()));
            ps.setDate(4, Date.valueOf(issuedBook.getReturnDate()));
            ps.setString(5, "Issued");
            ps.setDouble(6, 0);

            int row = ps.executeUpdate();

            if (row > 0) {

                String updateBook =
                        "UPDATE books SET quantity = quantity - 1 WHERE book_id = ?";

                PreparedStatement ps2 =
                        conn.prepareStatement(updateBook);

                ps2.setInt(1, issuedBook.getBookId());

                ps2.executeUpdate();

                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Return Book
    public boolean returnBook(int issueId) {

        boolean status = false;

        try (Connection conn = DBConnection.getConnection()) {

            int bookId = 0;
            Date issueDate = null;

            String getBookSql =
                    "SELECT book_id, issue_date FROM issued_books WHERE id = ?";

            PreparedStatement ps1 = conn.prepareStatement(getBookSql);

            ps1.setInt(1, issueId);

            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                bookId = rs.getInt("book_id");
                issueDate = rs.getDate("issue_date");
            }

            long currentTime = System.currentTimeMillis();
            long issueTime = issueDate.getTime();

            long diff = currentTime - issueTime;
            long days = diff / (1000 * 60 * 60 * 24);

            double fine = 0;

            if (days > 7) {
                fine = (days - 7) * 10;
            }

            String returnSql =
                    "UPDATE issued_books SET return_date = CURDATE(), status = ?, fine = ? WHERE id = ?";

            PreparedStatement ps2 =
                    conn.prepareStatement(returnSql);

            ps2.setString(1, "Returned");
            ps2.setDouble(2, fine);
            ps2.setInt(3, issueId);

            int row = ps2.executeUpdate();

            if (row > 0) {

                String updateBook =
                        "UPDATE books SET quantity = quantity + 1 WHERE book_id = ?";

                PreparedStatement ps3 =
                        conn.prepareStatement(updateBook);

                ps3.setInt(1, bookId);

                ps3.executeUpdate();

                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // View All Issued Books
    public List<IssuedBook> getAllIssuedBooks() {

        List<IssuedBook> list = new ArrayList<>();

        String sql =
                "SELECT ib.id, ib.user_id, ib.book_id, ib.issue_date, ib.return_date, ib.status, ib.fine, b.title " +
                "FROM issued_books ib " +
                "JOIN books b ON ib.book_id = b.book_id";

        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {

                IssuedBook issuedBook = new IssuedBook();

                issuedBook.setIssueId(rs.getInt("id"));
                issuedBook.setUserId(rs.getInt("user_id"));
                issuedBook.setBookId(rs.getInt("book_id"));
                issuedBook.setBookTitle(rs.getString("title"));
                issuedBook.setIssueDate(rs.getString("issue_date"));
                issuedBook.setReturnDate(rs.getString("return_date"));
                issuedBook.setStatus(rs.getString("status"));
                issuedBook.setFine(rs.getDouble("fine"));

                list.add(issuedBook);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Borrow History
    public List<IssuedBook> getBorrowHistory() {

        List<IssuedBook> list = new ArrayList<>();

        String sql =
                "SELECT ib.id, ib.user_id, ib.book_id, b.title, " +
                "ib.issue_date, ib.return_date, ib.status, ib.fine " +
                "FROM issued_books ib " +
                "JOIN books b ON ib.book_id = b.book_id " +
                "ORDER BY ib.issue_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                IssuedBook issuedBook = new IssuedBook();

                issuedBook.setIssueId(rs.getInt("id"));
                issuedBook.setUserId(rs.getInt("user_id"));
                issuedBook.setBookId(rs.getInt("book_id"));
                issuedBook.setBookTitle(rs.getString("title"));
                issuedBook.setIssueDate(rs.getString("issue_date"));
                issuedBook.setReturnDate(rs.getString("return_date"));
                issuedBook.setStatus(rs.getString("status"));
                issuedBook.setFine(rs.getDouble("fine"));

                list.add(issuedBook);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // View Issued Books of Logged-in User
    public List<IssuedBook> getIssuedBooksByUser(int userId) {

        List<IssuedBook> list = new ArrayList<>();

        String sql =
                "SELECT ib.id, ib.user_id, ib.book_id, ib.issue_date, ib.return_date, ib.status, ib.fine, b.title " +
                "FROM issued_books ib " +
                "JOIN books b ON ib.book_id = b.book_id " +
                "WHERE ib.user_id = ? " +
                "ORDER BY ib.issue_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                IssuedBook issuedBook = new IssuedBook();

                issuedBook.setIssueId(rs.getInt("id"));
                issuedBook.setUserId(rs.getInt("user_id"));
                issuedBook.setBookId(rs.getInt("book_id"));
                issuedBook.setBookTitle(rs.getString("title"));
                issuedBook.setIssueDate(rs.getString("issue_date"));
                issuedBook.setReturnDate(rs.getString("return_date"));
                issuedBook.setStatus(rs.getString("status"));
                issuedBook.setFine(rs.getDouble("fine"));

                list.add(issuedBook);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
// Most Borrowed Book
public String getMostBorrowedBook() {

    String book = "N/A";

    try {

        Connection conn = DBConnection.getConnection();

        String sql =
                "SELECT b.title, COUNT(*) total " +
                "FROM issued_books ib " +
                "JOIN books b ON ib.book_id = b.book_id " +
                "GROUP BY b.book_id, b.title " +
                "ORDER BY total DESC " +
                "LIMIT 1";

        PreparedStatement ps = conn.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            book = rs.getString("title");
        }

        conn.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return book;
}

// Overdue Books Count
public int getOverdueBooksCount() {

    int count = 0;

    try {

        Connection conn = DBConnection.getConnection();

        String sql =
                "SELECT COUNT(*) FROM issued_books " +
                "WHERE status='Issued' AND DATEDIFF(CURDATE(), issue_date) > 7";

        PreparedStatement ps = conn.prepareStatement(sql);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            count = rs.getInt(1);
        }

        conn.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    return count;
}
}