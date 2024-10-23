<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Reports - Hospital Appointment System</title>
   <link rel="stylesheet" href="css/adminReports.css"/>
       
   
</head>
<body>

<header>
    <h1>Admin Reports</h1>
</header>

<div class="container">
    <div class="reports">
        <h2>Generate Reports</h2>
        
        <!-- Report: All Appointments -->
        <div class="report-section">
            <h3>All Appointments</h3>
            <p>Generate a report of all appointments in the system.</p>
            <form method="post" action="adminReports.jsp">
                <button type="submit" name="appointmentsReport">Generate Report</button>
            </form>
        </div>
        
        <!-- Report: Doctors -->
        <div class="report-section">
            <h3>Doctors</h3>
            <p>Generate a report of all doctors in the system.</p>
            <form method="post" action="adminReports.jsp">
                <button type="submit" name="doctorsReport">Generate Report</button>
            </form>
        </div>
        
        <!-- Report: Departments -->
        <div class="report-section">
            <h3>Departments</h3>
            <p>Generate a report of all departments in the hospital.</p>
            <form method="post" action="adminReports.jsp">
                <button type="submit" name="departmentsReport">Generate Report</button>
            </form>
        </div>

        <!-- Report: Custom Queries -->
        <div class="report-section">
            <h3>Custom Report</h3>
            <p>Generate a custom report based on specific criteria.</p>
            <form method="post" action="adminReports.jsp">
                <input type="text" name="customQuery" placeholder="Enter SQL Query">
                <button type="submit" name="customReport">Generate Report</button>
            </form>
        </div>

        <div class="report-output">
            <h3>Report Output</h3>
            <%
                String query = null;

                if (request.getParameter("appointmentsReport") != null) {
                    query = "SELECT * FROM appointment";
                } else if (request.getParameter("doctorsReport") != null) {
                    query = "SELECT * FROM doctor";
                } else if (request.getParameter("departmentsReport") != null) {
                    query = "SELECT * FROM department";
                } else if (request.getParameter("customReport") != null) {
                    query = request.getParameter("customQuery");
                }

                if (query != null) {
                    Connection conn = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(query);

                        ResultSetMetaData rsmd = rs.getMetaData();
                        int columnsNumber = rsmd.getColumnCount();

                        out.println("<table><tr>");
                        for (int i = 1; i <= columnsNumber; i++) {
                            out.println("<th>" + rsmd.getColumnName(i) + "</th>");
                        }
                        out.println("</tr>");

                        while (rs.next()) {
                            out.println("<tr>");
                            for (int i = 1; i <= columnsNumber; i++) {
                                out.println("<td>" + rs.getString(i) + "</td>");
                            }
                            out.println("</tr>");
                        }
                        out.println("</table>");
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("Error generating report: " + e.getMessage());
                    } finally {
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                }
            %>
        </div>
    </div>
</div>

</body>
</html>
