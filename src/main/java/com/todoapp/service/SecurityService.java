package com.todoapp.service;

import com.todoapp.model.User;

public interface SecurityService {
    User findLoggedUser();

    void autologin(String username, String password);
}
