import 'package:equatable/equatable.dart';
import '../../../domain/entities/analytics_entity.dart';
import '../../../domain/repositories/analytics_repository.dart';
import '../../../core/error/failures.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();

  @override
  List<Object?> get props => [];
}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoading extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {
  final AnalyticsEntity analytics;

  const AnalyticsLoaded(this.analytics);

  @override
  List<Object?> get props => [analytics];
}

class AnalyticsError extends AnalyticsState {
  final Failure failure;

  const AnalyticsError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class WeeklyPlanLoading extends AnalyticsState {}

class WeeklyPlanLoaded extends AnalyticsState {
  final WeeklyPlanEntity weeklyPlan;

  const WeeklyPlanLoaded(this.weeklyPlan);

  @override
  List<Object?> get props => [weeklyPlan];
}

class WeeklyPlanGenerated extends AnalyticsState {
  final WeeklyPlanEntity weeklyPlan;

  const WeeklyPlanGenerated(this.weeklyPlan);

  @override
  List<Object?> get props => [weeklyPlan];
}

