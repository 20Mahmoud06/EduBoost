// lib/data/live_session_data.dart
import 'package:learny/data/live_session_status.dart'; // Import the status enum

class LiveSessionData {
  final String id;
  final String title;
  final String description;
  final String homework;
  final String date;
  final String time;
  final LiveSessionStatus status;
  final String? meetingLink; // Optional: for joining the live session

  LiveSessionData({
    required this.id,
    required this.title,
    required this.description,
    required this.homework,
    required this.date,
    required this.time,
    required this.status,
    this.meetingLink,
  });
}
