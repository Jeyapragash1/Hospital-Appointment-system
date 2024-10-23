package com.hospitalappointment;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Mapping the servlet to the URL pattern
@WebServlet("/ForgotPasswordHandler")
public class ForgotPasswordHandler extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Initialize database connection
            conn = DatabaseConnection.initializeDatabase();

            // Check if the email exists in the user table
            String query = "SELECT * FROM user WHERE email = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Generate a password reset token
                String token = generateResetToken();
                String updateTokenQuery = "UPDATE user SET reset_token = ?, token_expiry = DATE_ADD(NOW(), INTERVAL 1 HOUR) WHERE email = ?";
                ps = conn.prepareStatement(updateTokenQuery);
                ps.setString(1, token);
                ps.setString(2, email);
                ps.executeUpdate();

                // Send the reset email
                boolean emailSent = sendResetEmail(email, token);
                if (emailSent) {
                    response.sendRedirect("forgotPassword.jsp?success=Password+reset+link+has+been+sent+to+your+email.");
                } else {
                    response.sendRedirect("forgotPassword.jsp?error=Failed+to+send+reset+email.");
                }
            } else {
                // Email not found in the database
                response.sendRedirect("forgotPassword.jsp?error=Email+not+found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("forgotPassword.jsp?error=An+error+occurred.");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private String generateResetToken() {
        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[24];
        random.nextBytes(bytes);
        return Base64.getUrlEncoder().encodeToString(bytes);
    }

    private boolean sendResetEmail(String email, String token) {
        // Implement the email sending logic here using JavaMail API or any other library
        // For simplicity, return true to indicate that the email was "sent"
        return true;
    }
}
