package com.ahmetcan.schedulerapi.service;

import com.ahmetcan.schedulerapi.model.Token;
import com.ahmetcan.schedulerapi.model.User;
import com.ahmetcan.schedulerapi.repository.TokenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Optional;
import java.util.UUID;

@Service
public class TokenService {

    @Autowired
    private TokenRepository tokenRepository;

    private String hashToken(String token) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = digest.digest(token.getBytes());
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Hashing algorithm not found", e);
        }
    }

    public String generateToken(User user, String deviceInfo) {
        String tokenStr = UUID.randomUUID().toString();
        String hashedToken = hashToken(tokenStr);
        Token token = new Token(user, hashedToken, deviceInfo);
        tokenRepository.save(token);
        return tokenStr;
    }

    public Optional<Token> findByToken(String token) {
        String hashedToken = hashToken(token);
        return tokenRepository.findByToken(hashedToken);
    }

    public void deleteByToken(String token) {
        String hashedToken = hashToken(token);
        tokenRepository.deleteByToken(hashedToken);
    }
}
