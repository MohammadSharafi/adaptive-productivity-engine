import 'package:equatable/equatable.dart';
import '../../../domain/entities/analytics_entity.dart';

abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAnalyticsEvent extends AnalyticsEvent {}

class LoadWeeklyPlanEvent extends AnalyticsEvent {
  final DateTime? weekStart;

  const LoadWeeklyPlanEvent({this.weekStart});

  @override
  List<Object?> get props => [weekStart];
}

class GenerateWeeklyPlanEvent extends AnalyticsEvent {
  final DateTime? weekStart;

  const GenerateWeeklyPlanEvent({this.weekStart});

  @override
  List<Object?> get props => [weekStart];
}

