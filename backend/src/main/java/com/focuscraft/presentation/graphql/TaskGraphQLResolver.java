package com.focuscraft.presentation.graphql;

import com.focuscraft.domain.model.Task;
import com.focuscraft.domain.model.TaskStatus;
import com.focuscraft.domain.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.MutationMapping;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.stereotype.Controller;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class TaskGraphQLResolver {
    
    @Autowired
    private TaskRepository taskRepository;

    @QueryMapping
    public List<Task> tasks(
            @Argument TaskStatus status,
            @Argument Integer limit,
            @Argument Integer offset) {
        List<Task> tasks;
        if (status != null) {
            tasks = taskRepository.findByStatus(status);
        } else {
            tasks = taskRepository.findAll();
        }
        
        // Apply pagination
        if (offset != null && offset > 0) {
            tasks = tasks.stream().skip(offset).collect(Collectors.toList());
        }
        if (limit != null && limit > 0) {
            tasks = tasks.stream().limit(limit).collect(Collectors.toList());
        }
        
        return tasks;
    }

    @QueryMapping
    public Task task(@Argument Long id) {
        return taskRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Task not found"));
    }

    @MutationMapping
    public Task createTask(@Argument TaskInput input) {
        Task task = new Task(input.getTitle(), input.getPriority());
        task.setDescription(input.getDescription());
        task.setEstimatedDuration(input.getEstimatedDuration());
        task.setDueDate(input.getDueDate());
        task.setEnergyLevel(input.getEnergyLevel());
        task.setDifficulty(input.getDifficulty());
        
        return taskRepository.save(task);
    }

    @MutationMapping
    public Task updateTask(@Argument Long id, @Argument TaskInput input) {
        Task task = taskRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Task not found"));
        
        task.setTitle(input.getTitle());
        task.setDescription(input.getDescription());
        task.setPriority(input.getPriority());
        task.setEstimatedDuration(input.getEstimatedDuration());
        task.setDueDate(input.getDueDate());
        task.setEnergyLevel(input.getEnergyLevel());
        task.setDifficulty(input.getDifficulty());
        
        return taskRepository.save(task);
    }

    @MutationMapping
    public Task completeTask(@Argument Long id) {
        Task task = taskRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Task not found"));
        task.markAsCompleted();
        return taskRepository.save(task);
    }

    @MutationMapping
    public Boolean deleteTask(@Argument Long id) {
        if (!taskRepository.existsById(id)) {
            return false;
        }
        taskRepository.deleteById(id);
        return true;
    }
}

