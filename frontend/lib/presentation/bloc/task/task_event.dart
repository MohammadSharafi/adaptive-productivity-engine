import 'package:equatable/equatable.dart';
import '../../../domain/entities/task_entity.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends TaskEvent {
  final TaskStatusEntity? status;
  final int? limit;
  final int? offset;

  const LoadTasksEvent({this.status, this.limit, this.offset});

  @override
  List<Object?> get props => [status, limit, offset];
}

class LoadTaskEvent extends TaskEvent {
  final String id;

  const LoadTaskEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateTaskEvent extends TaskEvent {
  final TaskEntity task;

  const CreateTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final TaskEntity task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class CompleteTaskEvent extends TaskEvent {
  final String id;

  const CompleteTaskEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteTaskEvent extends TaskEvent {
  final String id;

  const DeleteTaskEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class StartTaskEvent extends TaskEvent {
  final String id;

  const StartTaskEvent(this.id);

  @override
  List<Object?> get props => [id];
}

