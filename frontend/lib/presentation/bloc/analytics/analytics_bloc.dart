import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/analytics_repository.dart';
import '../../core/error/failures.dart';
import 'analytics_event.dart';
import 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final AnalyticsRepository repository;

  AnalyticsBloc({required this.repository}) : super(AnalyticsInitial()) {
    on<LoadAnalyticsEvent>(_onLoadAnalytics);
    on<LoadWeeklyPlanEvent>(_onLoadWeeklyPlan);
    on<GenerateWeeklyPlanEvent>(_onGenerateWeeklyPlan);
  }

  Future<void> _onLoadAnalytics(
    LoadAnalyticsEvent event,
    Emitter<AnalyticsState> emit,
  ) async {
    emit(AnalyticsLoading());
    try {
      final analytics = await repository.getAnalytics();
      emit(AnalyticsLoaded(analytics));
    } catch (e) {
      emit(AnalyticsError(
        e is Failure ? e : ServerFailure(e.toString()),
      ));
    }
  }

  Future<void> _onLoadWeeklyPlan(
    LoadWeeklyPlanEvent event,
    Emitter<AnalyticsState> emit,
  ) async {
    emit(WeeklyPlanLoading());
    try {
      final plan = await repository.getWeeklyPlan(weekStart: event.weekStart);
      emit(WeeklyPlanLoaded(plan));
    } catch (e) {
      emit(AnalyticsError(
        e is Failure ? e : ServerFailure(e.toString()),
      ));
    }
  }

  Future<void> _onGenerateWeeklyPlan(
    GenerateWeeklyPlanEvent event,
    Emitter<AnalyticsState> emit,
  ) async {
    emit(WeeklyPlanLoading());
    try {
      final plan = await repository.generateWeeklyPlan(weekStart: event.weekStart);
      emit(WeeklyPlanGenerated(plan));
    } catch (e) {
      emit(AnalyticsError(
        e is Failure ? e : ServerFailure(e.toString()),
      ));
    }
  }
}

