package com.todoapp.converter;

import com.todoapp.dto.TodoDto;
import com.todoapp.enumeration.PriorityEnum;
import com.todoapp.model.Todo;
import com.todoapp.util.DateUtil;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class EntityConverter {

    public List<TodoDto> convert(List<Todo> todos) {
        if (todos.size() == 0) {
            return null;
        }

        List<TodoDto> todoDtos = new ArrayList<>();
        todos.stream().forEach(e -> {
            TodoDto todoDto = new TodoDto();
            todoDto.setDescription(e.getDescription());
            todoDto.setCreatedTime(DateUtil.formatDate(e.getCreatedTime()));
            todoDto.setPriority(PriorityEnum.values()[e.getPriority()].getName());
            todoDtos.add(todoDto);
        });
        return todoDtos;
    }

}
