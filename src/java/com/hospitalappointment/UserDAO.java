package com.hospitalappointment;

import java.sql.*;

public class UserDAO {
    private Connection conn;

    // Constructor to establish database connection
    public UserDAO() throws SQLException, ClassNotFoundException {
        // Load JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
    }

    // Method to check if a user with a given username or email exists
    public boolean userExists(String username, String email) throws SQLException {
        String query = "SELECT * FROM users WHERE username = ? OR email = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, email);
        ResultSet rs = ps.executeQuery();
        return rs.next();
    }

    // Method to save a new user to the database
    public boolean saveUser(User user) throws SQLException {
        String query = "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, user.getUsername());
        ps.setString(2, user.getPassword());  // Assumes password is already hashed
        ps.setString(3, user.getEmail());
        ps.setString(4, user.getRole());
        int rowsInserted = ps.executeUpdate();
        return rowsInserted > 0;
    }

    // Method to check if login credentials are valid
    public User validateUser(String email, String password) throws SQLException {
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, email);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return new User(rs.getString("username"), rs.getString("email"), rs.getString("password"), rs.getString("role"));
        }
        return null;
    }

    // Close the connection
    public void close() throws SQLException {
        if (conn != null) {
            conn.close();
        }
    }
}
