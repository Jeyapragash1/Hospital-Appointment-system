<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Appointment History - Hospital Appointment System</title>
    <link rel="stylesheet" type="text/css" href="css/appointmentHistory.css">
</head>
<body>

<header>
    <h1>Appointment History</h1>
</header>

<div class="container">
    <div class="history">
        <h2>Your Past Appointments</h2>
        <div class="history-table">
            <%
                String patientId = (String) session.getAttribute("patientId"); // Assuming patient ID is stored in session
                String query = "SELECT a.appointment_date, a.appointment_time, d.name AS doctor_name, dep.department_name "
                             + "FROM appointment a "
                             + "JOIN doctor d ON a.doctor_id = d.doctor_id "
                             + "JOIN department dep ON d.department_id = dep.department_id "
                             + "WHERE a.patient_id = ? AND a.appointment_date < CURDATE() "
                             + "ORDER BY a.appointment_date DESC";

                Connection conn = null;
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
                    PreparedStatement ps = conn.prepareStatement(query);
                    ps.setString(1, patientId);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        out.println("<table>");
                        out.println("<tr><th>Date</th><th>Time</th><th>Doctor</th><th>Department</th></tr>");
                        do {
                            out.println("<tr>");
                            out.println("<td>" + rs.getString("appointment_date")+ "</td>");
                            out.println("<td>" + rs.getString("appointment_time") + "</td>");
                            out.println("<td>" + rs.getString("doctor_name") + "</td>");
                            out.println("<td>" + rs.getString("department_name") + "</td>");
                            out.println("</tr>");
                        } while (rs.next());
                        out.println("</table>");
                    } else {
                        out.println("<p>No past appointments found.</p>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("Error retrieving appointment history: " + e.getMessage());
                } finally {
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            %>
        </div>
    </div>
</div>

</body>
</html>
