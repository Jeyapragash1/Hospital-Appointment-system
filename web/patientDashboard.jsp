<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");

    if (user == null || !"patient".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String patientName = "";
    String appointmentDetails = "";

    try {
        // Load JDBC driver
        Class.forName("com.mysql.jdbc.Driver");

        // Establish connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");

        // Fetch patient name
        ps = conn.prepareStatement("SELECT name FROM patient WHERE user_id = ?");
        ps.setString(1, user);
        rs = ps.executeQuery();

        if (rs.next()) {
            patientName = rs.getString("name");
        }

        // Fetch appointment details
        ps = conn.prepareStatement("SELECT a.appointment_date, a.appointment_time, d.name as doctor_name, d.speciality FROM appointment a JOIN doctor d ON a.doctor_id = d.doctor_ID WHERE a.patient_id = ?");
        ps.setInt(1, Integer.parseInt(user));
        rs = ps.executeQuery();

        StringBuilder appointmentBuilder = new StringBuilder();
        while (rs.next()) {
            appointmentBuilder.append("<p>")
                              .append("Date: ").append(rs.getDate("appointment_date"))
                              .append("<br>Time: ").append(rs.getTime("appointment_time"))
                              .append("<br>Doctor: ").append(rs.getString("doctor_name"))
                              .append(" (").append(rs.getString("speciality")).append(")")
                              .append("</p><hr>");
        }
        appointmentDetails = appointmentBuilder.toString();

    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #e0f7fa; /* Light blue background color */
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        header {
            background-color: #333333; /* Dark grey color for header */
            color: white;
            padding: 20px;
            text-align: center;
        }

        .container {
            flex: 1;
            padding: 20px;
            max-width: 1200px;
            margin: 20px auto;
            background-color: #ffffff; /* White background for content sections */
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .dashboard {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: space-around;
        }

        .dashboard-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 100%;
            max-width: 300px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .dashboard-card h2 {
            color: #4CAF50;
            margin-bottom: 15px;
        }

        .dashboard-card p {
            color: #555;
            margin-bottom: 20px;
        }

        .dashboard-card a {
            display: inline-block;
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .dashboard-card a:hover {
            background-color: #45a049;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 10px;
            margin-top: auto;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        footer p {
            margin: 5px 0;
        }

        footer a {
            color: #4CAF50;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .dashboard {
                flex-direction: column;
                align-items: center;
            }

            .dashboard-card {
                width: 100%;
                max-width: 100%;
            }
        }
    </style>
</head>
<body>

<header>
    <h1>Welcome, <%= patientName %>!</h1>
</header>

<div class="container">
    <div class="dashboard">
        <div class="dashboard-card">
            <h2>Your Appointments</h2>
            <p>Here are your upcoming and past appointments:</p>
            <div>
                <%= appointmentDetails %>
            </div>
            <a href="viewAppointments.jsp">View More</a>
        </div>
        <div class="dashboard-card">
            <h2>Book Appointment</h2>
            <p>Book a new appointment with your doctor.</p>
            <a href="bookAppointment.jsp">Book Now</a>
        </div>
        <div class="dashboard-card">
            <h2>Profile</h2>
            <p>Update your personal information and settings.</p>
            <a href="manageProfile.jsp">Manage Profile</a>
        </div>
        <div class="dashboard-card">
            <h2>Logout</h2>
            <p>Logout from your account.</p>
            <a href="logout.jsp">Logout</a>
        </div>
    </div>
</div>
<footer>
    <p>&copy; 2024 Hospital Appointment System. All rights reserved.</p>
    <p><a href="termsAndConditions.jsp">Terms and Conditions</a> | <a href="privacyPolicy.jsp">Privacy Policy</a></p>
</footer>

</body>
</html>
