package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class payment_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write('\n');
      out.write('\n');

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

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>Make a Payment</title>\n");
      out.write("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/payment.css\">\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<header>\n");
      out.write("    <h1>Payment</h1>\n");
      out.write("</header>\n");
      out.write("\n");
      out.write("<div class=\"container\">\n");
      out.write("    <div class=\"payment-form\">\n");
      out.write("        <h2>Enter Your Payment Details</h2>\n");
      out.write("        <form method=\"post\" action=\"payment.jsp\">\n");
      out.write("            <div class=\"form-group\">\n");
      out.write("                <label for=\"cardNumber\">Card Number:</label>\n");
      out.write("                <input type=\"text\" id=\"cardNumber\" name=\"cardNumber\" required>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"form-group\">\n");
      out.write("                <label for=\"cardHolderName\">Card Holder Name:</label>\n");
      out.write("                <input type=\"text\" id=\"cardHolderName\" name=\"cardHolderName\" required>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"form-group\">\n");
      out.write("                <label for=\"expiryDate\">Expiry Date:</label>\n");
      out.write("                <input type=\"month\" id=\"expiryDate\" name=\"expiryDate\" required>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"form-group\">\n");
      out.write("                <label for=\"cvv\">CVV:</label>\n");
      out.write("                <input type=\"text\" id=\"cvv\" name=\"cvv\" required>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"form-group\">\n");
      out.write("                <label for=\"amount\">Amount:</label>\n");
      out.write("                <input type=\"text\" id=\"amount\" name=\"amount\" value=\"");
      out.print( request.getParameter("amount") );
      out.write("\" required>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"form-group\">\n");
      out.write("                <button type=\"submit\" name=\"submitPayment\">Submit Payment</button>\n");
      out.write("            </div>\n");
      out.write("        </form>\n");
      out.write("        <p>");
      out.print( message );
      out.write("</p>\n");
      out.write("    </div>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
