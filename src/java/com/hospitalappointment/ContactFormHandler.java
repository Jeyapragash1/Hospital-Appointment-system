package com.hospitalappointment;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Annotation to map the Servlet to a URL
@WebServlet("/ContactFormHandler")
public class ContactFormHandler extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        // Validate input
        if (name == null || email == null || message == null || name.isEmpty() || email.isEmpty() || message.isEmpty()) {
            // If validation fails, redirect back to contact page with error
            response.sendRedirect("contactUs.jsp?error=Please+fill+all+fields");
            return;
        }

        // Here you can process the form data, e.g., save it to a database or send an email
        // Example: Send an email
        boolean emailSent = sendEmail(name, email, message);
        
        // Provide user feedback
        if (emailSent) {
            response.sendRedirect("contactUs.jsp?success=Thank+you+for+your+message!");
        } else {
            response.sendRedirect("contactUs.jsp?error=There+was+an+issue+sending+your+message.");
        }
    }

    private boolean sendEmail(String name, String email, String message) {
        // Implement email sending logic here
        // You can use JavaMail API or other libraries to send an email
        // For simplicity, return true to indicate success
        return true;
    }
}
