package com.focuscraft.domain.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Domain entity representing a Productivity Session
 */
public class ProductivitySession {
    private Long id;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private Long taskId;
    private Integer focusScore; // 1-10
    private List<String> distractions;
    private LocalDateTime createdAt;

    public ProductivitySession() {
        this.distractions = new ArrayList<>();
        this.startTime = LocalDateTime.now();
        this.createdAt = LocalDateTime.now();
    }

    public ProductivitySession(Long taskId) {
        this();
        this.taskId = taskId;
    }

    // Business logic methods
    public void end() {
        this.endTime = LocalDateTime.now();
    }

    public Integer getDurationMinutes() {
        if (startTime == null || endTime == null) {
            return null;
        }
        return (int) java.time.Duration.between(startTime, endTime).toMinutes();
    }

    public boolean isActive() {
        return endTime == null;
    }

    public void addDistraction(String distraction) {
        if (distraction != null && !distraction.trim().isEmpty()) {
            this.distractions.add(distraction);
        }
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public LocalDateTime getStartTime() { return startTime; }
    public void setStartTime(LocalDateTime startTime) {
        if (startTime == null) {
            throw new IllegalArgumentException("Start time cannot be null");
        }
        this.startTime = startTime;
    }
    
    public LocalDateTime getEndTime() { return endTime; }
    public void setEndTime(LocalDateTime endTime) { this.endTime = endTime; }
    
    public Long getTaskId() { return taskId; }
    public void setTaskId(Long taskId) { this.taskId = taskId; }
    
    public Integer getFocusScore() { return focusScore; }
    public void setFocusScore(Integer focusScore) {
        if (focusScore != null && (focusScore < 1 || focusScore > 10)) {
            throw new IllegalArgumentException("Focus score must be between 1 and 10");
        }
        this.focusScore = focusScore;
    }
    
    public List<String> getDistractions() { return new ArrayList<>(distractions); }
    public void setDistractions(List<String> distractions) {
        this.distractions = distractions != null ? new ArrayList<>(distractions) : new ArrayList<>();
    }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}

