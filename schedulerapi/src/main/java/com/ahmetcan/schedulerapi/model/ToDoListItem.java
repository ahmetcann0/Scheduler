package com.ahmetcan.schedulerapi.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "todos")
public class ToDoListItem {

    @Id
    private Long id;

    @Column(nullable = false)
    private String title;

    @Column(nullable = false)
    private LocalDateTime dueDate;

    @Column(nullable = false)
    private LocalDateTime createdDate;

    @Column(nullable = false)
    private Boolean isDone;

    @Column(nullable = false)
    private Long userId;

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;

    public ToDoListItem() {
        this.isDone = false;
    }

    public ToDoListItem(Long id, String title, LocalDateTime dueDate, LocalDateTime createdDate, Boolean isDone, Long userId) {
        this.id = id;
        this.title = title;
        this.dueDate = dueDate;
        this.createdDate = createdDate;
        this.isDone = isDone;
        this.userId = userId;
        this.category = category;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public LocalDateTime getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDateTime dueDate) {
        this.dueDate = dueDate;
    }

    public LocalDateTime getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(LocalDateTime createdDate) {
        this.createdDate = createdDate;
    }

    public Boolean getDone() {
        return isDone;
    }

    public void setDone(Boolean done) {
        isDone = done;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "ToDoListItem{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", dueDate=" + dueDate +
                ", createdDate=" + createdDate +
                ", isDone=" + isDone +
                ", userId=" + userId +
                ", category=" + category +
                '}';
    }

}
