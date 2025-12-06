package com.focuscraft.domain.model;

import java.time.LocalDateTime;

/**
 * Domain entity representing a Tag
 */
public class Tag {
    private Long id;
    private String name;
    private String color;
    private LocalDateTime createdAt;

    public Tag() {
        this.createdAt = LocalDateTime.now();
    }

    public Tag(String name) {
        this();
        this.name = name;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) {
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Tag name cannot be null or empty");
        }
        if (name.length() > 50) {
            throw new IllegalArgumentException("Tag name cannot exceed 50 characters");
        }
        this.name = name;
    }
    
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}

