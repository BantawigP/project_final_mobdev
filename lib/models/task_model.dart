enum TaskPriority {
  low,
  medium,
  high,
  urgent,
}

class Task {
  final String id;
  final String title;
  final String description;
  final TaskPriority priority;
  final bool isCompleted;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.priority = TaskPriority.low,
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
