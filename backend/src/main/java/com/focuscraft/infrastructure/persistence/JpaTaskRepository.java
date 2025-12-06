package com.focuscraft.infrastructure.persistence;

import com.focuscraft.domain.model.Task;
import com.focuscraft.domain.model.TaskStatus;
import com.focuscraft.domain.repository.TaskRepository;
import com.focuscraft.infrastructure.persistence.entity.TaskEntity;
import com.focuscraft.infrastructure.persistence.mapper.TaskEntityMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Component
public class JpaTaskRepository implements TaskRepository {
    
    @Autowired
    private SpringDataTaskRepository springDataRepository;
    
    @Autowired
    private TaskEntityMapper mapper;

    @Override
    public List<Task> findAll() {
        return springDataRepository.findAll().stream()
                .map(mapper::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public List<Task> findByStatus(TaskStatus status) {
        return springDataRepository.findByStatus(status).stream()
                .map(mapper::toDomain)
                .collect(Collectors.toList());
    }

    @Override
    public Optional<Task> findById(Long id) {
        return springDataRepository.findById(id)
                .map(mapper::toDomain);
    }

    @Override
    public Task save(Task task) {
        TaskEntity entity = mapper.toEntity(task);
        TaskEntity saved = springDataRepository.save(entity);
        return mapper.toDomain(saved);
    }

    @Override
    public void deleteById(Long id) {
        springDataRepository.deleteById(id);
    }

    @Override
    public boolean existsById(Long id) {
        return springDataRepository.existsById(id);
    }

    @Override
    public List<Task> findOverdueTasks() {
        return springDataRepository
                .findByStatusAndDueDateBefore(TaskStatus.TODO, java.time.LocalDateTime.now())
                .stream()
                .map(mapper::toDomain)
                .collect(Collectors.toList());
    }
}

