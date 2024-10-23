package com.hospitalappointment;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterHandler")
public class RegisterHandler extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = "PATIENT";  // Default role for registration
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Initialize database connection
            conn = DatabaseConnection.initializeDatabase();

            // Insert new user
            String query = "INSERT INTO user (name, email, password, role) VALUES (?, ?, ?, ?)";
            ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password); // Note: In real applications, hash the password
            ps.setString(4, role);

            int result = ps.executeUpdate();
            if (result > 0) {
                response.sendRedirect("register.jsp?success=Registration+successful");
            } else {
                response.sendRedirect("register.jsp?error=Registration+failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=An+error+occurred");
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
