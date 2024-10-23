package com.hospitalappointment;

import org.mindrot.jbcrypt.BCrypt;

public class RegisterService {
    private UserDAO userDAO;

    // Constructor
    public RegisterService() throws SQLException, ClassNotFoundException {
        userDAO = new UserDAO();
    }

    // Method to register a new user
    public String registerUser(String username, String email, String password) {
        try {
            if (userDAO.userExists(username, email)) {
                return "This username or email is already registered. Please log in.";
            }

            // Hash the password before saving it
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            User newUser = new User(username, email, hashedPassword, "patient");
            if (userDAO.saveUser(newUser)) {
                return "Success";
            } else {
                return "Error occurred during registration.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "Database error: " + e.getMessage();
        } finally {
            try {
                userDAO.close();
            } catch (SQLException ignore) {
            }
        }
    }
}
