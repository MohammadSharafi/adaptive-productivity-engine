import 'package:equatable/equatable.dart';
import '../../../domain/entities/habit_entity.dart';
import '../../../core/error/failures.dart';

abstract class HabitState extends Equatable {
  const HabitState();

  @override
  List<Object?> get props => [];
}

class HabitInitial extends HabitState {}

class HabitLoading extends HabitState {}

class HabitLoaded extends HabitState {
  final List<HabitEntity> habits;

  const HabitLoaded(this.habits);

  @override
  List<Object?> get props => [habits];
}

class HabitError extends HabitState {
  final Failure failure;

  const HabitError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class HabitCreated extends HabitState {
  final HabitEntity habit;

  const HabitCreated(this.habit);

  @override
  List<Object?> get props => [habit];
}

class HabitLogged extends HabitState {
  final HabitLogEntity log;

  const HabitLogged(this.log);

  @override
  List<Object?> get props => [log];
}

