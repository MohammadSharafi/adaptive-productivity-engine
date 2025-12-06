package com.focuscraft.domain.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Domain entity representing a Habit Log entry
 */
public class HabitLog {
    private Long id;
    private Long habitId;
    private LocalDate date;
    private boolean completed;
    private String notes;
    private LocalDateTime createdAt;

    public HabitLog() {
        this.createdAt = LocalDateTime.now();
    }

    public HabitLog(Long habitId, LocalDate date, boolean completed) {
        this();
        this.habitId = habitId;
        this.date = date;
        this.completed = completed;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public Long getHabitId() { return habitId; }
    public void setHabitId(Long habitId) {
        if (habitId == null) {
            throw new IllegalArgumentException("Habit ID cannot be null");
        }
        this.habitId = habitId;
    }
    
    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) {
        if (date == null) {
            throw new IllegalArgumentException("Date cannot be null");
        }
        this.date = date;
    }
    
    public boolean isCompleted() { return completed; }
    public void setCompleted(boolean completed) { this.completed = completed; }
    
    public String getNotes() { return notes; }
    public void setNotes(String notes) {
        if (notes != null && notes.length() > 1000) {
            throw new IllegalArgumentException("Notes cannot exceed 1000 characters");
        }
        this.notes = notes;
    }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}

