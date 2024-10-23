<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Appointments</title>
    <link rel="stylesheet" type="text/css" href="css/manageAppointments.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        header {
            background-color: #333;
            color: #fff;
            padding: 10px 0;
            text-align: center;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        h1 {
            margin: 0 0 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #ddd;
        }
        .actions {
            text-align: center;
        }
        .actions a {
            color: #fff;
            background-color: #4CAF50;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
            margin: 0 5px;
        }
        .actions a.delete {
            background-color: #f44336;
        }
    </style>
</head>
<body>

<header>
    <h1>Manage Appointments</h1>
</header>

<div class="container">
    <h2>Your Appointments</h2>
    <table>
        <tr>
            <th>Doctor</th>
            <th>Date</th>
            <th>Time</th>
            <th>Actions</th>
        </tr>
        <%
            // Sample data for testing
            String[][] sampleData = {
                {"Dr. Sunil Jayasinghe", "2024-08-01", "10:00 AM", "1"},
                {"Dr. Malini Weerasinghe", "2024-08-02", "11:00 AM", "2"},
                {"Dr. Anura Dissanayake", "2024-07-15", "09:30 AM", "3"},
                {"Dr. Sunil Jayasinghe", "2024-06-22", "02:00 PM", "4"},
                {"Dr. Malini Weerasinghe", "2024-06-23", "03:00 PM", "5"}
            };

            for (String[] appointment : sampleData) {
        %>
            <tr>
                <td><%= appointment[0] %></td>
                <td><%= appointment[1] %></td>
                <td><%= appointment[2] %></td>
                <td class="actions">
                    <a href="editAppointment.jsp?appointmentId=<%= appointment[3] %>">Edit</a>
                    <a href="deleteAppointment.jsp?appointmentId=<%= appointment[3] %>" class="delete" onclick="return confirm('Are you sure you want to delete this appointment?');">Delete</a>
                </td>
            </tr>
        <%
            }
        %>
    </table>
</div>

</body>
</html>
