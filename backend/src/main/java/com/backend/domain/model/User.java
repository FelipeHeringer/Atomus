package com.backend.domain.model;

import jakarta.persistence.*;

@Entity
@Table(name = "users_tbl")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column (name = "user_id")
    private Integer userId;
    
    @Column(name = "user_name", length = 255 , nullable = false)
    private String name;

    @Column(name = "user_email", length = 255 , nullable = false, unique = true)
    private String email;

    @Column(name = "user_password", length = 255 , nullable = false )
    private String password;

    @Column(name = "user_photo_url",length = 255)
    private String photoUrl;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

}
