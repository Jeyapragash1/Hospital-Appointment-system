<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    if (request.getParameter("submit") != null) {
        String patientId = (String) session.getAttribute("user"); // Assuming user session holds patient ID
        String doctorId = request.getParameter("doctorId");
        String appointmentDate = request.getParameter("appointmentDate");
        String appointmentTime = request.getParameter("appointmentTime");

        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
            PreparedStatement ps = conn.prepareStatement("INSERT INTO appointment (patient_id, doctor_id, appointment_date, appointment_time) VALUES (?, ?, ?, ?)");
            ps.setString(1, patientId);
            ps.setString(2, doctorId);
            ps.setString(3, appointmentDate);
            ps.setString(4, appointmentTime);
            int i = ps.executeUpdate();

            if (i > 0) {
                message = "Appointment booked successfully!";
            } else {
                message = "Error occurred while booking the appointment. Please try again.";
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
    <title>Book Appointment</title>
    <link rel="stylesheet" href="css/bookAppointment.css"/>
</head>
<body>

<header>
    <h1>Book an Appointment</h1>
</header>

<div class="container">
    <div class="appointment-form">
        <h2>Fill in your details</h2>
        <form method="post" action="bookAppointment.jsp">
            <div class="form-group">
                <label for="doctorId">Doctor:</label>
                <select id="doctorId" name="doctorId" required>
                    <option value="">Select Doctor</option>
                    <% 
                        Connection conn = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
                            PreparedStatement ps = conn.prepareStatement("SELECT doctor_ID, name FROM doctor WHERE availability = 1");
                            ResultSet rs = ps.executeQuery();
                            while (rs.next()) {
                    %>
                                <option value="<%= rs.getString("doctor_ID") %>"><%= rs.getString("name") %></option>
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
                <input type="date" id="appointmentDate" name="appointmentDate" required>
            </div>
            <div class="form-group">
                <label for="appointmentTime">Time:</label>
                <input type="time" id="appointmentTime" name="appointmentTime" required>
            </div>
            <div class="form-group">
                <button type="submit" name="submit">Book Appointment</button>
            </div>
        </form>
        <p><%= message %></p>
    </div>
</div>

<footer>
    <p>&copy; 2024 Hospital Appointment System. All rights reserved.</p>
    <p><a href="termsAndConditions.jsp">Terms and Conditions</a> | <a href="privacyPolicy.jsp">Privacy Policy</a></p>
</footer>

</body>
</html>
