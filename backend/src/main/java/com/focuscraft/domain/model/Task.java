package com.focuscraft.domain.model;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

/**
 * Domain entity representing a Task
 */
public class Task {
    private Long id;
    private String title;
    private String description;
    private Priority priority;
    private TaskStatus status;
    private Integer estimatedDuration; // minutes
    private Integer actualDuration; // minutes
    private LocalDateTime dueDate;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private LocalDateTime completedAt;
    private Integer energyLevel; // 1-10
    private Integer difficulty; // 1-10
    private Set<Tag> tags;

    public Task() {
        this.tags = new HashSet<>();
        this.status = TaskStatus.TODO;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    public Task(String title, Priority priority) {
        this();
        this.title = title;
        this.priority = priority;
    }

    // Business logic methods
    public void markAsCompleted() {
        this.status = TaskStatus.COMPLETED;
        this.completedAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    public void start() {
        if (this.status == TaskStatus.TODO) {
            this.status = TaskStatus.IN_PROGRESS;
            this.updatedAt = LocalDateTime.now();
        }
    }

    public boolean isOverdue() {
        return dueDate != null && 
               status != TaskStatus.COMPLETED && 
               LocalDateTime.now().isAfter(dueDate);
    }

    public double getCompletionRate() {
        if (estimatedDuration == null || estimatedDuration == 0) {
            return 0.0;
        }
        if (actualDuration == null) {
            return 0.0;
        }
        return (double) actualDuration / estimatedDuration;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) {
        if (title == null || title.trim().isEmpty()) {
            throw new IllegalArgumentException("Title cannot be null or empty");
        }
        if (title.length() > 200) {
            throw new IllegalArgumentException("Title cannot exceed 200 characters");
        }
        this.title = title;
    }
    
    public String getDescription() { return description; }
    public void setDescription(String description) {
        if (description != null && description.length() > 5000) {
            throw new IllegalArgumentException("Description cannot exceed 5000 characters");
        }
        this.description = description;
    }
    
    public Priority getPriority() { return priority; }
    public void setPriority(Priority priority) {
        if (priority == null) {
            throw new IllegalArgumentException("Priority cannot be null");
        }
        this.priority = priority;
    }
    
    public TaskStatus getStatus() { return status; }
    public void setStatus(TaskStatus status) {
        if (status == null) {
            throw new IllegalArgumentException("Status cannot be null");
        }
        this.status = status;
        this.updatedAt = LocalDateTime.now();
    }
    
    public Integer getEstimatedDuration() { return estimatedDuration; }
    public void setEstimatedDuration(Integer estimatedDuration) {
        if (estimatedDuration != null && estimatedDuration < 0) {
            throw new IllegalArgumentException("Duration cannot be negative");
        }
        this.estimatedDuration = estimatedDuration;
    }
    
    public Integer getActualDuration() { return actualDuration; }
    public void setActualDuration(Integer actualDuration) {
        if (actualDuration != null && actualDuration < 0) {
            throw new IllegalArgumentException("Duration cannot be negative");
        }
        this.actualDuration = actualDuration;
    }
    
    public LocalDateTime getDueDate() { return dueDate; }
    public void setDueDate(LocalDateTime dueDate) { this.dueDate = dueDate; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public LocalDateTime getCompletedAt() { return completedAt; }
    public void setCompletedAt(LocalDateTime completedAt) { this.completedAt = completedAt; }
    
    public Integer getEnergyLevel() { return energyLevel; }
    public void setEnergyLevel(Integer energyLevel) {
        if (energyLevel != null && (energyLevel < 1 || energyLevel > 10)) {
            throw new IllegalArgumentException("Energy level must be between 1 and 10");
        }
        this.energyLevel = energyLevel;
    }
    
    public Integer getDifficulty() { return difficulty; }
    public void setDifficulty(Integer difficulty) {
        if (difficulty != null && (difficulty < 1 || difficulty > 10)) {
            throw new IllegalArgumentException("Difficulty must be between 1 and 10");
        }
        this.difficulty = difficulty;
    }
    
    public Set<Tag> getTags() { return new HashSet<>(tags); }
    public void setTags(Set<Tag> tags) { this.tags = tags != null ? new HashSet<>(tags) : new HashSet<>(); }
    
    public void addTag(Tag tag) {
        if (tag != null) {
            this.tags.add(tag);
        }
    }
    
    public void removeTag(Tag tag) {
        if (tag != null) {
            this.tags.remove(tag);
        }
    }
}

