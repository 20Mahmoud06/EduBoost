import 'dart:io';
import 'package:flutter/material.dart';
import 'package:learny/pages/login.dart';
import 'package:learny/data/user_data.dart';
import 'package:learny/services/auth_service.dart'; // Import AuthService
// Import new pages
import 'package:learny/pages/schedule_page.dart';
import 'package:learny/pages/settings_page.dart';
import 'package:learny/pages/help_center_page.dart';

class NavigationMenu extends StatelessWidget {
  final UserData? userData;
  final AuthService _authService = AuthService(); // Instance for logout

  NavigationMenu({super.key, this.userData});

  Future<void> _showLogoutConfirmationDialog(
      BuildContext context,
      double baseFontSize,
      double basePadding,
      ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFAF2FE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Center(
            child: Text(
              'Logging out',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: baseFontSize * 1.2,
                color: Colors.black87,
                fontFamily: 'Afacad',
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure you want to log out?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: baseFontSize * 0.9,
                    color: Colors.black54,
                    fontFamily: 'Afacad',
                  ),
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: EdgeInsets.only(
              bottom: basePadding, left: basePadding, right: basePadding),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, foregroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0), side: const BorderSide(color: Colors.red, width: 1.5)),
                padding: EdgeInsets.symmetric(horizontal: basePadding * 1.5, vertical: basePadding * 0.5),
              ),
              child: Text(' Yes ', style: TextStyle(fontSize: baseFontSize * 0.9, fontWeight: FontWeight.bold, fontFamily: 'Afacad')),
              onPressed: () async { // Make async
                Navigator.of(dialogContext).pop(); // Dismiss dialog
                await _authService.logoutUser(); // Perform logout using AuthService
                // Ensure context is still valid before navigating
                if (Navigator.of(context).canPop()) { // Check if drawer is open
                  Navigator.of(context).pop(); // Close drawer if open
                }
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, foregroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0), side: const BorderSide(color: Colors.green, width: 1.5)),
                padding: EdgeInsets.symmetric(horizontal: basePadding * 1.5, vertical: basePadding * 0.5),
              ),
              child: Text(' No ', style: TextStyle(fontSize: baseFontSize * 0.9, fontWeight: FontWeight.bold, fontFamily: 'Afacad')),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double baseFontSize = screenWidth * 0.045;
    final double basePadding = screenWidth * 0.05;

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      backgroundColor: const Color(0xFFFAF2FE),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(
            context,
            userData: userData,
            baseFontSize: baseFontSize,
            basePadding: basePadding,
            avatarRadius: screenWidth * 0.1,
          ),
          _buildDrawerItem(
            image: 'assets/icons/Settings.png',
            text: 'Settings',
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
            },
            fontSize: baseFontSize * 0.95,
            iconSize: screenWidth * 0.065,
            itemPadding: basePadding,
          ),
          // "Messages" item removed
          _buildDrawerItem(
            image: 'assets/icons/Schedule.png',
            text: 'Schedule',
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SchedulePage()));
            },
            fontSize: baseFontSize * 0.95,
            iconSize: screenWidth * 0.065,
            itemPadding: basePadding,
          ),
          // "Progress" item removed
          _buildDrawerItem(
            image: 'assets/icons/Help center.png',
            text: 'Help center',
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpCenterPage()));
            },
            fontSize: baseFontSize * 0.95,
            iconSize: screenWidth * 0.065,
            itemPadding: basePadding,
          ),
          SizedBox(
            height: basePadding * 1.0,
          ),
          _buildLogoutButton(context, baseFontSize, basePadding, screenWidth),
          SizedBox(height: basePadding),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(
      BuildContext context, {
        required UserData? userData,
        required double baseFontSize,
        required double basePadding,
        required double avatarRadius,
      }) {
    final String displayName = userData?.fullName ?? "Guest User";
    final String displayId = userData?.email != null && userData!.email.isNotEmpty
        ? "ID: ${userData.email.hashCode.toString().substring(0, 8)}"
        : "ID: N/A";
    ImageProvider profileImageProvider;
    if (userData?.profileImageFile != null) {
      profileImageProvider = FileImage(userData!.profileImageFile!);
    } else {
      profileImageProvider = const AssetImage('assets/people/avatar.jpg'); // Ensure this default avatar exists
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: basePadding * 1.2,
        horizontal: basePadding,
      ),
      child: Column(
        children: [
          Text(
            'EduBoost',
            style: TextStyle(
              fontSize: baseFontSize * 1.4,
              fontWeight: FontWeight.bold,
              fontFamily: 'Afacad',
              color: Colors.black87,
            ),
          ),
          SizedBox(height: basePadding * 0.75),
          Row(
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundImage: profileImageProvider,
                child: (userData?.profileImageFile == null && !(profileImageProvider is FileImage)) // Simpler check for placeholder
                    ? Icon(Icons.person, size: avatarRadius * 0.8, color: Colors.grey[400]) // Adjusted placeholder icon
                    : null,
              ),
              SizedBox(width: basePadding * 0.7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: TextStyle(
                        fontSize: baseFontSize * 1.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontFamily: 'Afacad',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      displayId,
                      style: TextStyle(
                        fontSize: baseFontSize * 0.7,
                        color: Colors.grey,
                        fontFamily: 'Afacad',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String image,
    required String text,
    required VoidCallback onTap,
    required double fontSize,
    required double iconSize,
    required double itemPadding,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: itemPadding * 0.9,
        vertical: itemPadding * 0.1,
      ),
      leading: Image.asset(image, width: iconSize, height: iconSize, color: Colors.black54), // Added color to icons
      title: Text(
        text,
        style: TextStyle(
          fontFamily: 'Afacad',
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }
  Widget _buildLogoutButton(
      BuildContext context,
      double baseFontSize,
      double basePadding,
      double screenWidth,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: basePadding * 1.5,
      ),
      child: ElevatedButton(
        onPressed: () {
          _showLogoutConfirmationDialog(context, baseFontSize, basePadding);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
          elevation: 2,
          shadowColor: Colors.grey.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.red, width: 1.5),
          ),
          padding: EdgeInsets.symmetric(vertical: basePadding * 0.5),
          minimumSize: Size(screenWidth * 0.7, 0),
        ),
        child: Text(
          'Log out',
          style: TextStyle(
            fontSize: baseFontSize * 0.95,
            fontWeight: FontWeight.bold,
            fontFamily: 'Afacad',
          ),
        ),
      ),
    );
  }
}
