import '../entities/habit_entity.dart';

abstract class HabitRepository {
  Future<List<HabitEntity>> getHabits();
  Future<HabitEntity> getHabitById(String id);
  Future<HabitEntity> createHabit(HabitEntity habit);
  Future<HabitEntity> updateHabit(HabitEntity habit);
  Future<HabitLogEntity> logHabit(String habitId, DateTime date, bool completed, {String? notes});
}

