package com.todoapp.service;


import com.todoapp.dto.TodoDto;
import com.todoapp.model.Todo;
import com.todoapp.model.User;

import java.util.List;

public interface TodoService {

    void save(Todo todo);

    List<TodoDto> getTodoList();

}
