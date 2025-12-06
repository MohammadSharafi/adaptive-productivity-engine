/// Domain entity - pure business logic
class TaskEntity {
  final String id;
  final String title;
  final String? description;
  final PriorityEntity priority;
  final TaskStatusEntity status;
  final int? estimatedDuration; // minutes
  final int? actualDuration; // minutes
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  final int? energyLevel; // 1-10
  final int? difficulty; // 1-10
  final List<TagEntity> tags;

  TaskEntity({
    required this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.status,
    this.estimatedDuration,
    this.actualDuration,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
    this.energyLevel,
    this.difficulty,
    required this.tags,
  });

  bool get isOverdue {
    if (dueDate == null || status == TaskStatusEntity.completed) {
      return false;
    }
    return DateTime.now().isAfter(dueDate!);
  }

  double get completionRate {
    if (estimatedDuration == null || estimatedDuration == 0) {
      return 0.0;
    }
    if (actualDuration == null) {
      return 0.0;
    }
    return actualDuration! / estimatedDuration!;
  }

  bool get isCompleted => status == TaskStatusEntity.completed;
  bool get isInProgress => status == TaskStatusEntity.inProgress;
}

enum PriorityEntity {
  low,
  medium,
  high,
  urgent;

  String get displayName {
    switch (this) {
      case PriorityEntity.low:
        return 'Low';
      case PriorityEntity.medium:
        return 'Medium';
      case PriorityEntity.high:
        return 'High';
      case PriorityEntity.urgent:
        return 'Urgent';
    }
  }
}

enum TaskStatusEntity {
  todo,
  inProgress,
  blocked,
  completed,
  cancelled;

  String get displayName {
    switch (this) {
      case TaskStatusEntity.todo:
        return 'To Do';
      case TaskStatusEntity.inProgress:
        return 'In Progress';
      case TaskStatusEntity.blocked:
        return 'Blocked';
      case TaskStatusEntity.completed:
        return 'Completed';
      case TaskStatusEntity.cancelled:
        return 'Cancelled';
    }
  }
}

class TagEntity {
  final String id;
  final String name;
  final String? color;

  TagEntity({
    required this.id,
    required this.name,
    this.color,
  });
}

