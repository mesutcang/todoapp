package com.todoapp.service.impl;


import com.todoapp.converter.EntityConverter;
import com.todoapp.dto.TodoDto;
import com.todoapp.model.Todo;
import com.todoapp.model.User;
import com.todoapp.repository.TodoRepository;
import com.todoapp.service.SecurityService;
import com.todoapp.service.TodoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class TodoServiceImpl implements TodoService {

    private static final Logger LOG = LoggerFactory.getLogger(TodoServiceImpl.class);

    @Autowired
    private TodoRepository todoRepository;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private EntityConverter entityConverter;

    @Override
    public void save(final Todo todo) {
        final User user = securityService.findLoggedUser();
        todo.setUser(user);
        todo.setCreatedTime(new Date());
        todoRepository.save(todo);
        LOG.debug(String.format("%s added todo !", user.getUsername()));
    }

    @Override
    public List<TodoDto> getTodoList() {
        final User user = securityService.findLoggedUser();
        List<TodoDto> todoDtos = entityConverter.convert(todoRepository.getTodoList(user));
        return todoDtos;
    }

}
