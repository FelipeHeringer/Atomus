package com.backend.domain.repository;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.backend.domain.model.User;

public interface AuthRepository extends CrudRepository<User,Integer> {

    @Query(value = "SELECT * FROM public.users_tbl " + //
                " Where user_email LIKE ?1;" , nativeQuery = true)
    public User findByEmail(String email);
}
