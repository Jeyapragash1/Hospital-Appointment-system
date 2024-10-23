<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    if (request.getParameter("submit") != null) {
        String email = request.getParameter("email");

        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
            
            // Check if the email exists in the database
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM patient WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // Simulate sending a password reset email
                message = "A password reset link has been sent to " + email + ". Please check your inbox.";
                // In a real application, you would generate a reset token and send an email with the reset link.
            } else {
                message = "No account found with that email address.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Database connection error.";
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <link rel="stylesheet" type="text/css" href="css/forgotPassword.css">
</head>
<body>

<header>
    <h1>Forgot Password</h1>
</header>

<div class="container">
    <div class="forgot-password-form">
        <h2>Reset Your Password</h2>
        <form action="ForgotPasswordHandler" method="post">
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required><br>
    <input type="submit" name="submit" value="Reset Password">
</form>

        <p><%= message %></p>
    </div>
</div>

</body>
</html>
