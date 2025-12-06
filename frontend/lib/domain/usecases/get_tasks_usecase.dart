import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<List<TaskEntity>> call({
    TaskStatusEntity? status,
    int? limit,
    int? offset,
  }) {
    return repository.getTasks(
      status: status,
      limit: limit,
      offset: offset,
    );
  }
}

