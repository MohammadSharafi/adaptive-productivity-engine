class GraphQLSubscriptions {
  static const String taskUpdated = '''
    subscription TaskUpdated {
      taskUpdated {
        id
        title
        status
        updatedAt
      }
    }
  ''';

  static const String analyticsUpdated = '''
    subscription AnalyticsUpdated {
      analyticsUpdated {
        productivityPeaks {
          hour
          productivityScore
        }
        weeklySummary {
          totalTasks
          completedTasks
        }
      }
    }
  ''';

  static const String weeklyPlanGenerated = '''
    subscription WeeklyPlanGenerated {
      weeklyPlanGenerated {
        id
        weekStart
        recommendations {
          id
          type
          title
        }
        insights
      }
    }
  ''';

  static const String insightGenerated = '''
    subscription InsightGenerated {
      insightGenerated
    }
  ''';
}

