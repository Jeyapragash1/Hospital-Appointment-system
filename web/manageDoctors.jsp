<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    Connection conn = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");

        // Handle Add Doctor
        if (request.getParameter("addDoctor") != null) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String departmentId = request.getParameter("departmentId");
            String specialization = request.getParameter("specialization");

            PreparedStatement ps = conn.prepareStatement("INSERT INTO doctor (name, email, department_id, specialization) VALUES (?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, departmentId);
            ps.setString(4, specialization);
            int i = ps.executeUpdate();

            if (i > 0) {
                message = "Doctor added successfully!";
            } else {
                message = "Error occurred while adding the doctor.";
            }
        }

        // Handle Delete Doctor
        if (request.getParameter("deleteDoctor") != null) {
            String doctorId = request.getParameter("doctorId");

            PreparedStatement ps = conn.prepareStatement("DELETE FROM doctor WHERE doctor_id = ?");
            ps.setString(1, doctorId);
            int i = ps.executeUpdate();

            if (i > 0) {
                message = "Doctor deleted successfully!";
            } else {
                message = "Error occurred while deleting the doctor.";
            }
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
    <title>Manage Doctors</title>
    <link rel="stylesheet" type="text/css" href="css/manageDoctors.css">
</head>
<body>

<header>
    <h1>Manage Doctors</h1>
</header>

<div class="container">
    <div class="add-doctor">
        <h2>Add New Doctor</h2>
        <form method="post" action="manageDoctors.jsp">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="departmentId">Department:</label>
                <select id="departmentId" name="departmentId" required>
                    <option value="">Select Department</option>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT department_id, department_name FROM department");

                            while (rs.next()) {
                                out.println("<option value='" + rs.getString("department_id") + "'>" + rs.getString("department_name") + "</option>");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("<option value=''>Error loading departments</option>");
                        } finally {
                            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                        }
                    %>
                </select>
            </div>
            <div class="form-group">
                <label for="specialization">Specialization:</label>
                <input type="text" id="specialization" name="specialization">
            </div>
            <div class="form-group">
                <button type="submit" name="addDoctor">Add Doctor</button>
            </div>
        </form>
    </div>

    <div class="doctor-list">
        <h2>Existing Doctors</h2>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT d.doctor_id, d.name, d.email, dep.department_name, d.specialization "
                                                + "FROM doctor d JOIN department dep ON d.department_id = dep.department_id");

                if (rs.next()) {
                    out.println("<table>");
                    out.println("<tr><th>Name</th><th>Email</th><th>Department</th><th>Specialization</th><th>Action</th></tr>");
                    do {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("name") + "</td>");
                        out.println("<td>" + rs.getString("email") + "</td>");
                        out.println("<td>" + rs.getString("department_name") + "</td>");
                        out.println("<td>" + rs.getString("specialization") + "</td>");
                        out.println("<td>");
                        out.println("<form method='post' action='manageDoctors.jsp' style='display:inline;'>");
                        out.println("<input type='hidden' name='doctorId' value='" + rs.getString("doctor_id") + "'>");
                        out.println("<button type='submit' name='deleteDoctor'>Delete</button>");
                        out.println("</form>");
                        out.println("</td>");
                        out.println("</tr>");
                    } while (rs.next());
                    out.println("</table>");
                } else {
                    out.println("<p>No doctors found.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error retrieving doctors: " + e.getMessage());
            } finally {
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </div>

    <p><%= message %></p>
</div>

</body>
</html>
