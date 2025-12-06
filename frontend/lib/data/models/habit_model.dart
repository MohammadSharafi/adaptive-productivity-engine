import '../../domain/entities/habit_entity.dart';

class HabitModel extends HabitEntity {
  HabitModel({
    required super.id,
    required super.name,
    super.description,
    required super.frequency,
    required super.streak,
    required super.createdAt,
    required super.updatedAt,
    required super.logs,
  });

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      description: json['description'] as String?,
      frequency: _parseFrequency(json['frequency'] as String),
      streak: json['streak'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      logs: (json['logs'] as List<dynamic>?)
              ?.map((log) => HabitLogModel.fromJson(log))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'frequency': frequency.name.toUpperCase(),
      'streak': streak,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'logs': logs.map((log) => (log as HabitLogModel).toJson()).toList(),
    };
  }

  static HabitFrequencyEntity _parseFrequency(String frequency) {
    switch (frequency.toUpperCase()) {
      case 'DAILY':
        return HabitFrequencyEntity.daily;
      case 'WEEKLY':
        return HabitFrequencyEntity.weekly;
      case 'MONTHLY':
        return HabitFrequencyEntity.monthly;
      default:
        return HabitFrequencyEntity.daily;
    }
  }
}

class HabitLogModel extends HabitLogEntity {
  HabitLogModel({
    required super.id,
    required super.habitId,
    required super.date,
    required super.completed,
    super.notes,
  });

  factory HabitLogModel.fromJson(Map<String, dynamic> json) {
    return HabitLogModel(
      id: json['id'].toString(),
      habitId: json['habitId'].toString(),
      date: DateTime.parse(json['date'] as String),
      completed: json['completed'] as bool,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'habitId': habitId,
      'date': date.toIso8601String(),
      'completed': completed,
      'notes': notes,
    };
  }
}

