import '../entities/mood_log_entity.dart';

abstract class MoodRepository {
  Future<List<MoodLogEntity>> getMoodLogs({int? limit, int? offset});
  Future<MoodLogEntity> createMoodLog(MoodLogEntity moodLog);
  Future<MoodLogEntity> updateMoodLog(MoodLogEntity moodLog);
  Future<MoodLogEntity?> getMoodLogByDate(DateTime date);
}

