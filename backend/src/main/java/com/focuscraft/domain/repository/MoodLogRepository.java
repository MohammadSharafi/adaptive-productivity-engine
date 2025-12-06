package com.focuscraft.domain.repository;

import com.focuscraft.domain.model.MoodLog;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface MoodLogRepository {
    List<MoodLog> findAll();
    List<MoodLog> findByDateRange(LocalDate start, LocalDate end);
    Optional<MoodLog> findById(Long id);
    Optional<MoodLog> findByDate(LocalDate date);
    MoodLog save(MoodLog moodLog);
    void deleteById(Long id);
}

