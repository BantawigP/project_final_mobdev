import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';
import '../widgets/task_list_item.dart';
import 'add_task_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(filteredTasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          PopupMenuButton<TaskFilter>(
            onSelected: (filter) {
              ref.read(taskFilterProvider.notifier).state = filter;
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: TaskFilter.all,
                child: Text('All Tasks'),
              ),
              const PopupMenuItem(
                value: TaskFilter.completed,
                child: Text('Completed Tasks'),
              ),
              const PopupMenuItem(
                value: TaskFilter.pending,
                child: Text('Pending Tasks'),
              ),
            ],
          ),
        ],
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks available.'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskListItem(task: tasks[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
