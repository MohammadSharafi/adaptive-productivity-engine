class HabitEntity {
  final String id;
  final String name;
  final String? description;
  final HabitFrequencyEntity frequency;
  final int streak;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<HabitLogEntity> logs;

  HabitEntity({
    required this.id,
    required this.name,
    this.description,
    required this.frequency,
    required this.streak,
    required this.createdAt,
    required this.updatedAt,
    required this.logs,
  });

  double get completionRate {
    if (logs.isEmpty) {
      return 0.0;
    }
    final completedCount = logs.where((log) => log.completed).length;
    return completedCount / logs.length;
  }

  bool get isActive => streak > 0;
}

enum HabitFrequencyEntity {
  daily,
  weekly,
  monthly;

  String get displayName {
    switch (this) {
      case HabitFrequencyEntity.daily:
        return 'Daily';
      case HabitFrequencyEntity.weekly:
        return 'Weekly';
      case HabitFrequencyEntity.monthly:
        return 'Monthly';
    }
  }
}

class HabitLogEntity {
  final String id;
  final String habitId;
  final DateTime date;
  final bool completed;
  final String? notes;

  HabitLogEntity({
    required this.id,
    required this.habitId,
    required this.date,
    required this.completed,
    this.notes,
  });
}

