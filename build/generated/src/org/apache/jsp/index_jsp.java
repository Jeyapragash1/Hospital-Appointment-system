package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("    <head>\n");
      out.write("        <meta charset=\"UTF-8\">\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("        <meta name=\"description\" content=\"Our Hospital Appointment System allows you to book, reschedule, and cancel your appointments with ease.\">\n");
      out.write("        <title>Hospital Appointment System</title>\n");
      out.write("        <link href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/index.css\"/>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("        <nav>\n");
      out.write("            <a href=\"index.jsp\" class=\"active\">Home</a>\n");
      out.write("            <a href=\"aboutUs.jsp\">About Us</a>\n");
      out.write("            <a href=\"contactUs.jsp\">Contact Us</a>\n");
      out.write("            <a href=\"login.jsp\">Login</a>\n");
      out.write("            <a href=\"register.jsp\">Register</a>\n");
      out.write("        </nav>\n");
      out.write("\n");
      out.write("        <!-- Book an Appointment Section -->\n");
      out.write("        <!-- Book an Appointment Section -->\n");
      out.write("        <div class=\"appointment-container\" style=\"background-image: url('images/book.jpeg');\">\n");
      out.write("            <div class=\"overlay\">\n");
      out.write("                <h2>Book Your Appointment Now</h2>\n");
      out.write("                <a href=\"register.jsp\" class=\"btn btn-primary\">Book an Appointment</a>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("        <div class=\"container\">\n");
      out.write("            <!-- About Our System Section -->\n");
      out.write("            <div class=\"content-section\">\n");
      out.write("                <img src=\"images/R.jpeg\" alt=\"Overview of the Hospital Appointment System\" loading=\"lazy\">\n");
      out.write("                <div class=\"overlay\">\n");
      out.write("                    <h2>About Our System</h2>\n");
      out.write("                    <p>Our Hospital Appointment System allows you to book, reschedule, and cancel your appointments with ease.</p>\n");
      out.write("                    <p>Whether you are a patient seeking medical care or a doctor managing your appointments, our system is designed to simplify the process, ensuring a seamless experience for all users.</p>\n");
      out.write("\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <!-- Latest Announcements Section -->\n");
      out.write("            <div class=\"content-section\">\n");
      out.write("                <img src=\"images/1.webp\" alt=\"Announcements\" loading=\"lazy\">\n");
      out.write("                <div class=\"overlay\">\n");
      out.write("                    <h3>Latest Announcements</h3>\n");
      out.write("                    <p>COVID-19 Vaccination Drive is ongoing. Please make sure to book your slots in advance.</p>\n");
      out.write("                    <p>New: Telemedicine consultations are now available. Book an online appointment with your doctor.</p>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <!-- Our Hospital Section -->\n");
      out.write("            <div class=\"content-section\">\n");
      out.write("                <img src=\"images/2.webp\" alt=\"Hospital Building\" loading=\"lazy\">\n");
      out.write("                <div class=\"overlay\">\n");
      out.write("                    <h2>Our Hospital</h2>\n");
      out.write("                    <p>Our hospital is committed to providing top-notch healthcare services to all our patients. With a team of \n");
      out.write("                        experienced doctors and modern facilities, we ensure that you receive the best care possible.</p>\n");
      out.write("                    <p>We are located in the heart of the city, easily accessible by public and private transportation.</p>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <!-- Services Section -->\n");
      out.write("            <div class=\"content-section\">\n");
      out.write("                <img src=\"images/service.webp\" alt=\"Medical Services\" loading=\"lazy\">\n");
      out.write("                <div class=\"overlay\">\n");
      out.write("                    <h2>Our Services</h2>\n");
      out.write("                    <p>We offer a wide range of medical services, including:</p>\n");
      out.write("                    <ul style=\"text-align: left;\">\n");
      out.write("                        <li>General Medicine</li>\n");
      out.write("                        <li>Pediatrics</li>\n");
      out.write("                        <li>Cardiology</li>\n");
      out.write("                        <li>Orthopedics</li>\n");
      out.write("                        <li>Dermatology</li>\n");
      out.write("                        <li>Gynecology</li>\n");
      out.write("                        <li>ENT (Ear, Nose, and Throat)</li>\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <!-- Testimonials Section -->\n");
      out.write("            <div class=\"content-section\">\n");
      out.write("                <img src=\"images/3.webp\" alt=\"Happy Patients\" loading=\"lazy\">\n");
      out.write("                <div class=\"overlay\">\n");
      out.write("                    <h2>What Our Patients Say</h2>\n");
      out.write("                    <blockquote>\"The care I received at this hospital was exceptional. The doctors were attentive and the staff was always ready to help. I highly recommend this hospital to anyone in need of medical care.\" - Mrs. Lakshmi Perera</blockquote>\n");
      out.write("                    <blockquote>\"I was very impressed with the efficiency and professionalism of the hospital's appointment system. It made managing my medical appointments so much easier.\" - Mr. Ruwan Jayasinghe</blockquote>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <!-- Contact Section -->\n");
      out.write("            <div class=\"content-section\">\n");
      out.write("                <img src=\"images/j.jpeg\" alt=\"Contact Us\" loading=\"lazy\">\n");
      out.write("                <div class=\"overlay\">\n");
      out.write("                    <h2>Contact Us</h2>\n");
      out.write("                    <p>If you have any questions or need assistance, please don't hesitate to reach out to us:</p>\n");
      out.write("                    <ul style=\"text-align: left;\">\n");
      out.write("                        <li>Phone: +94 11 234 5678</li>\n");
      out.write("                        <li>Email: info@hospitalappointment.lk</li>\n");
      out.write("                        <li>Address: 123 Main Street, Colombo, Sri Lanka</li>\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <footer>\n");
      out.write("            <p>&copy; 2024 Hospital Appointment System. All rights reserved.</p>\n");
      out.write("            <p><a href=\"termsAndConditions.jsp\">Terms and Conditions</a> | <a href=\"privacyPolicy.jsp\">Privacy Policy</a></p>\n");
      out.write("        </footer>\n");
      out.write("\n");
      out.write("    </body>\n");
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
