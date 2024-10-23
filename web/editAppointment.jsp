<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String appointmentId = request.getParameter("appointmentId");
    String doctorId = "";
    String appointmentDate = "";
    String appointmentTime = "";
    String message = "";

    if (appointmentId != null && !appointmentId.isEmpty()) {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
            PreparedStatement ps = conn.prepareStatement("SELECT doctor_id, appointment_date, appointment_time FROM appointment WHERE appointment_ID = ?");
            ps.setString(1, appointmentId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                doctorId = rs.getString("doctor_id");
                appointmentDate = rs.getString("appointment_date");
                appointmentTime = rs.getString("appointment_time");
            } else {
                message = "Appointment not found.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Database connection error: " + e.getMessage();
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    } else {
        message = "Invalid appointment ID.";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Appointment</title>
    <link rel="stylesheet" type="text/css" href="css/editAppointment.css">
</head>
<body>

<header>
    <h1>Edit Appointment</h1>
</header>

<div class="container">
    <h2>Edit Your Appointment</h2>
    <%
        if (!message.isEmpty()) {
    %>
        <p><%= message %></p>
    <%
        } else {
    %>
    <form method="post" action="updateAppointment.jsp">
        <input type="hidden" name="appointmentId" value="<%= appointmentId %>">
        <div class="form-group">
            <label for="doctorId">Doctor:</label>
            <select id="doctorId" name="doctorId" required>
                <%
                    Connection conn = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
                        PreparedStatement ps = conn.prepareStatement("SELECT doctor_ID, name FROM doctor WHERE availability = 1");
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                            String id = rs.getString("doctor_ID");
                            String name = rs.getString("name");
                            String selected = id.equals(doctorId) ? "selected" : "";
                %>
                            <option value="<%= id %>" <%= selected %>><%= name %></option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                %>
            </select>
        </div>
        <div class="form-group">
            <label for="appointmentDate">Date:</label>
            <input type="date" id="appointmentDate" name="appointmentDate" value="<%= appointmentDate %>" required>
        </div>
        <div class="form-group">
            <label for="appointmentTime">Time:</label>
            <input type="time" id="appointmentTime" name="appointmentTime" value="<%= appointmentTime %>" required>
        </div>
        <div class="form-group">
            <button type="submit">Update Appointment</button>
        </div>
    </form>
    <%
        }
    %>
</div>

</body>
</html>
