package com.ahmetcan.schedulerapi.controller;

import com.ahmetcan.schedulerapi.dto.UserCreateRequest;
import com.ahmetcan.schedulerapi.exception.InvalidCredentialsException;
import com.ahmetcan.schedulerapi.exception.UserAlreadyExistsException;
import com.ahmetcan.schedulerapi.model.User;
import com.ahmetcan.schedulerapi.service.TokenService;
import com.ahmetcan.schedulerapi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService userService;
    private final TokenService tokenService;

    // Constructor injection
    public UserController(UserService userService, TokenService tokenService) {
        this.userService = userService;
        this.tokenService = tokenService;
    }

    @PostMapping("/register")
    public ResponseEntity<?> createUser(@RequestBody UserCreateRequest userCreateRequest) {
        try {
            User createdUser = userService.createUser(userCreateRequest.getEmail(), userCreateRequest.getPassword());
            String token = tokenService.generateToken(createdUser, "Device Info"); // Cihaz bilgisi ekleyin
            return ResponseEntity.status(HttpStatus.CREATED).body(Map.of("user", createdUser, "token", token));
        } catch (UserAlreadyExistsException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("User already exists");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred");
        }
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody UserCreateRequest userCreateRequest) {
        try {
            User user = userService.authenticateUser(userCreateRequest.getEmail(), userCreateRequest.getPassword());
            String token = tokenService.generateToken(user, "Device Info"); // Cihaz bilgisi ekleyin
            return ResponseEntity.ok(Map.of("user", user, "token", token));
        } catch (InvalidCredentialsException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid credentials");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred");
        }
    }

    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@RequestBody Map<String, String> requestBody) {
        String token = requestBody.get("token");
        try {
            tokenService.deleteByToken(token);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Long id) {
        User user = userService.getUserById(id);
        return user != null ? ResponseEntity.ok(user) : ResponseEntity.notFound().build();
    }

    @GetMapping
    public ResponseEntity<List<User>> getAllUsers() {
        List<User> users = userService.getAllUsers();
        return ResponseEntity.ok(users);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        boolean isDeleted = userService.deleteUser(id);
        return isDeleted ? ResponseEntity.noContent().build() : ResponseEntity.notFound().build();
    }
}
