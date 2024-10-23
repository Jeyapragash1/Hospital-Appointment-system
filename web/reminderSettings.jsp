<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    String patientId = (String) session.getAttribute("user"); // Assuming user session holds patient ID

    Connection conn = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");

        if (request.getParameter("saveSettings") != null) {
            String emailReminder = request.getParameter("emailReminder");
            String smsReminder = request.getParameter("smsReminder");
            String pushNotification = request.getParameter("pushNotification");

            PreparedStatement ps = conn.prepareStatement("UPDATE reminder_settings SET email_reminder = ?, sms_reminder = ?, push_notification = ? WHERE patient_id = ?");
            ps.setString(1, emailReminder != null ? "yes" : "no");
            ps.setString(2, smsReminder != null ? "yes" : "no");
            ps.setString(3, pushNotification != null ? "yes" : "no");
            ps.setString(4, patientId);
            int i = ps.executeUpdate();

            if (i > 0) {
                message = "Reminder settings updated successfully!";
            } else {
                message = "Error occurred while updating reminder settings.";
            }
        }

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM reminder_settings WHERE patient_id = ?");
        ps.setString(1, patientId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            request.setAttribute("emailReminder", rs.getString("email_reminder"));
            request.setAttribute("smsReminder", rs.getString("sms_reminder"));
            request.setAttribute("pushNotification", rs.getString("push_notification"));
        }

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
    <title>Reminder Settings</title>
    <link rel="stylesheet" type="text/css" href="css/reminderSettings.css">
</head>
<body>

<header>
    <h1>Reminder Settings</h1>
</header>

<div class="container">
    <div class="settings-form">
        <h2>Manage Your Reminder Preferences</h2>
        <form method="post" action="reminderSettings.jsp">
            <div class="form-group">
                <label>
                    <input type="checkbox" name="emailReminder" <%= "yes".equals(request.getAttribute("emailReminder")) ? "checked" : "" %>> Email Reminders
                </label>
            </div>
            <div class="form-group">
                <label>
                    <input type="checkbox" name="smsReminder" <%= "yes".equals(request.getAttribute("smsReminder")) ? "checked" : "" %>> SMS Reminders
                </label>
            </div>
            <div class="form-group">
                <label>
                    <input type="checkbox" name="pushNotification" <%= "yes".equals(request.getAttribute("pushNotification")) ? "checked" : "" %>> Push Notifications
                </label>
            </div>
            <div class="form-group">
                <button type="submit" name="saveSettings">Save Settings</button>
            </div>
        </form>
        <p><%= message %></p>
    </div>
</div>

</body>
</html>
