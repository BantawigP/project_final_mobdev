import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../notifiers/task_state_notifier.dart';

final taskProvider = StateNotifierProvider<TaskStateNotifier, List<Task>>((ref) {
  return TaskStateNotifier();
});

enum TaskFilter { all, completed, pending }

final taskFilterProvider = StateProvider<TaskFilter>((ref) => TaskFilter.all);

final filteredTasksProvider = Provider<List<Task>>((ref) {
  final allTasks = ref.watch(taskProvider);
  final filter = ref.watch(taskFilterProvider);

  switch (filter) {
    case TaskFilter.completed:
      return allTasks.where((task) => task.isCompleted).toList();
    case TaskFilter.pending:
      return allTasks.where((task) => !task.isCompleted).toList();
    case TaskFilter.all:
    default:
      return allTasks;
  }
});
