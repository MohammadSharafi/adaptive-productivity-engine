import 'package:equatable/equatable.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../core/error/failures.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskError extends TaskState {
  final Failure failure;

  const TaskError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class TaskCreated extends TaskState {
  final TaskEntity task;

  const TaskCreated(this.task);

  @override
  List<Object?> get props => [task];
}

class TaskUpdated extends TaskState {
  final TaskEntity task;

  const TaskUpdated(this.task);

  @override
  List<Object?> get props => [task];
}

class TaskDeleted extends TaskState {
  final String id;

  const TaskDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

