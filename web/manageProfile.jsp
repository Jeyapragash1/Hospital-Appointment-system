<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%
    String message = "";
    String userId = (String) session.getAttribute("user");
    String userType = (String) session.getAttribute("userType");

    if (userId == null || userType == null) {
        response.sendRedirect("login.jsp"); // Redirect if session does not exist
        return;
    }

    Connection conn = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");

        if (request.getParameter("updateProfile") != null) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Hash the password before storing it
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            PreparedStatement ps = conn.prepareStatement("UPDATE " + userType + " SET name = ?, email = ?, password = ? WHERE " + userType + "_id = ?");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, hashedPassword);
            ps.setString(4, userId);
            int i = ps.executeUpdate();

            if (i > 0) {
                message = "Profile updated successfully!";
            } else {
                message = "Error occurred while updating the profile.";
            }
        }

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM " + userType + " WHERE " + userType + "_id = ?");
        ps.setString(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            request.setAttribute("name", rs.getString("name"));
            request.setAttribute("email", rs.getString("email"));
            // Passwords should not be pre-filled for security reasons.
        }

    } catch (Exception e) {
        e.printStackTrace();
        message = "Database connection error: " + e.getMessage();
    } finally {
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Profile</title>
    <link rel="stylesheet" type="text/css" href="css/manageProfile.css">
</head>
<body>

<header>
    <h1>Manage Profile</h1>
</header>

<div class="container">
    <div class="profile-form">
        <h2>Update Your Profile</h2>
        <form method="post" action="manageProfile.jsp">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%= request.getAttribute("name") %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= request.getAttribute("email") %>" required>
            </div>
            <div class="form-group">
                <label for="password">New Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter new password" required>
            </div>
            <div class="form-group">
                <button type="submit" name="updateProfile">Update Profile</button>
            </div>
        </form>
        <p><%= message %></p>
    </div>
</div>

</body>
</html>
