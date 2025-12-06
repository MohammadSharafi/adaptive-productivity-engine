class MoodLogEntity {
  final String id;
  final DateTime date;
  final MoodTypeEntity mood;
  final int energyLevel; // 1-10
  final int stressLevel; // 1-10
  final String? notes;
  final DateTime createdAt;

  MoodLogEntity({
    required this.id,
    required this.date,
    required this.mood,
    required this.energyLevel,
    required this.stressLevel,
    this.notes,
    required this.createdAt,
  });

  double get productivityScore {
    final moodScore = _getMoodScore();
    final energyScore = energyLevel / 10.0;
    final stressScore = 1.0 - (stressLevel / 10.0);
    return (moodScore + energyScore + stressScore) / 3.0;
  }

  double _getMoodScore() {
    switch (mood) {
      case MoodTypeEntity.excellent:
        return 1.0;
      case MoodTypeEntity.good:
        return 0.8;
      case MoodTypeEntity.neutral:
        return 0.5;
      case MoodTypeEntity.poor:
        return 0.3;
      case MoodTypeEntity.terrible:
        return 0.1;
    }
  }
}

enum MoodTypeEntity {
  excellent,
  good,
  neutral,
  poor,
  terrible;

  String get displayName {
    switch (this) {
      case MoodTypeEntity.excellent:
        return 'Excellent';
      case MoodTypeEntity.good:
        return 'Good';
      case MoodTypeEntity.neutral:
        return 'Neutral';
      case MoodTypeEntity.poor:
        return 'Poor';
      case MoodTypeEntity.terrible:
        return 'Terrible';
    }
  }

  String get emoji {
    switch (this) {
      case MoodTypeEntity.excellent:
        return '😄';
      case MoodTypeEntity.good:
        return '🙂';
      case MoodTypeEntity.neutral:
        return '😐';
      case MoodTypeEntity.poor:
        return '😔';
      case MoodTypeEntity.terrible:
        return '😢';
    }
  }
}

