import 'package:flutter/material.dart';
import 'package:learny/data/teachers_data.dart'; // To access all teachers' live sessions
import 'package:learny/data/live_session_data.dart'; // For LiveSessionStatus and LiveSessionData
import 'package:learny/widgets/live_session_card.dart';

import '../data/live_session_status.dart'; // To display each session

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Gather all upcoming live sessions from all teachers
    final List<LiveSessionData> allUpcomingSessions = [];
    for (var teacher in teachersData) {
      allUpcomingSessions.addAll(
          teacher.liveSessions.where((session) => session.status == LiveSessionStatus.upcoming)
      );
    }

    // Optional: Sort them by date
    allUpcomingSessions.sort((a, b) {
      // Basic date sort, assuming "DD MMM YYYY" format.
      // For robust sorting, convert to DateTime objects.
      try {
        final dateA = DateTime.parse("${a.date.split(' ')[2]}-${_monthNumber(a.date.split(' ')[1])}-${a.date.split(' ')[0]}");
        final dateB = DateTime.parse("${b.date.split(' ')[2]}-${_monthNumber(b.date.split(' ')[1])}-${b.date.split(' ')[0]}");
        return dateA.compareTo(dateB);
      } catch (e) {
        return 0; // Fallback if date parsing fails
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Schedule', style: TextStyle(fontFamily: 'Afacad', color: Colors.white)),
        backgroundColor: const Color(0xFFBF33FF), // Your app's primary color
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: allUpcomingSessions.isEmpty
          ? const Center(
        child: Text(
          'No upcoming sessions scheduled.',
          style: TextStyle(fontSize: 18, color: Colors.grey, fontFamily: 'Afacad'),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: allUpcomingSessions.length,
        itemBuilder: (context, index) {
          // Note: LiveSessionCard expects sessionData.
          // If you want to show teacher info on this card, you'd need to modify LiveSessionCard
          // or create a new widget, or find the teacher associated with this session.
          // For simplicity, we'll just show the session details.
          return LiveSessionCard(sessionData: allUpcomingSessions[index]);
        },
      ),
    );
  }

  // Helper to convert month name to number for sorting (basic)
  String _monthNumber(String monthName) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    int index = months.indexWhere((m) => m.toLowerCase() == monthName.toLowerCase().substring(0,3));
    return (index + 1).toString().padLeft(2, '0');
  }
}
