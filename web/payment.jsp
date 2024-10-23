<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String message = "";
    if (request.getParameter("submitPayment") != null) {
        String patientId = (String) session.getAttribute("user"); // Assuming user session holds patient ID
        String cardNumber = request.getParameter("cardNumber");
        String cardHolderName = request.getParameter("cardHolderName");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");
        String amount = request.getParameter("amount");

        Connection conn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospitalappointmentsystem", "root", "");

            PreparedStatement ps = conn.prepareStatement("INSERT INTO payments (patient_id, card_number, card_holder_name, expiry_date, cvv, amount) VALUES (?, ?, ?, ?, ?, ?)");
            ps.setString(1, patientId);
            ps.setString(2, cardNumber);
            ps.setString(3, cardHolderName);
            ps.setString(4, expiryDate);
            ps.setString(5, cvv);
            ps.setString(6, amount);
            int i = ps.executeUpdate();

            if (i > 0) {
                message = "Payment processed successfully!";
            } else {
                message = "Error occurred while processing the payment.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Database connection error.";
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Make a Payment</title>
    <link rel="stylesheet" type="text/css" href="css/payment.css">
</head>
<body>

<header>
    <h1>Payment</h1>
</header>

<div class="container">
    <div class="payment-form">
        <h2>Enter Your Payment Details</h2>
        <form method="post" action="payment.jsp">
            <div class="form-group">
                <label for="cardNumber">Card Number:</label>
                <input type="text" id="cardNumber" name="cardNumber" required>
            </div>
            <div class="form-group">
                <label for="cardHolderName">Card Holder Name:</label>
                <input type="text" id="cardHolderName" name="cardHolderName" required>
            </div>
            <div class="form-group">
                <label for="expiryDate">Expiry Date:</label>
                <input type="month" id="expiryDate" name="expiryDate" required>
            </div>
            <div class="form-group">
                <label for="cvv">CVV:</label>
                <input type="text" id="cvv" name="cvv" required>
            </div>
            <div class="form-group">
                <label for="amount">Amount:</label>
                <input type="text" id="amount" name="amount" value="<%= request.getParameter("amount") %>" required>
            </div>
            <div class="form-group">
                <button type="submit" name="submitPayment">Submit Payment</button>
            </div>
        </form>
        <p><%= message %></p>
    </div>
</div>

</body>
</html>
