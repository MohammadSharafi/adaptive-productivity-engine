package com.focuscraft.domain.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Domain entity representing a Mood Log entry
 */
public class MoodLog {
    private Long id;
    private LocalDate date;
    private MoodType mood;
    private int energyLevel; // 1-10
    private int stressLevel; // 1-10
    private String notes;
    private LocalDateTime createdAt;

    public MoodLog() {
        this.createdAt = LocalDateTime.now();
    }

    public MoodLog(LocalDate date, MoodType mood, int energyLevel, int stressLevel) {
        this();
        this.date = date;
        this.mood = mood;
        this.energyLevel = energyLevel;
        this.stressLevel = stressLevel;
    }

    // Business logic methods
    public double getProductivityScore() {
        // Calculate a productivity score based on mood, energy, and stress
        double moodScore = getMoodScore();
        double energyScore = energyLevel / 10.0;
        double stressScore = 1.0 - (stressLevel / 10.0);
        
        return (moodScore + energyScore + stressScore) / 3.0;
    }

    private double getMoodScore() {
        switch (mood) {
            case EXCELLENT: return 1.0;
            case GOOD: return 0.8;
            case NEUTRAL: return 0.5;
            case POOR: return 0.3;
            case TERRIBLE: return 0.1;
            default: return 0.5;
        }
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) {
        if (date == null) {
            throw new IllegalArgumentException("Date cannot be null");
        }
        this.date = date;
    }
    
    public MoodType getMood() { return mood; }
    public void setMood(MoodType mood) {
        if (mood == null) {
            throw new IllegalArgumentException("Mood cannot be null");
        }
        this.mood = mood;
    }
    
    public int getEnergyLevel() { return energyLevel; }
    public void setEnergyLevel(int energyLevel) {
        if (energyLevel < 1 || energyLevel > 10) {
            throw new IllegalArgumentException("Energy level must be between 1 and 10");
        }
        this.energyLevel = energyLevel;
    }
    
    public int getStressLevel() { return stressLevel; }
    public void setStressLevel(int stressLevel) {
        if (stressLevel < 1 || stressLevel > 10) {
            throw new IllegalArgumentException("Stress level must be between 1 and 10");
        }
        this.stressLevel = stressLevel;
    }
    
    public String getNotes() { return notes; }
    public void setNotes(String notes) {
        if (notes != null && notes.length() > 2000) {
            throw new IllegalArgumentException("Notes cannot exceed 2000 characters");
        }
        this.notes = notes;
    }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}

