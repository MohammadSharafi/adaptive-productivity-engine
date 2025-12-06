class AnalyticsEntity {
  final List<TimeBlockEntity> productivityPeaks;
  final List<HabitCorrelationEntity> habitCorrelations;
  final List<FocusPatternEntity> focusPatterns;
  final List<TaskInsightEntity> taskInsights;
  final WeeklySummaryEntity? weeklySummary;

  AnalyticsEntity({
    required this.productivityPeaks,
    required this.habitCorrelations,
    required this.focusPatterns,
    required this.taskInsights,
    this.weeklySummary,
  });
}

class TimeBlockEntity {
  final int hour;
  final double productivityScore;
  final int taskCount;

  TimeBlockEntity({
    required this.hour,
    required this.productivityScore,
    required this.taskCount,
  });
}

class HabitCorrelationEntity {
  final String habitName;
  final double productivityImpact;
  final double moodImpact;

  HabitCorrelationEntity({
    required this.habitName,
    required this.productivityImpact,
    required this.moodImpact,
  });
}

class FocusPatternEntity {
  final String dayOfWeek;
  final double averageFocusScore;
  final String bestTimeBlock;

  FocusPatternEntity({
    required this.dayOfWeek,
    required this.averageFocusScore,
    required this.bestTimeBlock,
  });
}

class TaskInsightEntity {
  final String taskId;
  final String taskTitle;
  final int averageDuration;
  final double difficultyRating;
  final double energyDrain;

  TaskInsightEntity({
    required this.taskId,
    required this.taskTitle,
    required this.averageDuration,
    required this.difficultyRating,
    required this.energyDrain,
  });
}

class WeeklySummaryEntity {
  final int totalTasks;
  final int completedTasks;
  final double averageFocusScore;
  final List<String> topHabits;
  final String moodTrend;

  WeeklySummaryEntity({
    required this.totalTasks,
    required this.completedTasks,
    required this.averageFocusScore,
    required this.topHabits,
    required this.moodTrend,
  });

  double get completionRate {
    if (totalTasks == 0) {
      return 0.0;
    }
    return completedTasks / totalTasks;
  }
}

