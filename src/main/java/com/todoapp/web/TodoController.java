package com.todoapp.web;

import com.todoapp.enumeration.PriorityEnum;
import com.todoapp.model.Todo;
import com.todoapp.service.TodoService;
import com.todoapp.validator.TodoValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;


@Controller
@RequestMapping(value = {"", "/todo"})
public class TodoController extends BaseAbstractController {

    @Autowired
    private TodoService todoService;

    @Autowired
    private TodoValidator todoValidator;

    @RequestMapping(value = {"/add"})
    public String addtodo(final Model model) {
        final Todo todo = new Todo();
        setTodoModel(model, todo);
        return "addtodo";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String saveTodo(@ModelAttribute("todoForm") @Validated Todo todo,
                           BindingResult result, Model model, HttpServletRequest request) {

        todoValidator.validate(todo, result);
        if (result.hasErrors()) {
            model.addAttribute("priorities", PriorityEnum.values());
            model.addAttribute("addtodo");
            return "addtodo";
        }

        try {
            todoService.save(todo);
        } catch (Exception e) {
            setCustomMessageModelMessages(todo, model, e.getMessage());
            return "addtodo";
        }

        return "redirect:/welcome";
    }

    @RequestMapping(value = {"/todo-list"})
    public String addList(final Model model) {
        return "todolist";
    }



}
