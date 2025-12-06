package com.focuscraft.infrastructure.persistence.mapper;

import com.focuscraft.domain.model.Task;
import com.focuscraft.domain.model.Tag;
import com.focuscraft.infrastructure.persistence.entity.TaskEntity;
import com.focuscraft.infrastructure.persistence.entity.TagEntity;
import org.springframework.stereotype.Component;

import java.util.stream.Collectors;

@Component
public class TaskEntityMapper {
    
    public Task toDomain(TaskEntity entity) {
        Task task = new Task();
        task.setId(entity.getId());
        task.setTitle(entity.getTitle());
        task.setDescription(entity.getDescription());
        task.setPriority(entity.getPriority());
        task.setStatus(entity.getStatus());
        task.setEstimatedDuration(entity.getEstimatedDuration());
        task.setActualDuration(entity.getActualDuration());
        task.setDueDate(entity.getDueDate());
        task.setCreatedAt(entity.getCreatedAt());
        task.setUpdatedAt(entity.getUpdatedAt());
        task.setCompletedAt(entity.getCompletedAt());
        task.setEnergyLevel(entity.getEnergyLevel());
        task.setDifficulty(entity.getDifficulty());
        
        // Map tags
        task.setTags(entity.getTags().stream()
                .map(this::tagToDomain)
                .collect(Collectors.toSet()));
        
        return task;
    }
    
    public TaskEntity toEntity(Task task) {
        TaskEntity entity = new TaskEntity();
        entity.setId(task.getId());
        entity.setTitle(task.getTitle());
        entity.setDescription(task.getDescription());
        entity.setPriority(task.getPriority());
        entity.setStatus(task.getStatus());
        entity.setEstimatedDuration(task.getEstimatedDuration());
        entity.setActualDuration(task.getActualDuration());
        entity.setDueDate(task.getDueDate());
        entity.setCreatedAt(task.getCreatedAt());
        entity.setUpdatedAt(task.getUpdatedAt());
        entity.setCompletedAt(task.getCompletedAt());
        entity.setEnergyLevel(task.getEnergyLevel());
        entity.setDifficulty(task.getDifficulty());
        
        // Map tags - simplified, would need tag repository
        // entity.setTags(...);
        
        return entity;
    }
    
    private Tag tagToDomain(TagEntity entity) {
        Tag tag = new Tag();
        tag.setId(entity.getId());
        tag.setName(entity.getName());
        tag.setColor(entity.getColor());
        tag.setCreatedAt(entity.getCreatedAt());
        return tag;
    }
}

