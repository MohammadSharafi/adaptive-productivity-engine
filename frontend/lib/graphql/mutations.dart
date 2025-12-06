class GraphQLMutations {
  static const String createTask = '''
    mutation CreateTask(\$input: TaskInput!) {
      createTask(input: \$input) {
        id
        title
        description
        priority
        status
        estimatedDuration
        dueDate
        energyLevel
        difficulty
        createdAt
      }
    }
  ''';

  static const String updateTask = '''
    mutation UpdateTask(\$id: ID!, \$input: TaskInput!) {
      updateTask(id: \$id, input: \$input) {
        id
        title
        description
        priority
        status
        estimatedDuration
        actualDuration
        dueDate
        energyLevel
        difficulty
        updatedAt
      }
    }
  ''';

  static const String completeTask = '''
    mutation CompleteTask(\$id: ID!) {
      completeTask(id: \$id) {
        id
        status
        completedAt
      }
    }
  ''';

  static const String deleteTask = '''
    mutation DeleteTask(\$id: ID!) {
      deleteTask(id: \$id)
    }
  ''';

  static const String createHabit = '''
    mutation CreateHabit(\$input: HabitInput!) {
      createHabit(input: \$input) {
        id
        name
        description
        frequency
        streak
        createdAt
      }
    }
  ''';

  static const String logHabit = '''
    mutation LogHabit(\$habitId: ID!, \$date: String!, \$completed: Boolean!, \$notes: String) {
      logHabit(habitId: \$habitId, date: \$date, completed: \$completed, notes: \$notes) {
        id
        habitId
        date
        completed
        notes
      }
    }
  ''';

  static const String createMoodLog = '''
    mutation CreateMoodLog(\$input: MoodLogInput!) {
      createMoodLog(input: \$input) {
        id
        date
        mood
        energyLevel
        stressLevel
        notes
        createdAt
      }
    }
  ''';

  static const String startSession = '''
    mutation StartSession(\$taskId: ID) {
      startSession(taskId: \$taskId) {
        id
        startTime
        taskId
        createdAt
      }
    }
  ''';

  static const String endSession = '''
    mutation EndSession(\$id: ID!) {
      endSession(id: \$id) {
        id
        endTime
        duration
        focusScore
      }
    }
  ''';

  static const String generateWeeklyPlan = '''
    mutation GenerateWeeklyPlan(\$weekStart: String) {
      generateWeeklyPlan(weekStart: \$weekStart) {
        id
        weekStart
        weekEnd
        recommendations {
          id
          type
          title
          description
          priority
          taskId
          suggestedTime
        }
        insights
        createdAt
      }
    }
  ''';
}

