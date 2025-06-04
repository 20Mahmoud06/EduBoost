import 'package:flutter/material.dart';

class Teachers extends StatelessWidget {
  const Teachers({
    super.key,
    this.width, // width and height are available if you need to enforce specific dimensions
    this.height,
    required this.image,
    required this.person,
    required this.grade,
    required this.subject,
    required this.curriculum,
    required this.onTap, // This is correctly defined to receive the callback
  });

  final double? width;
  final double? height;
  final String image;
  final String person;
  final String grade;
  final String subject;
  final String curriculum;
  final VoidCallback? onTap; // The callback to be executed on tap

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          final cardWidth = constraints.maxWidth;
          return GestureDetector(
            // onTap: () { }, // <<<--- OLD: This was an empty function
            onTap: onTap,    // <<<--- FIX: Use the onTap callback passed to the widget
            child: Card(
              color: const Color(0xFFC357FE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distributes space well
                  crossAxisAlignment: CrossAxisAlignment.center, // Ensures text is centered if it doesn't fill width
                  children: [
                    CircleAvatar(
                      radius: cardWidth * 0.28, // Slightly adjusted for better padding
                      backgroundImage: AssetImage(image),
                      onBackgroundImageError: (exception, stackTrace) { // Handles image load errors
                        // Optionally, log the error or display a placeholder icon
                        // For now, it will just show the default CircleAvatar background
                        print('Error loading image: $image');
                      },
                      child: AssetImage(image).assetName.isEmpty // Basic check if asset is empty string
                          ? Icon(Icons.person, size: cardWidth * 0.28, color: Colors.white70) // Placeholder icon
                          : null,
                    ),
                    const SizedBox(height: 8), // Added some spacing
                    Text(
                      person,
                      textAlign: TextAlign.center,
                      maxLines: 2, // Allow for longer names to wrap
                      overflow: TextOverflow.ellipsis, // Handle overflow
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: cardWidth * 0.095, // Adjusted for readability
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4), // Added some spacing
                    Column( // Kept this column for grouping info texts
                      children: [
                        Text(
                          grade,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: cardWidth * 0.075, // Adjusted
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          subject,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: cardWidth * 0.075, // Adjusted
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          curriculum,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: cardWidth * 0.075, // Adjusted
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
