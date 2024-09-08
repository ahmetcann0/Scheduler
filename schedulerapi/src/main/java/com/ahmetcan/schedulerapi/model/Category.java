package com.ahmetcan.schedulerapi.model;

import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "category")
public class Category {

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long id;

        @Column(nullable = false, unique = true)
        private String name;

        @Column(nullable = false)
        private Boolean isImportant = false;

        @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, orphanRemoval = true)
        private Set<ToDoListItem> toDoListItems = new HashSet<>();

        @Column(nullable = false)
        private Long userId;


    // Parametresiz yapıcı metot
    public Category() {}

    // Parametreli yapıcı metot (opsiyonel, eğer kullanılacaksa)
    public Category(Long id, String name, Boolean isImportant, Set<ToDoListItem> toDoListItems, Long userId) {
        this.id = id;
        this.name = name;
        this.isImportant = isImportant;
        this.toDoListItems = toDoListItems;
        this.userId = userId;
    }

    // Getter ve Setter metodları

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getIsImportant() {
        return isImportant;
    }

    public void setIsImportant(Boolean isImportant) {
        this.isImportant = isImportant;
    }

    public Set<ToDoListItem> getToDoListItems() {
        return toDoListItems;
    }

    public void setToDoListItems(Set<ToDoListItem> toDoListItems) {
        this.toDoListItems = toDoListItems;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", isImportant=" + isImportant +
                ", toDoListItems=" + toDoListItems +
                ", userId=" + userId +
                '}';
    }
}
