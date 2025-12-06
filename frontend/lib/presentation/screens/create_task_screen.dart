import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task/task_bloc.dart';
import '../bloc/task/task_event.dart';
import '../bloc/task/task_state.dart';
import '../../domain/entities/task_entity.dart';
import '../../core/error/error_handler.dart';
import '../../data/models/task_model.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  PriorityEntity _selectedPriority = PriorityEntity.medium;
  int? _estimatedDuration;
  DateTime? _dueDate;
  int? _energyLevel;
  int? _difficulty;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final task = TaskModel(
        id: '', // Will be set by backend
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        priority: _selectedPriority,
        status: TaskStatusEntity.todo,
        estimatedDuration: _estimatedDuration,
        dueDate: _dueDate,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        energyLevel: _energyLevel,
        difficulty: _difficulty,
        tags: [],
      );

      context.read<TaskBloc>().add(CreateTaskEvent(task));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskCreated) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Task created successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is TaskError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(ErrorHandler.getUserFriendlyMessage(state.failure)),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<PriorityEntity>(
                  value: _selectedPriority,
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(),
                  ),
                  items: PriorityEntity.values.map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority.displayName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPriority = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Estimated Duration (minutes)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    _estimatedDuration = value.isEmpty ? null : int.tryParse(value);
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          _dueDate = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            time.hour,
                            time.minute,
                          );
                        });
                      }
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Due Date',
                      border: OutlineInputBorder(),
                    ),
                    child: Text(
                      _dueDate == null
                          ? 'Select date and time'
                          : '${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year} ${_dueDate!.hour}:${_dueDate!.minute.toString().padLeft(2, '0')}',
                    ),
                  ),
                ),
                if (_dueDate != null) ...[
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _dueDate = null;
                      });
                    },
                    icon: const Icon(Icons.clear, size: 16),
                    label: const Text('Clear'),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Energy Level: ${_energyLevel ?? 5}'),
                          Slider(
                            value: (_energyLevel ?? 5).toDouble(),
                            min: 1,
                            max: 10,
                            divisions: 9,
                            label: '${_energyLevel ?? 5}',
                            onChanged: (value) {
                              setState(() {
                                _energyLevel = value.toInt();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Difficulty: ${_difficulty ?? 5}'),
                          Slider(
                            value: (_difficulty ?? 5).toDouble(),
                            min: 1,
                            max: 10,
                            divisions: 9,
                            label: '${_difficulty ?? 5}',
                            onChanged: (value) {
                              setState(() {
                                _difficulty = value.toInt();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    final isLoading = state is TaskLoading;
                    return ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Create Task'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


