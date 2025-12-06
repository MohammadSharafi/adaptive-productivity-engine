import 'package:equatable/equatable.dart';
import '../../../domain/entities/mood_log_entity.dart';
import '../../../core/error/failures.dart';

abstract class MoodState extends Equatable {
  const MoodState();

  @override
  List<Object?> get props => [];
}

class MoodInitial extends MoodState {}

class MoodLoading extends MoodState {}

class MoodLoaded extends MoodState {
  final List<MoodLogEntity> moodLogs;

  const MoodLoaded(this.moodLogs);

  @override
  List<Object?> get props => [moodLogs];
}

class MoodError extends MoodState {
  final Failure failure;

  const MoodError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class MoodLogCreated extends MoodState {
  final MoodLogEntity moodLog;

  const MoodLogCreated(this.moodLog);

  @override
  List<Object?> get props => [moodLog];
}

