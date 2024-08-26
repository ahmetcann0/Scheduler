package com.ahmetcan.schedulerapi.service;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class TokenHashingService {

    private final PasswordEncoder passwordEncoder;

    public TokenHashingService(){
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    public String hashToken(String token){
        return passwordEncoder.encode(token);
    }

    public boolean verifyToken(String rawToken, String hashedToken){
        return passwordEncoder.matches(rawToken,hashedToken);
    }
}
