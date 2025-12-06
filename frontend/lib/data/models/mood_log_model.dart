import '../../domain/entities/mood_log_entity.dart';

class MoodLogModel extends MoodLogEntity {
  MoodLogModel({
    required super.id,
    required super.date,
    required super.mood,
    required super.energyLevel,
    required super.stressLevel,
    super.notes,
    required super.createdAt,
  });

  factory MoodLogModel.fromJson(Map<String, dynamic> json) {
    return MoodLogModel(
      id: json['id'].toString(),
      date: DateTime.parse(json['date'] as String),
      mood: _parseMood(json['mood'] as String),
      energyLevel: json['energyLevel'] as int,
      stressLevel: json['stressLevel'] as int,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'mood': mood.name.toUpperCase(),
      'energyLevel': energyLevel,
      'stressLevel': stressLevel,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static MoodTypeEntity _parseMood(String mood) {
    switch (mood.toUpperCase()) {
      case 'EXCELLENT':
        return MoodTypeEntity.excellent;
      case 'GOOD':
        return MoodTypeEntity.good;
      case 'NEUTRAL':
        return MoodTypeEntity.neutral;
      case 'POOR':
        return MoodTypeEntity.poor;
      case 'TERRIBLE':
        return MoodTypeEntity.terrible;
      default:
        return MoodTypeEntity.neutral;
    }
  }
}

