import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../../core/error/failures.dart';
import '../datasources/task_remote_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<TaskEntity>> getTasks({
    TaskStatusEntity? status,
    int? limit,
    int? offset,
  }) async {
    try {
      final statusString = status?.name.toUpperCase().replaceAll('_', '_');
      final tasks = await remoteDataSource.getTasks(
        status: statusString,
        limit: limit,
        offset: offset,
      );
      return tasks;
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure('Failed to get tasks: ${e.toString()}');
    }
  }

  @override
  Future<TaskEntity> getTaskById(String id) async {
    try {
      return await remoteDataSource.getTaskById(id);
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure('Failed to get task: ${e.toString()}');
    }
  }

  @override
  Future<TaskEntity> createTask(TaskEntity task) async {
    try {
      final input = {
        'title': task.title,
        'description': task.description,
        'priority': task.priority.name.toUpperCase(),
        if (task.estimatedDuration != null)
          'estimatedDuration': task.estimatedDuration,
        if (task.dueDate != null) 'dueDate': task.dueDate!.toIso8601String(),
        if (task.energyLevel != null) 'energyLevel': task.energyLevel,
        if (task.difficulty != null) 'difficulty': task.difficulty,
        if (task.tags.isNotEmpty)
          'tags': task.tags.map((tag) => tag.name).toList(),
      };

      return await remoteDataSource.createTask(input);
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure('Failed to create task: ${e.toString()}');
    }
  }

  @override
  Future<TaskEntity> updateTask(TaskEntity task) async {
    try {
      final input = {
        'title': task.title,
        'description': task.description,
        'priority': task.priority.name.toUpperCase(),
        'status': task.status.name.toUpperCase().replaceAll('_', '_'),
        if (task.estimatedDuration != null)
          'estimatedDuration': task.estimatedDuration,
        if (task.actualDuration != null)
          'actualDuration': task.actualDuration,
        if (task.dueDate != null) 'dueDate': task.dueDate!.toIso8601String(),
        if (task.energyLevel != null) 'energyLevel': task.energyLevel,
        if (task.difficulty != null) 'difficulty': task.difficulty,
      };

      return await remoteDataSource.updateTask(task.id, input);
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure('Failed to update task: ${e.toString()}');
    }
  }

  @override
  Future<TaskEntity> completeTask(String id) async {
    try {
      return await remoteDataSource.completeTask(id);
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure('Failed to complete task: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await remoteDataSource.deleteTask(id);
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure('Failed to delete task: ${e.toString()}');
    }
  }

  @override
  Future<List<TaskEntity>> getOverdueTasks() async {
    try {
      final allTasks = await remoteDataSource.getTasks();
      final now = DateTime.now();
      return allTasks.where((task) {
        if (task.dueDate == null || task.isCompleted) {
          return false;
        }
        return now.isAfter(task.dueDate!);
      }).toList();
    } catch (e) {
      if (e is Failure) rethrow;
      throw ServerFailure('Failed to get overdue tasks: ${e.toString()}');
    }
  }
}

