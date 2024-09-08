package com.ahmetcan.schedulerapi.dto;

public class CategoryRequest {
    private String name;
    private Boolean isImportant;
    private Long userId;

    // Getter ve Setter metodları

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getImportant() {
        return isImportant;
    }

    public void setImportant(Boolean isImportant) {
        this.isImportant = isImportant;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }
}
