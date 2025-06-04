import 'package:flutter/material.dart';
import 'package:learny/data/task_data.dart'; // Import TaskData

class TaskPostCard extends StatelessWidget {
  final TaskData taskData;
  // You might also want to pass teacher's name/subject if needed here,
  // or assume it's displayed elsewhere on the TasksSection page.

  const TaskPostCard({
    super.key,
    required this.taskData,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double titleFontSize = screenWidth * 0.045;
    final double dateFontSize = screenWidth * 0.035;
    final double descriptionFontSize = screenWidth * 0.038;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    taskData.title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Afacad',
                      color: const Color(0xFF271132),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down, // Or Icons.keyboard_arrow_up if expandable
                  color: Colors.grey[600],
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.015),
            if (taskData.description.isNotEmpty) ...[
              Text(
                taskData.description,
                style: TextStyle(
                  fontSize: descriptionFontSize,
                  fontFamily: 'Afacad',
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: screenWidth * 0.015),
            ],
            Divider(color: Colors.grey.shade300, height: 1),
            SizedBox(height: screenWidth * 0.015),
            Text(
              'Assigned: ${taskData.assignedDate}  ➔  Due: ${taskData.dueDate}',
              style: TextStyle(
                fontSize: dateFontSize,
                fontFamily: 'Afacad',
                color: Colors.grey[700],
              ),
            ),
            if (taskData.isCompleted) ...[
              SizedBox(height: screenWidth * 0.01),
              Text(
                'Status: Completed',
                style: TextStyle(
                  fontSize: dateFontSize * 0.9,
                  fontFamily: 'Afacad',
                  color: Colors.green[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
