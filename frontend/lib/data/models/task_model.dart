import '../../domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.id,
    required super.title,
    super.description,
    required super.priority,
    required super.status,
    super.estimatedDuration,
    super.actualDuration,
    super.dueDate,
    required super.createdAt,
    required super.updatedAt,
    super.completedAt,
    super.energyLevel,
    super.difficulty,
    required super.tags,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      title: json['title'] as String,
      description: json['description'] as String?,
      priority: _parsePriority(json['priority'] as String),
      status: _parseStatus(json['status'] as String),
      estimatedDuration: json['estimatedDuration'] as int?,
      actualDuration: json['actualDuration'] as int?,
      dueDate: json['dueDate'] != null 
          ? DateTime.parse(json['dueDate'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      energyLevel: json['energyLevel'] as int?,
      difficulty: json['difficulty'] as int?,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((tag) => TagModel.fromJson(tag))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.name.toUpperCase(),
      'status': status.name.toUpperCase().replaceAll('_', '_'),
      'estimatedDuration': estimatedDuration,
      'actualDuration': actualDuration,
      'dueDate': dueDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'energyLevel': energyLevel,
      'difficulty': difficulty,
      'tags': tags.map((tag) => (tag as TagModel).toJson()).toList(),
    };
  }

  static PriorityEntity _parsePriority(String priority) {
    switch (priority.toUpperCase()) {
      case 'LOW':
        return PriorityEntity.low;
      case 'MEDIUM':
        return PriorityEntity.medium;
      case 'HIGH':
        return PriorityEntity.high;
      case 'URGENT':
        return PriorityEntity.urgent;
      default:
        return PriorityEntity.medium;
    }
  }

  static TaskStatusEntity _parseStatus(String status) {
    switch (status.toUpperCase()) {
      case 'TODO':
        return TaskStatusEntity.todo;
      case 'IN_PROGRESS':
        return TaskStatusEntity.inProgress;
      case 'BLOCKED':
        return TaskStatusEntity.blocked;
      case 'COMPLETED':
        return TaskStatusEntity.completed;
      case 'CANCELLED':
        return TaskStatusEntity.cancelled;
      default:
        return TaskStatusEntity.todo;
    }
  }
}

class TagModel extends TagEntity {
  TagModel({
    required super.id,
    required super.name,
    super.color,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'].toString(),
      name: json['name'] as String,
      color: json['color'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }
}

