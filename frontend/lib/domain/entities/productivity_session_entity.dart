class ProductivitySessionEntity {
  final String id;
  final DateTime startTime;
  final DateTime? endTime;
  final String? taskId;
  final int? focusScore; // 1-10
  final List<String> distractions;
  final DateTime createdAt;

  ProductivitySessionEntity({
    required this.id,
    required this.startTime,
    this.endTime,
    this.taskId,
    this.focusScore,
    required this.distractions,
    required this.createdAt,
  });

  int? get durationMinutes {
    if (endTime == null) {
      return null;
    }
    return endTime!.difference(startTime).inMinutes;
  }

  bool get isActive => endTime == null;

  double get focusPercentage {
    if (focusScore == null) {
      return 0.0;
    }
    return focusScore! / 10.0;
  }
}

