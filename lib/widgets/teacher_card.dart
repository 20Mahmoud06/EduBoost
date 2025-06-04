// lib/widgets/teacher_card.dart
import 'package:flutter/material.dart';
import 'package:learny/pages/teacher_profile_page.dart'; // For TeacherProfilePage
import 'package:learny/data/teacher_profile_data.dart'; // For TeacherProfileData model

class TeacherCard extends StatelessWidget {
  final TeacherProfileData teacherData; // Accepts the whole data object

  const TeacherCard({
    super.key,
    required this.teacherData,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth;
          final double nameFontSize = cardWidth * 0.07;
          final double detailFontSize = cardWidth * 0.045;
          final double avatarRadius = cardWidth * 0.1;
          final double avatarToTextSpacing = cardWidth * 0.06;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // Pass the same teacherData object to TeacherProfilePage
                  builder: (context) => TeacherProfilePage(teacherData: teacherData),
                ),
              );
              print('Tapped on ${teacherData.name}');
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFBF33FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: AssetImage(teacherData.imageAsset), // Use from object
                        backgroundColor: Colors.white.withOpacity(0.2),
                      ),
                      SizedBox(width: avatarToTextSpacing),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              teacherData.name, // Use from object
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: nameFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: cardWidth * 0.01),
                            Text(
                              teacherData.grade, // Use from object
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: detailFontSize,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            SizedBox(height: cardWidth * 0.005),
                            Text(
                              teacherData.subject, // Use from object
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: detailFontSize,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            SizedBox(height: cardWidth * 0.005),
                            Text(
                              teacherData.curriculum, // Use from object
                              style: TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: detailFontSize,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
