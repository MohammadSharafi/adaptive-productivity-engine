package com.focuscraft.domain.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Domain entity representing a Habit
 */
public class Habit {
    private Long id;
    private String name;
    private String description;
    private HabitFrequency frequency;
    private int streak;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private List<HabitLog> logs;

    public Habit() {
        this.logs = new ArrayList<>();
        this.streak = 0;
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    public Habit(String name, HabitFrequency frequency) {
        this();
        this.name = name;
        this.frequency = frequency;
    }

    // Business logic methods
    public void updateStreak(boolean completed) {
        if (completed) {
            this.streak++;
        } else {
            this.streak = 0;
        }
        this.updatedAt = LocalDateTime.now();
    }

    public double getCompletionRate() {
        if (logs.isEmpty()) {
            return 0.0;
        }
        long completedCount = logs.stream()
                .filter(HabitLog::isCompleted)
                .count();
        return (double) completedCount / logs.size();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) {
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Habit name cannot be null or empty");
        }
        if (name.length() > 100) {
            throw new IllegalArgumentException("Habit name cannot exceed 100 characters");
        }
        this.name = name;
    }
    
    public String getDescription() { return description; }
    public void setDescription(String description) {
        if (description != null && description.length() > 1000) {
            throw new IllegalArgumentException("Description cannot exceed 1000 characters");
        }
        this.description = description;
    }
    
    public HabitFrequency getFrequency() { return frequency; }
    public void setFrequency(HabitFrequency frequency) {
        if (frequency == null) {
            throw new IllegalArgumentException("Frequency cannot be null");
        }
        this.frequency = frequency;
    }
    
    public int getStreak() { return streak; }
    public void setStreak(int streak) {
        if (streak < 0) {
            throw new IllegalArgumentException("Streak cannot be negative");
        }
        this.streak = streak;
    }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public List<HabitLog> getLogs() { return new ArrayList<>(logs); }
    public void setLogs(List<HabitLog> logs) { this.logs = logs != null ? new ArrayList<>(logs) : new ArrayList<>(); }
    
    public void addLog(HabitLog log) {
        if (log != null) {
            this.logs.add(log);
        }
    }
}

