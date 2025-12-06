import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import '../../domain/usecases/create_task_usecase.dart';
import '../../domain/usecases/complete_task_usecase.dart';
import '../../domain/repositories/task_repository.dart';
import '../../core/error/failures.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final CreateTaskUseCase createTaskUseCase;
  final CompleteTaskUseCase completeTaskUseCase;
  final TaskRepository taskRepository;

  TaskBloc({
    required this.getTasksUseCase,
    required this.createTaskUseCase,
    required this.completeTaskUseCase,
    required this.taskRepository,
  }) : super(TaskInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<LoadTaskEvent>(_onLoadTask);
    on<CreateTaskEvent>(_onCreateTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<CompleteTaskEvent>(_onCompleteTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<StartTaskEvent>(_onStartTask);
  }

  Future<void> _onLoadTasks(
    LoadTasksEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      final tasks = await getTasksUseCase(
        status: event.status,
        limit: event.limit,
        offset: event.offset,
      );
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(
        e is Failure ? e : ServerFailure(e.toString()),
      ));
    }
  }

  Future<void> _onLoadTask(
    LoadTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      final task = await taskRepository.getTaskById(event.id);
      emit(TaskLoaded([task]));
    } catch (e) {
      emit(TaskError(
        e is Failure ? e : ServerFailure(e.toString()),
      ));
    }
  }

  Future<void> _onCreateTask(
    CreateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final task = await createTaskUseCase(event.task);
      emit(TaskCreated(task));
      // Reload tasks
      add(const LoadTasksEvent());
    } catch (e) {
      emit(TaskError(
        e is Failure ? e : ServerFailure(e.toString()),
      ));
    }
  }

  Future<void> _onUpdateTask(
    UpdateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final task = await taskRepository.updateTask(event.task);
      emit(TaskUpdated(task));
      // Reload tasks
      add(const LoadTasksEvent());
    } catch (e) {
      emit(TaskError(
        e is Failure ? e : ServerFailure(e.toString()),
      ));
    }
  }

  Future<void> _onCompleteTask(
    CompleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final task = await completeTaskUseCase(event.id);
      emit(TaskUpdated(task));
      // Reload tasks
      add(const LoadTasksEvent());
    } catch (e) {
      emit(TaskError(
        e is Failure ? e : ServerFailure(e.toString()),
      ));
    }
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await taskRepository.deleteTask(event.id);
      emit(TaskDeleted(event.id));
      // Reload tasks
      add(const LoadTasksEvent());
    } catch (e) {
      emit(TaskError(
        e is Failure ? e : ServerFailure(e.toString()),
      ));
    }
  }

  Future<void> _onStartTask(
    StartTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final task = await taskRepository.getTaskById(event.id);
      final updatedTask = TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        priority: task.priority,
        status: TaskStatusEntity.inProgress,
        estimatedDuration: task.estimatedDuration,
        actualDuration: task.actualDuration,
        dueDate: task.dueDate,
        createdAt: task.createdAt,
        updatedAt: DateTime.now(),
        completedAt: task.completedAt,
        energyLevel: task.energyLevel,
        difficulty: task.difficulty,
        tags: task.tags,
      );
      await _onUpdateTask(UpdateTaskEvent(updatedTask), emit);
    } catch (e) {
      emit(TaskError(
        e is Failure ? e : ServerFailure(e.toString()),
      ));
    }
  }
}

