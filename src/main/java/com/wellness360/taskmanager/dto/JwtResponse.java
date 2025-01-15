package com.wellness360.taskmanager.dto;
//Represents the response containing a JWT token after successful authentication.
public class JwtResponse {
    private String token;

    // Constructor
    public JwtResponse(String token) {
        this.token = token;
    }

    // Getter and setter
    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
