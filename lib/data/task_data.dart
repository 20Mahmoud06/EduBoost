// lib/data/task_data.dart
class TaskData {
  final String id; // Unique ID for the task
  final String title;
  final String description; // Optional: more details about the task
  final String dueDate;
  final String assignedDate;
  final bool isCompleted; // Could be used to track status

  TaskData({
    required this.id,
    required this.title,
    this.description = '', // Default to empty if not provided
    required this.dueDate,
    required this.assignedDate,
    this.isCompleted = false,
  });
}
