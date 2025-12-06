package com.focuscraft.presentation.graphql;

import com.focuscraft.domain.model.Priority;
import java.time.LocalDateTime;

public class TaskInput {
    private String title;
    private String description;
    private Priority priority;
    private Integer estimatedDuration;
    private LocalDateTime dueDate;
    private Integer energyLevel;
    private Integer difficulty;

    // Getters and Setters
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Priority getPriority() { return priority; }
    public void setPriority(Priority priority) { this.priority = priority; }

    public Integer getEstimatedDuration() { return estimatedDuration; }
    public void setEstimatedDuration(Integer estimatedDuration) { this.estimatedDuration = estimatedDuration; }

    public LocalDateTime getDueDate() { return dueDate; }
    public void setDueDate(LocalDateTime dueDate) { this.dueDate = dueDate; }

    public Integer getEnergyLevel() { return energyLevel; }
    public void setEnergyLevel(Integer energyLevel) { this.energyLevel = energyLevel; }

    public Integer getDifficulty() { return difficulty; }
    public void setDifficulty(Integer difficulty) { this.difficulty = difficulty; }
}

