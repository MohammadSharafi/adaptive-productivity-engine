import 'package:flutter/material.dart';
import '../../domain/entities/task_entity.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskEntity task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.description ?? 'No description',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text('Status: ${task.status.displayName}'),
            Text('Priority: ${task.priority.displayName}'),
            if (task.estimatedDuration != null)
              Text('Estimated: ${task.estimatedDuration} minutes'),
            if (task.actualDuration != null)
              Text('Actual: ${task.actualDuration} minutes'),
          ],
        ),
      ),
    );
  }
}

