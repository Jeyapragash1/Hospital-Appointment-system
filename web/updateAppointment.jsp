<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String appointmentId = request.getParameter("appointmentId");
    String doctorId = request.getParameter("doctorId");
    String appointmentDate = request.getParameter("appointmentDate");
    String appointmentTime = request.getParameter("appointmentTime");
    String message = "";

    if (appointmentId != null && !appointmentId.isEmpty()) {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
            PreparedStatement ps = conn.prepareStatement("UPDATE appointment SET doctor_id = ?, appointment_date = ?, appointment_time = ? WHERE appointment_ID = ?");
            ps.setString(1, doctorId);
            ps.setString(2, appointmentDate);
            ps.setString(3, appointmentTime);
            ps.setString(4, appointmentId);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                message = "Appointment updated successfully.";
            } else {
                message = "Failed to update the appointment.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Database connection error: " + e.getMessage();
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }

        response.sendRedirect("manageAppointments.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
    } else {
        message = "Invalid appointment ID.";
        response.sendRedirect("manageAppointments.jsp?message=" + java.net.URLEncoder.encode(message, "UTF-8"));
    }
%>
