<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    String patientId = (String) session.getAttribute("user"); // Assuming user session holds patient ID

    Connection conn = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");

        // Handle Reschedule Request
        if (request.getParameter("rescheduleAppointment") != null) {
            String appointmentId = request.getParameter("appointmentId");
            String newDate = request.getParameter("newDate");
            String newTime = request.getParameter("newTime");

            PreparedStatement ps = conn.prepareStatement("UPDATE appointment SET appointment_date = ?, appointment_time = ? WHERE appointment_ID = ? AND patient_id = ?");
            ps.setString(1, newDate);
            ps.setString(2, newTime);
            ps.setString(3, appointmentId);
            ps.setString(4, patientId);
            int i = ps.executeUpdate();

            if (i > 0) {
                message = "Appointment rescheduled successfully!";
            } else {
                message = "Error occurred while rescheduling the appointment.";
            }
        }

        PreparedStatement ps = conn.prepareStatement("SELECT a.appointment_ID, a.appointment_date, a.appointment_time, d.name AS doctor_name "
                                                   + "FROM appointment a JOIN doctor d ON a.doctor_id = d.doctor_id "
                                                   + "WHERE a.patient_id = ? AND a.appointment_date >= CURDATE() "
                                                   + "ORDER BY a.appointment_date ASC");
        ps.setString(1, patientId);
        ResultSet rs = ps.executeQuery();

        request.setAttribute("appointments", rs);

    } catch (Exception e) {
        e.printStackTrace();
        message = "Database connection error.";
    } finally {
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reschedule Appointment</title>
    <link rel="stylesheet" type="text/css" href="css/rescheduleAppointment.css">
</head>
<body>

<header>
    <h1>Reschedule Appointment</h1>
</header>

<div class="container">
    <div class="appointment-list">
        <h2>Select an Appointment to Reschedule</h2>
        <%
            ResultSet appointments = (ResultSet) request.getAttribute("appointments");
            if (appointments != null && appointments.next()) {
                out.println("<table>");
                out.println("<tr><th>Date</th><th>Time</th><th>Doctor</th><th>Action</th></tr>");
                do {
                    out.println("<tr>");
                    out.println("<td>" + appointments.getString("appointment_date") + "</td>");
                    out.println("<td>" + appointments.getString("appointment_time") + "</td>");
                    out.println("<td>" + appointments.getString("doctor_name") + "</td>");
                    out.println("<td>");
                    out.println("<form method='post' action='rescheduleAppointment.jsp'>");
                    out.println("<input type='hidden' name='appointmentId' value='" + appointments.getString("appointment_ID") + "'>");
                    out.println("<label for='newDate'>New Date:</label>");
                    out.println("<input type='date' id='newDate' name='newDate' required>");
                    out.println("<label for='newTime'>New Time:</label>");
                    out.println("<input type='time' id='newTime' name='newTime' required>");
                    out.println("<button type='submit' name='rescheduleAppointment'>Reschedule</button>");
                    out.println("</form>");
                    out.println("</td>");
                    out.println("</tr>");
                } while (appointments.next());
                out.println("</table>");
            } else {
                out.println("<p>No upcoming appointments found.</p>");
            }
        %>
        <p><%= message %></p>
    </div>
</div>

</body>
</html>
