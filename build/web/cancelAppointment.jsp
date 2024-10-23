<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    String patientId = (String) session.getAttribute("user"); // Assuming user session holds patient ID

    // Handle the cancellation request
    if (request.getParameter("cancelAppointment") != null) {
        String appointmentId = request.getParameter("appointmentId");

        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
            PreparedStatement ps = conn.prepareStatement("DELETE FROM appointment WHERE appointment_ID = ? AND patient_id = ?");
            ps.setString(1, appointmentId);
            ps.setString(2, patientId);
            int i = ps.executeUpdate();

            if (i > 0) {
                message = "Appointment cancelled successfully!";
            } else {
                message = "Error occurred while cancelling the appointment.";
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
    <title>Cancel Appointment</title>
    <link rel="stylesheet" href="css/cancelAppointment.css"/>
</head>
<body>

<header>
    <h1>Cancel Appointment</h1>
</header>

<div class="container">
    <div class="appointment-list">
        <h2>Your Upcoming Appointments</h2>
        <%
            Connection conn = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT a.appointment_ID, a.appointment_date, a.appointment_time, d.name AS doctor_name " +
                    "FROM appointment a JOIN doctor d ON a.doctor_id = d.doctor_ID " +
                    "WHERE a.patient_id = ? AND a.appointment_date >= CURDATE() " +
                    "ORDER BY a.appointment_date ASC"
                );
                ps.setString(1, patientId);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    out.println("<table>");
                    out.println("<tr><th>Date</th><th>Time</th><th>Doctor</th><th>Action</th></tr>");
                    do {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("appointment_date") + "</td>");
                        out.println("<td>" + rs.getString("appointment_time") + "</td>");
                        out.println("<td>" + rs.getString("doctor_name") + "</td>");
                        out.println("<td>");
                        out.println("<form method='post' action='cancelAppointment.jsp'>");
                        out.println("<input type='hidden' name='appointmentId' value='" + rs.getString("appointment_ID") + "'>");
                        out.println("<button type='submit' name='cancelAppointment'>Cancel</button>");
                        out.println("</form>");
                        out.println("</td>");
                        out.println("</tr>");
                    } while (rs.next());
                    out.println("</table>");
                } else {
                    out.println("<p>No upcoming appointments found.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error retrieving appointments: " + e.getMessage());
            } finally {
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
        <p><%= message %></p>
    </div>
</div>



</body>
</html>
