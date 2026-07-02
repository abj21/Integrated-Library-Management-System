package com.library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.library.model.User;
import com.library.util.DBConnection;

public class UserDao {

    // Add User
    public boolean addUser(User user) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "INSERT INTO users(name,email,password,status) VALUES(?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, "Pending");

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // View All Users
    public List<User> getAllUsers() {

        List<User> users = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                User user = new User();

                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setStatus(rs.getString("status"));

                users.add(user);
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    // Validate Login
    public boolean validateUser(String email, String password) {

        boolean valid = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "SELECT * FROM users WHERE email=? AND password=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                valid = true;
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return valid;
    }

    // Get User Status
    public String getUserStatus(String email, String password) {

        String status = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "SELECT status FROM users WHERE email=? AND password=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                status = rs.getString("status");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Approve User
    public boolean approveUser(int id) {

        boolean approved = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "UPDATE users SET status='Approved' WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

            if (ps.executeUpdate() > 0) {
                approved = true;
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return approved;
    }

    // Get User ID by Email
    public int getUserIdByEmail(String email) {

        int userId = 0;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "SELECT id FROM users WHERE email=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("id");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return userId;
    }
}