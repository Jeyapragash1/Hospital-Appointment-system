<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Our Hospital Appointment System allows you to book, reschedule, and cancel your appointments with ease.">
        <title>Hospital Appointment System</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/index.css"/>
    </head>
    <body>

        <nav>
            <a href="index.jsp" class="active">Home</a>
            <a href="aboutUs.jsp">About Us</a>
            <a href="contactUs.jsp">Contact Us</a>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
        </nav>

        
        <!-- Book an Appointment Section -->
        <div class="appointment-container" style="background-image: url('images/book.jpeg');">
            <div class="overlay">
                <h2>Book Your Appointment Now</h2>
                <a href="register.jsp" class="btn btn-primary">Book an Appointment</a>
            </div>
        </div>


        <div class="container">
            <!-- About Our System Section -->
            <div class="content-section">
                <img src="images/R.jpeg" alt="Overview of the Hospital Appointment System" loading="lazy">
                <div class="overlay">
                    <h2>About Our System</h2>
                    <p>Our Hospital Appointment System allows you to book, reschedule, and cancel your appointments with ease.</p>
                    <p>Whether you are a patient seeking medical care or a doctor managing your appointments, our system is designed to simplify the process, ensuring a seamless experience for all users.</p>

                </div>


            </div>

            <!-- Latest Announcements Section -->
            <div class="content-section">
                <img src="images/1.webp" alt="Announcements" loading="lazy">
                <div class="overlay">
                    <h3>Latest Announcements</h3>
                    <p>COVID-19 Vaccination Drive is ongoing. Please make sure to book your slots in advance.</p>
                    <p>New: Telemedicine consultations are now available. Book an online appointment with your doctor.</p>
                </div>
            </div>

            <!-- Our Hospital Section -->
            <div class="content-section">
                <img src="images/2.webp" alt="Hospital Building" loading="lazy">
                <div class="overlay">
                    <h2>Our Hospital</h2>
                    <p>Our hospital is committed to providing top-notch healthcare services to all our patients. With a team of 
                        experienced doctors and modern facilities, we ensure that you receive the best care possible.</p>
                    <p>We are located in the heart of the city, easily accessible by public and private transportation.</p>
                </div>
            </div>

            <!-- Services Section -->
            <div class="content-section">
                <img src="images/service.webp" alt="Medical Services" loading="lazy">
                <div class="overlay">
                    <h2>Our Services</h2>
                    <p>We offer a wide range of medical services, including:</p>
                    <ul style="text-align: left;">
                        <li>General Medicine</li>
                        <li>Pediatrics</li>
                        <li>Cardiology</li>
                        <li>Orthopedics</li>
                        <li>Dermatology</li>
                        <li>Gynecology</li>
                        <li>ENT (Ear, Nose, and Throat)</li>
                    </ul>
                </div>
            </div>

            <!-- Testimonials Section -->
            <div class="content-section">
                <img src="images/3.webp" alt="Happy Patients" loading="lazy">
                <div class="overlay">
                    <h2>What Our Patients Say</h2>
                    <blockquote>"The care I received at this hospital was exceptional. The doctors were attentive and the staff was always ready to help. I highly recommend this hospital to anyone in need of medical care." - Mrs. Lakshmi Perera</blockquote>
                    <blockquote>"I was very impressed with the efficiency and professionalism of the hospital's appointment system. It made managing my medical appointments so much easier." - Mr. Ruwan Jayasinghe</blockquote>
                </div>
            </div>

            <!-- Contact Section -->
            <div class="content-section">
                <img src="images/j.jpeg" alt="Contact Us" loading="lazy">
                <div class="overlay">
                    <h2>Contact Us</h2>
                    <p>If you have any questions or need assistance, please don't hesitate to reach out to us:</p>
                    <ul style="text-align: left;">
                        <li>Phone: +94 11 234 5678</li>
                        <li>Email: info@hospitalappointment.lk</li>
                        <li>Address: 123 Main Street, Colombo, Sri Lanka</li>
                    </ul>
                </div>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 Hospital Appointment System. All rights reserved.</p>
            <p><a href="termsAndConditions.jsp">Terms and Conditions</a> | <a href="privacyPolicy.jsp">Privacy Policy</a></p>
        </footer>

    </body>
</html>
