import '../entities/analytics_entity.dart';

abstract class AnalyticsRepository {
  Future<AnalyticsEntity> getAnalytics();
  Future<WeeklyPlanEntity> getWeeklyPlan({DateTime? weekStart});
  Future<WeeklyPlanEntity> generateWeeklyPlan({DateTime? weekStart});
}

class WeeklyPlanEntity {
  final String id;
  final DateTime weekStart;
  final DateTime weekEnd;
  final List<RecommendationEntity> recommendations;
  final String? insights;
  final DateTime createdAt;

  WeeklyPlanEntity({
    required this.id,
    required this.weekStart,
    required this.weekEnd,
    required this.recommendations,
    this.insights,
    required this.createdAt,
  });
}

class RecommendationEntity {
  final String id;
  final RecommendationTypeEntity type;
  final String title;
  final String description;
  final int priority;
  final String? taskId;
  final String? suggestedTime;

  RecommendationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.priority,
    this.taskId,
    this.suggestedTime,
  });
}

enum RecommendationTypeEntity {
  taskPriority,
  timeBlock,
  habitSuggestion,
  breakTiming,
  focusOptimization;

  String get displayName {
    switch (this) {
      case RecommendationTypeEntity.taskPriority:
        return 'Task Priority';
      case RecommendationTypeEntity.timeBlock:
        return 'Time Block';
      case RecommendationTypeEntity.habitSuggestion:
        return 'Habit Suggestion';
      case RecommendationTypeEntity.breakTiming:
        return 'Break Timing';
      case RecommendationTypeEntity.focusOptimization:
        return 'Focus Optimization';
    }
  }
}

