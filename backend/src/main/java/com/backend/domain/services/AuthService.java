package com.backend.domain.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.backend.domain.model.User;
import com.backend.domain.repository.AuthRepository;

@Service
public class AuthService {
    
    @Autowired
    private AuthRepository authRepository;

    public User registerUser(User user){
        return authRepository.save(user);
    }

    public User loginUser(String email, String password){

        return authRepository.findByEmail(email);
    }
}
