<%@ page import="com.hospitalappointment.ContactFormHandler" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us - Hospital Appointment System</title>
    <link rel="stylesheet" href="css/contactUs.css"/>
</head>
<body>

<nav>
    <a href="index.jsp">Home</a>
    <a href="aboutUs.jsp">About Us</a>
    <a href="contactUs.jsp">Contact Us</a>
    <a href="login.jsp">Login</a>
    <a href="register.jsp">Register</a>
</nav>

<div class="container">
    <div class="content">
        <h2>Get in Touch</h2>
        <p>If you have any questions or need further information, please do not hesitate to contact us. Our team is here to assist you.</p>

        <h3>Our Location</h3>
        <p>No. 123, Kandy Road, Colombo 07, Sri Lanka</p>

        <h3>Contact Information</h3>
        <p>Email: info@hospital.lk</p>
        <p>Phone: +94-11-2345678</p>
    </div>

    <div class="form-container">
        <h3>Send Us a Message</h3>
      <form action="ContactFormHandler" method="post">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required><br>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required><br>

    <label for="message">Message:</label>
    <textarea id="message" name="message" required></textarea><br>

    <input type="submit" value="Send Message">
</form>


        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String message = request.getParameter("message");

                // Use the ContactFormHandler class to process the data
                ContactFormHandler formHandler = new ContactFormHandler(name, email, message);
                formHandler.processForm();

                out.println("<p>Thank you, " + formHandler.getName() + "! We have received your message and will get back to you at " + formHandler.getEmail() + " soon.</p>");
            }
        %>
    </div>
</div>

<footer>
    <p>&copy; 2024 Hospital Appointment System. All rights reserved.</p>
    <p><a href="termsAndConditions.jsp">Terms and Conditions</a> | <a href="privacyPolicy.jsp">Privacy Policy</a></p>
</footer>

</body>
</html>
