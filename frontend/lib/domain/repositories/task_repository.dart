import '../entities/task_entity.dart';

/// Repository interface - part of domain layer
abstract class TaskRepository {
  Future<List<TaskEntity>> getTasks({TaskStatusEntity? status, int? limit, int? offset});
  Future<TaskEntity> getTaskById(String id);
  Future<TaskEntity> createTask(TaskEntity task);
  Future<TaskEntity> updateTask(TaskEntity task);
  Future<TaskEntity> completeTask(String id);
  Future<void> deleteTask(String id);
  Future<List<TaskEntity>> getOverdueTasks();
}

