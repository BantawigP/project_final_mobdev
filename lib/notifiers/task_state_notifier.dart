import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';

// A StateNotifier class that will manage task state
class TaskStateNotifier extends StateNotifier<List<Task>> {
  TaskStateNotifier() : super([]);

  // Add a new task
  void addTask(Task task) {
    state = [...state, task]; // Add task to the list
  }

  // Toggle completion status of a task
  void toggleTaskCompletion(String taskId) {
    state = [
      for (final task in state)
        if (task.id == taskId)
          task.copyWith(isCompleted: !task.isCompleted)
        else
          task,
    ];
  }

  // Remove a task by its ID
  void removeTask(String taskId) {
    state = state.where((task) => task.id != taskId).toList();
  }

  // Update an existing task
  void updateTask(Task updatedTask) {
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task,
    ];
  }
}
