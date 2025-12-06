package com.focuscraft.infrastructure.persistence;

import com.focuscraft.domain.model.TaskStatus;
import com.focuscraft.infrastructure.persistence.entity.TaskEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface SpringDataTaskRepository extends JpaRepository<TaskEntity, Long> {
    List<TaskEntity> findByStatus(TaskStatus status);
    List<TaskEntity> findByStatusAndDueDateBefore(TaskStatus status, LocalDateTime date);
    List<TaskEntity> findByStatusOrderByCreatedAtDesc(TaskStatus status);
}

