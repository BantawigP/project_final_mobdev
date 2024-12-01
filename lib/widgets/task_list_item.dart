import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../screens/edit_task_screen.dart';

class TaskListItem extends ConsumerWidget {
  final Task task;

  const TaskListItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _getPriorityText(task.priority),
              style: TextStyle(
                color: _getPriorityColor(task.priority),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) {
            ref.read(taskProvider.notifier).toggleTaskCompletion(task.id);
          },
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Edit') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(task: task),
                ),
              );
            } else if (value == 'Delete') {
              _confirmDeleteTask(context, ref);
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(value: 'Edit', child: Text('Edit')),
            const PopupMenuItem(value: 'Delete', child: Text('Delete')),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTaskScreen(task: task),
            ),
          );
        },
      ),
    );
  }

  void _confirmDeleteTask(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ref.read(taskProvider.notifier).removeTask(task.id);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  String _getPriorityText(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return 'Low Priority';
      case TaskPriority.medium:
        return 'Medium Priority';
      case TaskPriority.high:
        return 'High Priority';
      case TaskPriority.urgent:
        return 'Urgent Priority';
      default:
        return '';
    }
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green.shade700;
      case TaskPriority.medium:
        return Colors.orange.shade700;
      case TaskPriority.high:
        return Colors.red.shade700;
      case TaskPriority.urgent:
        return Colors.red.shade900;
      default:
        return Colors.black;
    }
  }
}
