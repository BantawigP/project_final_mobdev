import 'package:flutter/material.dart';
import '../models/task_model.dart';

class PrioritySelector extends StatelessWidget {
  final TaskPriority selectedPriority;
  final ValueChanged<TaskPriority> onPriorityChanged;

  const PrioritySelector({
    Key? key,
    required this.selectedPriority,
    required this.onPriorityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: TaskPriority.values.map((priority) {
        final isSelected = selectedPriority == priority;
        return ChoiceChip(
          label: Text(priority.name.toUpperCase()),
          selected: isSelected,
          onSelected: (_) => onPriorityChanged(priority),
          selectedColor: _getPriorityColor(priority),
          backgroundColor: Colors.grey.shade200,
        );
      }).toList(),
    );
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.urgent:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
