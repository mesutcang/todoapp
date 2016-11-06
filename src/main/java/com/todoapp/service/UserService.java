package com.todoapp.service;

import com.todoapp.model.User;

public interface UserService {
    void save(User user);

    User findByUsername(String username);
}
