package com.ahmetcan.schedulerapi.service;

import com.ahmetcan.schedulerapi.model.ToDoListItem;
import com.ahmetcan.schedulerapi.repository.ToDoListItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ToDoListItemService {

    @Autowired
    private ToDoListItemRepository repository;

    public ToDoListItem saveToDoItem(ToDoListItem item) {
        return repository.save(item);
    }

    public List<ToDoListItem> getTasksByUserId(Long userId) {
        return repository.findByUserId(userId);
    }

    public boolean deleteToDoItem(Long todoItemId) {
        Optional<ToDoListItem> item = repository.findById(todoItemId);
        if (((Optional<?>) item).isPresent()) {
            repository.deleteById(todoItemId);
            return true;
        } else {
            return false; // exception
        }
    }
    public ToDoListItem findById(Long todoItemId) {
        return repository.findById(todoItemId).orElse(null);
    }

}