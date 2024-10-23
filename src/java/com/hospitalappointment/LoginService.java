package com.hospitalappointment;

import java.sql.SQLException;

public class LoginService {
    private UserDAO userDAO;

    // Constructor
    public LoginService() throws SQLException, ClassNotFoundException {
        userDAO = new UserDAO();
    }

    // Method to validate user login
    public User login(String email, String password) {
        try {
            return userDAO.validateUser(email, password);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                userDAO.close();
            } catch (SQLException ignore) {
            }
        }
    }
}
