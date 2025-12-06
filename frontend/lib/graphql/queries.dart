class GraphQLQueries {
  static const String getTasks = '''
    query GetTasks(\$status: TaskStatus, \$limit: Int, \$offset: Int) {
      tasks(status: \$status, limit: \$limit, offset: \$offset) {
        id
        title
        description
        priority
        status
        estimatedDuration
        actualDuration
        dueDate
        createdAt
        updatedAt
        completedAt
        energyLevel
        difficulty
        tags {
          id
          name
          color
        }
      }
    }
  ''';

  static const String getTask = '''
    query GetTask(\$id: ID!) {
      task(id: \$id) {
        id
        title
        description
        priority
        status
        estimatedDuration
        actualDuration
        dueDate
        createdAt
        updatedAt
        completedAt
        energyLevel
        difficulty
        tags {
          id
          name
          color
        }
      }
    }
  ''';

  static const String getHabits = '''
    query GetHabits {
      habits {
        id
        name
        description
        frequency
        streak
        createdAt
        updatedAt
        logs {
          id
          habitId
          date
          completed
          notes
        }
      }
    }
  ''';

  static const String getMoodLogs = '''
    query GetMoodLogs(\$limit: Int, \$offset: Int) {
      moodLogs(limit: \$limit, offset: \$offset) {
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

  static const String getProductivitySessions = '''
    query GetProductivitySessions(\$limit: Int, \$offset: Int) {
      productivitySessions(limit: \$limit, offset: \$offset) {
        id
        startTime
        endTime
        taskId
        focusScore
        distractions
        createdAt
      }
    }
  ''';

  static const String getAnalytics = '''
    query GetAnalytics {
      analytics {
        productivityPeaks {
          hour
          productivityScore
          taskCount
        }
        habitCorrelations {
          habitName
          productivityImpact
          moodImpact
        }
        focusPatterns {
          dayOfWeek
          averageFocusScore
          bestTimeBlock
        }
        taskInsights {
          taskId
          taskTitle
          averageDuration
          difficultyRating
          energyDrain
        }
        weeklySummary {
          totalTasks
          completedTasks
          averageFocusScore
          topHabits
          moodTrend
        }
      }
    }
  ''';

  static const String getWeeklyPlan = '''
    query GetWeeklyPlan(\$weekStart: String) {
      weeklyPlan(weekStart: \$weekStart) {
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

  static const String search = '''
    query Search(\$query: String!, \$limit: Int) {
      search(query: \$query, limit: \$limit) {
        type
        id
        title
        content
        score
      }
    }
  ''';
}

