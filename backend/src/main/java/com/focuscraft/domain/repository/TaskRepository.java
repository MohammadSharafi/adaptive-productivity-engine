package com.focuscraft.domain.repository;

import com.focuscraft.domain.model.Task;
import com.focuscraft.domain.model.TaskStatus;

import java.util.List;
import java.util.Optional;

/**
 * Repository interface for Task domain entity
 */
public interface TaskRepository {
    List<Task> findAll();
    List<Task> findByStatus(TaskStatus status);
    Optional<Task> findById(Long id);
    Task save(Task task);
    void deleteById(Long id);
    boolean existsById(Long id);
    List<Task> findOverdueTasks();
}

