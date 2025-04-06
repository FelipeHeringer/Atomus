package com.backend.web;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.backend.domain.model.User;

import com.backend.domain.services.AuthService;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@RequestBody User user) {
        User newUser =  authService.registerUser(user);

        return ResponseEntity.ok(newUser);
    }

    @GetMapping("/login")
    public ResponseEntity<?> loginUser(@RequestBody Map<String, String> request){
        String email = request.get("email");
        String password = request.get("password");

        User user = authService.loginUser(email,password);

        if (user != null){
            return ResponseEntity.ok(user);
        }else{
            return ResponseEntity.status(401).body("Invalid Credentials");
        }
    }
}