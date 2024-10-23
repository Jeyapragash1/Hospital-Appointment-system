<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Hospital Appointment System</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #e0f7fa; /* Light blue background color */
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url('images/back.avif'); /* Background image */
            background-size: cover;
            background-position: center;
        }

        .login-container {
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        .login-container h1 {
            color: #4CAF50;
            margin-bottom: 20px;
        }

        .login-container h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
            box-sizing: border-box;
        }

        .form-group input:focus {
            border-color: #4CAF50;
            outline: none;
        }

        .form-group button {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50; /* Green button */
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        .form-group button:hover {
            background-color: #45a049;
        }

        .login-container p {
            color: #333;
            margin-top: 10px;
        }

        .login-container a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
        }

        .login-container a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="login-container">
    
    <h2>Login</h2>
    <%
        String message = "";
        if (request.getParameter("submit") != null) {
            String email = request.getParameter("username"); // Email as the username
            String password = request.getParameter("password");

            Connection conn = null;
            try {
                // Load JDBC driver
                Class.forName("com.mysql.jdbc.Driver");

                // Establish connection
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");

                // Select the user with the provided email
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE email = ? AND password = ?");
                ps.setString(1, email);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String role = rs.getString("role");

                    session.setAttribute("user", rs.getString("user_id"));
                    session.setAttribute("role", role);

                    // Redirect based on role
                    if ("admin".equals(role)) {
                        response.sendRedirect("adminDashboard.jsp");
                    } else if ("doctor".equals(role)) {
                        response.sendRedirect("doctorDashboard.jsp");
                    } else if ("patient".equals(role)) {
                        response.sendRedirect("patientDashboard.jsp");
                    }
                } else {
                    message = "Invalid email or password.";
                }
            } catch (SQLException e) {
                e.printStackTrace();
                message = "Database connection error: " + e.getMessage();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                message = "JDBC Driver not found: " + e.getMessage();
            } finally {
                if (conn != null) {
                    try { conn.close(); } catch (SQLException ignore) {}
                }
            }
        }
    %>
    <form action="LoginHandler" method="post">
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br>

    <input type="submit" value="Login">
</form>

    <p>Don't have an account? <a href="register.jsp">Register here</a>.</p>
    <p><a href="forgotPassword.jsp">Forgot Password?</a></p>
    <p class="error-message"><%= message %></p>
</div>

</body>
</html>
