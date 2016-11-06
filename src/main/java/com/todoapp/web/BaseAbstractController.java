package com.todoapp.web;


import com.todoapp.enumeration.PriorityEnum;
import com.todoapp.model.Todo;
import org.springframework.ui.Model;

public abstract class BaseAbstractController {

    protected void setCustomMessageModelMessages(Todo todo, Model model, String message) {
        model.addAttribute("msg", message);
        model.addAttribute("todoForm", todo);
    }

    protected void setTodoModel(Model model, Todo todo) {
        model.addAttribute("todoForm", todo);
        model.addAttribute("priorities", PriorityEnum.values());
    }

}
