// lib/data/teacher_profile_data.dart
import 'package:learny/data/video_content_data.dart';
import 'package:learny/data/task_data.dart';
import 'package:learny/data/live_session_data.dart'; // Ensure this is imported

class TeacherProfileData {
  final String id;
  final String name;
  final String subject;
  final String imageAsset; // Ensure this asset exists
  final String grade;
  final String curriculum;
  final List<VideoContentData> videos;
  final List<TaskData> tasks;
  final List<LiveSessionData> liveSessions;

  TeacherProfileData({
    required this.id,
    required this.name,
    required this.subject,
    required this.imageAsset,
    required this.grade,
    required this.curriculum,
    required this.videos,
    required this.tasks,
    required this.liveSessions,
  });
}
