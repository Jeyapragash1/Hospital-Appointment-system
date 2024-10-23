<%@ page isErrorPage="true" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - Hospital Appointment System</title>
    <link rel="stylesheet" type="text/css" href="css/error.css">
</head>
<body>

<header>
    <h1>Oops! Something went wrong.</h1>
</header>

<div class="container">
    <div class="error-message">
        <h2>An unexpected error occurred.</h2>
        <p>We apologize for the inconvenience. Please try again later.</p>
        <p>If the problem persists, contact our support team.</p>
        <p><strong>Error Details:</strong> <%= exception.getMessage() %></p>
    </div>
    <div class="error-actions">
        <a href="index.jsp" class="button">Go to Home Page</a>
        <a href="contactUs.jsp" class="button">Contact Support</a>
    </div>
</div>

<footer>
    <p>&copy; 2024 Hospital Appointment System. All rights reserved.</p>
    <p><a href="termsAndConditions.jsp">Terms and Conditions</a> | <a href="privacyPolicy.jsp">Privacy Policy</a></p>
</footer>

</body>
</html>
