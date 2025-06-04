// lib/data/video_content_data.dart
class VideoContentData {
  final String id;
  final String title;
  final String videoThumbnailAsset; // Ensure this asset exists in your project
  final String description;
  final String homework;
  final String date;
  final String? videoUrl; // Optional: for playing the video

  VideoContentData({
    required this.id,
    required this.title,
    required this.videoThumbnailAsset,
    required this.description,
    required this.homework,
    required this.date,
    this.videoUrl,
  });
}
