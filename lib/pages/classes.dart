import 'package:flutter/material.dart';
import 'package:learny/widgets/teacher_card.dart'; // Your updated TeacherCard
import 'package:learny/data/user_data.dart';       // For UserData type
import 'package:learny/data/teachers_data.dart';   // Import your teachers data list

class Classes extends StatelessWidget {
  final UserData userData; // Logged-in user's data (you can use this if needed for filtering, etc.)

  const Classes({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    // The Classes widget is now just the content for a tab.
    // It should not have its own Scaffold or SafeArea if EnrollPage provides them.
    return SingleChildScrollView(
      child: Padding( // Added padding around the list of cards
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: Text(
                // You can use userData here if you want to personalize the title
                "Your Teachers", // Changed title
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Afacad'),
              ),
            ),
            // Check if teachersData is empty
            if (teachersData.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("No teachers available at the moment.", style: TextStyle(fontSize: 16, color: Colors.grey)),
                ),
              )
            else
            // Use ListView.builder for potentially long lists, or just map for short lists
              ListView.builder(
                shrinkWrap: true, // Important when ListView is inside SingleChildScrollView/Column
                physics: const NeverScrollableScrollPhysics(), // Let parent scroll
                itemCount: teachersData.length,
                itemBuilder: (context, index) {
                  final teacherProfile = teachersData[index];
                  return TeacherCard(
                    teacherData: teacherProfile, // Pass the whole TeacherProfileData object
                  );
                },
              ),
            // Alternatively, for a short, fixed list, you could map:
            // ...teachersData.map((teacherProfile) => TeacherCard(teacherData: teacherProfile)).toList(),
          ],
        ),
      ),
    );
  }
}
