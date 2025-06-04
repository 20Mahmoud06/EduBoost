// lib/pages/tasks_section.dart
import 'package:flutter/material.dart';
import 'package:learny/data/teacher_profile_data.dart';
import 'package:learny/widgets/task_post_card.dart'; // Assuming this widget exists

class TasksSection extends StatelessWidget {
  final TeacherProfileData teacherData;

  const TasksSection({super.key, required this.teacherData});

  @override
  Widget build(BuildContext context) {
    if (teacherData.tasks.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No tasks assigned by this teacher yet.',
            style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Afacad'),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      itemCount: teacherData.tasks.length,
      itemBuilder: (context, index) {
        final task = teacherData.tasks[index];
        // You'll need a TaskPostCard widget that takes TaskData
        // return ListTile(title: Text(task.title)); // Placeholder for testing
        return TaskPostCard(taskData: task);
      },
    );
  }
}

// Placeholder for TaskPostCard if you don't have it yet
// Replace this with your actual TaskPostCard widget
class TaskPostCard extends StatelessWidget {
  final dynamic taskData; // Should be TaskData

  const TaskPostCard({super.key, required this.taskData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    taskData.title ?? 'No Title',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Afacad'),
                  ),
                ),
                if (taskData.isCompleted != null)
                  Chip(
                    label: Text(taskData.isCompleted ? 'Completed' : 'Pending', style: const TextStyle(fontFamily: 'Afacad')),
                    backgroundColor: taskData.isCompleted ? Colors.green[100] : Colors.orange[100],
                    labelStyle: TextStyle(color: taskData.isCompleted ? Colors.green[800] : Colors.orange[800], fontFamily: 'Afacad'),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Assigned: ${taskData.assignedDate ?? ''}', style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Afacad')),
            Text('Due: ${taskData.dueDate ?? ''}', style: const TextStyle(fontSize: 12, color: Colors.redAccent, fontFamily: 'Afacad')),
            const SizedBox(height: 8),
            if (taskData.description != null && taskData.description.isNotEmpty)
              Text(taskData.description, style: const TextStyle(fontFamily: 'Afacad')),
          ],
        ),
      ),
    );
  }
}
