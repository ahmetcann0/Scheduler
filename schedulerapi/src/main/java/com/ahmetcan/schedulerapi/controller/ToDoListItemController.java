package com.ahmetcan.schedulerapi.controller;

import com.ahmetcan.schedulerapi.model.ToDoListItem;
import com.ahmetcan.schedulerapi.service.ToDoListItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users/{userId}/todos")
public class ToDoListItemController {

    @Autowired
    private ToDoListItemService service;

    @PostMapping
    public ResponseEntity<Void> createTodoItem(
            @PathVariable Long userId,
            @RequestBody ToDoListItem newItem) {
        newItem.setUserId(userId);
        service.saveToDoItem(newItem);
        return ResponseEntity.status(201).build(); // 201 Created
    }

    @GetMapping
    public ResponseEntity<List<ToDoListItem>> getTasksByUserId(@PathVariable Long userId) {
        List<ToDoListItem> items = service.getTasksByUserId(userId);
        if (items.isEmpty()) {
            return ResponseEntity.noContent().build(); // 204 No Content
        } else {
            return ResponseEntity.ok(items); // 200 OK
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTodoItem(@PathVariable Long id) {
        boolean isDeleted = service.deleteToDoItem(id);
        if (isDeleted) {
            return ResponseEntity.noContent().build(); // Başarılı silme için HTTP 204 No Content
        } else {
            return ResponseEntity.notFound().build(); // Öğeyi bulamadığınızda HTTP 404 Not Found
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<ToDoListItem> updateToDoListItem(
            @PathVariable Long userId,
            @PathVariable Long id,
            @RequestBody ToDoListItem updatedItem) {
        if (!updatedItem.getUserId().equals(userId)) {
            return new ResponseEntity<>(HttpStatus.FORBIDDEN);
        }

        ToDoListItem item = service.updateToDoListItem(id, updatedItem);
        return new ResponseEntity<>(item, HttpStatus.OK);
    }

}
