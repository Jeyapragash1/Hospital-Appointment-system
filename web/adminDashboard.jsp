<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Hospital Appointment System</title>
    <link rel="stylesheet" href="css/adminDashboard.css"/>
</head>
<body>

<header>
    <h1>Admin Dashboard</h1>
</header>

<div class="container">
    <div class="dashboard">
        <div class="dashboard-section">
            <h3>Manage Appointments</h3>
            <p>View and manage all patient appointments.</p>
            <a href="manageAppointments.jsp" class="button">Manage Appointments</a>
        </div>
        <div class="dashboard-section">
            <h3>Manage Doctors</h3>
            <p>Add, edit, or remove doctors from the system.</p>
            <a href="manageDoctors.jsp" class="button">Manage Doctors</a>
        </div>
        <div class="dashboard-section">
            <h3>Manage Departments</h3>
            <p>Manage hospital departments and their associated doctors.</p>
            <a href="manageDepartments.jsp" class="button">Manage Departments</a>
        </div>
        <div class="dashboard-section">
            <h3>View Reports</h3>
            <p>Generate and view reports on hospital operations.</p>
            <a href="adminReports.jsp" class="button">View Reports</a>
        </div>
        <div class="dashboard-section">
            <h3>Manage Profile</h3>
            <p>Update your admin profile and change password.</p>
            <a href="manageProfile.jsp" class="button">Manage Profile</a>
        </div>
        <div class="dashboard-section">
            <h3>Logout</h3>
            <p>Log out from the admin dashboard.</p>
            <a href="logout.jsp" class="button">Logout</a>
        </div>
    </div>
</div>

<footer>
    <p>&copy; 2024 Hospital Appointment System. All rights reserved.</p>
</footer>

</body>
</html>
