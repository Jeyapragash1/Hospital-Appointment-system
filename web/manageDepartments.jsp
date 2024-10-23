<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    Connection conn = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");

        // Handle Add Department
        if (request.getParameter("addDepartment") != null) {
            String departmentName = request.getParameter("departmentName");
            String description = request.getParameter("description");

            PreparedStatement ps = conn.prepareStatement("INSERT INTO department (department_name, description) VALUES (?, ?)");
            ps.setString(1, departmentName);
            ps.setString(2, description);
            int i = ps.executeUpdate();

            if (i > 0) {
                message = "Department added successfully!";
            } else {
                message = "Error occurred while adding the department.";
            }
        }

        // Handle Delete Department
        if (request.getParameter("deleteDepartment") != null) {
            String departmentId = request.getParameter("departmentId");

            PreparedStatement ps = conn.prepareStatement("DELETE FROM department WHERE department_id = ?");
            ps.setString(1, departmentId);
            int i = ps.executeUpdate();

            if (i > 0) {
                message = "Department deleted successfully!";
            } else {
                message = "Error occurred while deleting the department.";
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        message = "Database connection error.";
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ignore) {
            }
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Departments</title>
        <link rel="stylesheet" type="text/css" href="css/manageDepartments.css">
    </head>
    <body>

        <header>
            <h1>Manage Departments</h1>
        </header>

        <div class="container">
            <div class="add-department">
                <h2>Add New Department</h2>
                <form method="post" action="manageDepartments.jsp">
                    <div class="form-group">
                        <label for="departmentName">Department Name:</label>
                        <input type="text" id="departmentName" name="departmentName" required>
                    </div>
                    <div class="form-group">
                        <label for="description">Description:</label>
                        <textarea id="description" name="description" rows="4" required></textarea>
                    </div>
                    <div class="form-group">
                        <button type="submit" name="addDepartment">Add Department</button>
                    </div>
                </form>
            </div>

            <div class="department-list">
                <h2>Existing Departments</h2>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM department");

                        if (rs.next()) {
                            out.println("<table>");
                            out.println("<tr><th>Department Name</th><th>Description</th><th>Action</th></tr>");
                            do {
                                out.println("<tr>");
                                out.println("<td>" + rs.getString("department_name") + "</td>");
                                out.println("<td>" + rs.getString("description") + "</td>");
                                out.println("<td>");
                                out.println("<form method='post' action='manageDepartments.jsp' style='display:inline;'>");
                                out.println("<input type='hidden' name='departmentId' value='" + rs.getString("department_id") + "'>");
                                out.println("<button type='submit' name='deleteDepartment'>Delete</button>");
                                out.println("</form>");
                                out.println("</td>");
                                out.println("</tr>");
                            } while (rs.next());
                            out.println("</table>");
                        } else {
                            out.println("<p>No departments found.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("Error retrieving departments: " + e.getMessage());
                    } finally {
                        if (conn != null) {
                            try {
                                conn.close();
                            } catch (SQLException ignore) {
                            }
                        }
                    }
                %>
            </div>

            <p><%= message%></p>
        </div>

    </body>
</html>
