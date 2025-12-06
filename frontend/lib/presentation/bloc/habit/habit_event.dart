import 'package:equatable/equatable.dart';
import '../../../domain/entities/habit_entity.dart';

abstract class HabitEvent extends Equatable {
  const HabitEvent();

  @override
  List<Object?> get props => [];
}

class LoadHabitsEvent extends HabitEvent {}

class LoadHabitEvent extends HabitEvent {
  final String id;

  const LoadHabitEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateHabitEvent extends HabitEvent {
  final HabitEntity habit;

  const CreateHabitEvent(this.habit);

  @override
  List<Object?> get props => [habit];
}

class LogHabitEvent extends HabitEvent {
  final String habitId;
  final DateTime date;
  final bool completed;
  final String? notes;

  const LogHabitEvent({
    required this.habitId,
    required this.date,
    required this.completed,
    this.notes,
  });

  @override
  List<Object?> get props => [habitId, date, completed, notes];
}

