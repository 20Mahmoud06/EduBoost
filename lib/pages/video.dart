// lib/pages/video.dart
import 'package:flutter/material.dart';
import 'package:learny/widgets/video_post_card.dart'; // Assuming this widget exists and is correctly implemented
import 'package:learny/data/teacher_profile_data.dart';

class Video extends StatelessWidget {
  final TeacherProfileData teacherData;

  const Video({super.key, required this.teacherData});

  @override
  Widget build(BuildContext context) {
    if (teacherData.videos.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No videos available for this teacher yet.',
            style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Afacad'),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      itemCount: teacherData.videos.length,
      itemBuilder: (context, index) {
        final videoContent = teacherData.videos[index];
        // You'll need a VideoPostCard widget that takes VideoContentData
        // For now, let's assume it exists or use a placeholder.
        // If VideoPostCard is not ready, you can use a simple Text widget for testing:
        // return ListTile(title: Text(videoContent.title));
        return VideoPostCard(
          videoData: videoContent,
          // If TeacherProfileData is needed by VideoPostCard, pass it:
          // teacherData: teacherData,
        );
      },
    );
  }
}

// Placeholder for VideoPostCard if you don't have it yet
// Replace this with your actual VideoPostCard widget
class VideoPostCard extends StatelessWidget {
  final dynamic videoData; // Should be VideoContentData
  // final TeacherProfileData? teacherData;

  const VideoPostCard({super.key, required this.videoData /*, this.teacherData */});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the thumbnail
            if (videoData.videoThumbnailAsset != null && videoData.videoThumbnailAsset.isNotEmpty)
              Image.asset(
                videoData.videoThumbnailAsset,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey[300],
                    child: const Center(child: Text('No Thumbnail', style: TextStyle(fontFamily: 'Afacad'))),
                  );
                },
              )
            else
              Container(
                height: 180,
                color: Colors.grey[300],
                child: const Center(child: Text('No Thumbnail', style: TextStyle(fontFamily: 'Afacad'))),
              ),
            const SizedBox(height: 12),
            Text(videoData.title ?? 'No Title', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Afacad')),
            const SizedBox(height: 4),
            Text(videoData.date ?? '', style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Afacad')),
            const SizedBox(height: 8),
            Text(videoData.description ?? '', style: const TextStyle(fontFamily: 'Afacad')),
            const SizedBox(height: 8),
            if (videoData.homework != null && videoData.homework.isNotEmpty)
              Text('Homework: ${videoData.homework}', style: const TextStyle(fontFamily: 'Afacad', fontStyle: FontStyle.italic)),
            // Add a play button if videoUrl exists
            if (videoData.videoUrl != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.play_circle_fill),
                  label: const Text('Play Video'),
                  onPressed: () {
                    // TODO: Implement video playback, e.g., using video_player and a new screen
                    print('Playing video: ${videoData.videoUrl}');
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
