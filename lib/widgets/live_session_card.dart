import 'package:flutter/material.dart';
import 'package:learny/data/live_session_data.dart';

import '../data/live_session_status.dart'; // Import LiveSessionData

class LiveSessionCard extends StatelessWidget {
  final LiveSessionData sessionData; // <<< Parameter is 'sessionData'

  const LiveSessionCard({super.key, required this.sessionData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double titleFontSize = screenWidth * 0.045;
    final double detailFontSize = screenWidth * 0.035;
    final double dateFontSize = screenWidth * 0.032;
    final Color cardBorderColor = Colors.deepPurple.shade100;
    final Color primaryTextColor = const Color(0xFF271132);
    final Color secondaryTextColor = Colors.deepPurple.shade700;
    final Color joinButtonColor = Colors.deepPurple.shade400;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: cardBorderColor, width: 1.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sessionData.title, // Uses sessionData
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Afacad',
                          color: primaryTextColor,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.01),
                      Text(
                        sessionData.description, // Uses sessionData
                        style: TextStyle(
                          fontSize: detailFontSize,
                          fontFamily: 'Afacad',
                          color: secondaryTextColor,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.005),
                      Text(
                        sessionData.homework, // Uses sessionData
                        style: TextStyle(
                          fontSize: detailFontSize,
                          fontFamily: 'Afacad',
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (sessionData.status == LiveSessionStatus.ongoing)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        print('Joining session: ${sessionData.title}');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: joinButtonColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Join',
                        style: TextStyle(fontSize: detailFontSize, fontFamily: 'Afacad'),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              '${sessionData.date}    ${sessionData.time}', // Uses sessionData
              style: TextStyle(
                fontSize: dateFontSize,
                fontFamily: 'Afacad',
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
