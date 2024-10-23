<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String appointmentId = request.getParameter("appointmentId");
    String message = "";

    if (appointmentId != null && !appointmentId.isEmpty()) {
        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
            PreparedStatement ps = conn.prepareStatement("DELETE FROM appointment WHERE appointment_ID = ?");
            ps.setString(1, appointmentId);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                message = "Appointment deleted successfully.";
            } else {
                message = "Failed to delete the appointment.";
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
