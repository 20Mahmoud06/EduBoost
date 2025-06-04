import 'package:flutter/material.dart';
import 'package:learny/data/teacher_profile_data.dart'; // Assuming TeacherProfileData is here or in its own file
import 'package:learny/data/video_content_data.dart'; // Your video data model

class VideoPostCard extends StatelessWidget {
  final TeacherProfileData teacherData; // Data for the teacher who posted
  final VideoContentData videoData;   // Data for this specific video

  const VideoPostCard({
    super.key,
    required this.teacherData,
    required this.videoData,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;
        // Responsive font sizes based on cardWidth (which is screen width in this context)
        final double avatarRadius = cardWidth * 0.07;
        final double nameFontSize = cardWidth * 0.045;
        final double subjectFontSize = cardWidth * 0.04;
        final double titleFontSize = cardWidth * 0.042;
        final double detailFontSize = cardWidth * 0.035;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0), // Consistent padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: AssetImage(
                          teacherData.imageAsset, // Use teacher's image
                        ),
                        backgroundColor: Colors.grey[200], // Fallback color
                      ),
                      SizedBox(width: cardWidth * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            teacherData.name, // Use teacher's name
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: nameFontSize,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF271132),
                            ),
                          ),
                          Text(
                            teacherData.subject, // Use teacher's subject
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: subjectFontSize,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF271132),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: cardWidth * 0.04), // Increased spacing
                  Center(
                    child: Text(
                      videoData.title, // Use video's title
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                        fontFamily: 'Afacad',
                      ),
                    ),
                  ),
                  SizedBox(height: cardWidth * 0.03),
                  Container(
                    width: double.infinity, // Take full width
                    height: cardWidth * 0.5, // Maintain an aspect ratio (e.g., 16:9 or 2:1)
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                      color: Colors.grey[300], // Placeholder if image fails
                      image: DecorationImage(
                        image: AssetImage(videoData.videoThumbnailAsset), // Use video's thumbnail
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: cardWidth * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        videoData.description, // Use video's description
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontWeight: FontWeight.w400,
                          fontSize: detailFontSize,
                          color: const Color(0xFF5A1E78),
                        ),
                      ),
                      SizedBox(height: cardWidth * 0.01),
                      Text(
                        videoData.homework, // Use video's homework
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontWeight: FontWeight.w400,
                          fontSize: detailFontSize,
                          color: const Color(0xFF5A1E78),
                        ),
                      ),
                      SizedBox(height: cardWidth * 0.01),
                      Text(
                        videoData.date, // Use video's date
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontWeight: FontWeight.w400,
                          fontSize: detailFontSize,
                          color: const Color(0xFF5A1E78),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.5, // Slightly thinner divider
              color: Colors.grey[300], // Softer divider color
            ),
          ],
        );
      },
    );
  }
}
