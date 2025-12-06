import 'package:equatable/equatable.dart';
import '../../../domain/entities/mood_log_entity.dart';

abstract class MoodEvent extends Equatable {
  const MoodEvent();

  @override
  List<Object?> get props => [];
}

class LoadMoodLogsEvent extends MoodEvent {
  final int? limit;
  final int? offset;

  const LoadMoodLogsEvent({this.limit, this.offset});

  @override
  List<Object?> get props => [limit, offset];
}

class CreateMoodLogEvent extends MoodEvent {
  final MoodLogEntity moodLog;

  const CreateMoodLogEvent(this.moodLog);

  @override
  List<Object?> get props => [moodLog];
}

class GetMoodLogByDateEvent extends MoodEvent {
  final DateTime date;

  const GetMoodLogByDateEvent(this.date);

  @override
  List<Object?> get props => [date];
}

