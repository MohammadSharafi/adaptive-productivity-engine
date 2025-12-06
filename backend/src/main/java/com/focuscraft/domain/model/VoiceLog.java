package com.focuscraft.domain.model;

import java.time.LocalDateTime;

/**
 * Domain entity representing a Voice Log
 */
public class VoiceLog {
    private Long id;
    private String transcript;
    private String fileUrl;
    private Integer duration; // seconds
    private boolean processed;
    private LocalDateTime createdAt;

    public VoiceLog() {
        this.processed = false;
        this.createdAt = LocalDateTime.now();
    }

    public VoiceLog(String fileUrl) {
        this();
        this.fileUrl = fileUrl;
    }

    public void markAsProcessed(String transcript) {
        this.transcript = transcript;
        this.processed = true;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getTranscript() { return transcript; }
    public void setTranscript(String transcript) { this.transcript = transcript; }
    
    public String getFileUrl() { return fileUrl; }
    public void setFileUrl(String fileUrl) { this.fileUrl = fileUrl; }
    
    public Integer getDuration() { return duration; }
    public void setDuration(Integer duration) {
        if (duration != null && duration < 0) {
            throw new IllegalArgumentException("Duration cannot be negative");
        }
        this.duration = duration;
    }
    
    public boolean isProcessed() { return processed; }
    public void setProcessed(boolean processed) { this.processed = processed; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}

