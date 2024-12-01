import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../widgets/priority_selector.dart';

class EditTaskScreen extends ConsumerStatefulWidget {
  final Task task;

  const EditTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends ConsumerState<EditTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TaskPriority _selectedPriority = TaskPriority.low;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _selectedPriority = widget.task.priority;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Priority',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            PrioritySelector(
              selectedPriority: _selectedPriority,
              onPriorityChanged: (priority) {
                setState(() {
                  _selectedPriority = priority;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _editTask,
              child: const Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }

  void _editTask() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    final updatedTask = widget.task.copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      priority: _selectedPriority,
    );

    ref.read(taskProvider.notifier).updateTask(updatedTask);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}