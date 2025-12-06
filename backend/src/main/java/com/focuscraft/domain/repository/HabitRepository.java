package com.focuscraft.domain.repository;

import com.focuscraft.domain.model.Habit;

import java.util.List;
import java.util.Optional;

public interface HabitRepository {
    List<Habit> findAll();
    Optional<Habit> findById(Long id);
    Habit save(Habit habit);
    void deleteById(Long id);
}

