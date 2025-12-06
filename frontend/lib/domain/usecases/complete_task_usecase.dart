import '../entities/task_entity.dart';
import '../repositories/task_repository.dart';

class CompleteTaskUseCase {
  final TaskRepository repository;

  CompleteTaskUseCase(this.repository);

  Future<TaskEntity> call(String id) {
    return repository.completeTask(id);
  }
}

