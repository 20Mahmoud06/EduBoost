import 'package:flutter/material.dart';
import 'package:learny/data/teacher_profile_data.dart';
import 'package:learny/widgets/live_session_card.dart'; // Import your live session card
import 'package:learny/data/live_session_data.dart';

import '../data/live_session_status.dart'; // For LiveSessionStatus enum

class LiveSection extends StatelessWidget {
  final TeacherProfileData teacherData;

  const LiveSection({super.key, required this.teacherData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double titleFontSize = screenWidth * 0.05;

    // Separate ongoing and upcoming sessions
    final ongoingSessions = teacherData.liveSessions
        .where((session) => session.status == LiveSessionStatus.ongoing)
        .toList();
    final upcomingSessions = teacherData.liveSessions
        .where((session) => session.status == LiveSessionStatus.upcoming)
        .toList();

    if (teacherData.liveSessions.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No live sessions scheduled for this teacher yet.',
            style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Afacad'),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      children: [
        if (ongoingSessions.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Ongoing Sessions',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'Afacad',
                color: const Color(0xFF271132),
              ),
            ),
          ),
          // Use ListView.builder or map for these sections too if they can be long
          ...ongoingSessions.map((session) {
            return LiveSessionCard(sessionData: session); // ### CORRECTED HERE ###
          }).toList(),
          SizedBox(height: screenWidth * 0.03),
        ],
        if (upcomingSessions.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Upcoming sessions',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'Afacad',
                color: const Color(0xFF271132),
              ),
            ),
          ),
          ...upcomingSessions.map((session) {
            return LiveSessionCard(sessionData: session); // ### CORRECTED HERE ###
          }).toList(),
        ],
      ],
    );
  }
}
