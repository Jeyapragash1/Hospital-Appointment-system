<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String doctorId = (String) session.getAttribute("user"); // Assuming user session holds doctor ID
    String message = "";

    // Handle the request to mark an appointment as completed
    if (request.getParameter("markCompleted") != null) {
        String appointmentId = request.getParameter("appointmentId");

        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");

            // Check if the appointment exists and belongs to the doctor
            PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM appointment WHERE appointment_ID = ? AND doctor_id = ?");
            checkStmt.setString(1, appointmentId);
            checkStmt.setString(2, doctorId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Proceed with the update if the appointment exists
                PreparedStatement ps = conn.prepareStatement("UPDATE appointment SET status = 'Completed' WHERE appointment_ID = ? AND doctor_id = ?");
                ps.setString(1, appointmentId);
                ps.setString(2, doctorId);
                int i = ps.executeUpdate();

                if (i > 0) {
                    message = "Appointment marked as completed!";
                } else {
                    message = "Error occurred while updating the appointment. Please try again.";
                }
            } else {
                message = "Appointment not found or does not belong to the current doctor.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            message = "Database connection error: " + e.getMessage();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            message = "JDBC Driver not found: " + e.getMessage();
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor Dashboard</title>
    <link rel="stylesheet" href="css/doctorDashboard.css"/>
</head>
<body>

<header>
    Doctor Dashboard
</header>

<div class="container">
    <div class="stats-overview">
        <div class="stat-card">
            <h3>Total Appointments</h3>
            <p>15</p>
        </div>
        <div class="stat-card">
            <h3>Completed</h3>
            <p>10</p>
        </div>
        <div class="stat-card">
            <h3>Pending</h3>
            <p>5</p>
        </div>
    </div>

    <h2>Upcoming Appointments</h2>
    <div class="appointments">
        <%
            // Sample data for testing
            String[][] sampleAppointments = {
                {"1", "2024-08-15", "09:00 AM", "Nimal Perera", "Pending"},
                {"2", "2024-08-16", "10:30 AM", "Kamal Fernando", "Pending"},
                {"3", "2024-08-17", "11:00 AM", "John Doe", "Pending"},
                {"4", "2024-08-18", "02:00 PM", "Jane Smith", "Completed"},
                {"5", "2024-08-19", "03:00 PM", "Michael Silva", "Pending"}
            };

            for (String[] appointment : sampleAppointments) {
                String status = appointment[4];
        %>
        <div class="appointment-card">
            <h4><%= appointment[1] %> at <%= appointment[2] %></h4>
            <p>Patient: <strong><%= appointment[3] %></strong></p>
            <p>Status: <strong><%= status %></strong></p>
            <div class="actions">
                <%
                    if ("Pending".equals(status)) {
                %>
                <form method="post" action="doctorDashboard.jsp" style="display:inline;">
                    <input type="hidden" name="appointmentId" value="<%= appointment[0] %>">
                    <button type="submit" name="markCompleted">Mark as Completed</button>
                </form>
                <%
                    }
                %>
                <a href="viewPatientDetails.jsp?patientId=<%= appointment[0] %>">View Details</a> |
                <a href="rescheduleAppointment.jsp?appointmentId=<%= appointment[0] %>">Reschedule</a> |
                <a href="cancelAppointment.jsp?appointmentId=<%= appointment[0] %>" onclick="return confirm('Are you sure?')">Cancel</a>
            </div>
        </div>
        <%
            }
        %>
    </div>
    <p><%= message %></p>
</div>

</body>
</html>
