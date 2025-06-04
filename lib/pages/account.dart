import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learny/data/user_data.dart';
import 'package:learny/pages/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learny/pages/new_account.dart';
import 'package:learny/services/auth_service.dart'; // Import AuthService

const double basePadding = 16.0;

class Account extends StatefulWidget {
  final UserData userData;

  const Account({super.key, required this.userData});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late UserData _currentUserData;
  File? _profileImageFile;
  final AuthService _authService = AuthService(); // Instance of AuthService

  @override
  void initState() {
    super.initState();
    _currentUserData = widget.userData;
    _profileImageFile = _currentUserData.profileImageFile;
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        if (!mounted) return;
        setState(() {
          _profileImageFile = File(pickedFile.path);
          _currentUserData = UserData(
            firstName: _currentUserData.firstName,
            lastName: _currentUserData.lastName,
            email: _currentUserData.email,
            password: _currentUserData.password,
            phoneNumber: _currentUserData.phoneNumber,
            nationality: _currentUserData.nationality,
            city: _currentUserData.city,
            school: _currentUserData.school,
            gender: _currentUserData.gender,
            day: _currentUserData.day,
            month: _currentUserData.month,
            year: _currentUserData.year,
            profileImageFile: _profileImageFile,
            profileImagePath: _profileImageFile?.path,
          );
          // Optionally, update the user data in AuthService if image changes are persisted
          // await _authService.updateUser(_currentUserData);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Widget _buildDetailRow({
    required String label1,
    required String value1,
    String? label2,
    String? value2,
    required double baseFontSize,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: baseFontSize * 1.2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label1,
                  style: TextStyle(
                    fontSize: baseFontSize * 0.95,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Afacad',
                    color: Colors.black87.withOpacity(0.9),
                  ),
                ),
                SizedBox(height: baseFontSize * 0.25),
                Text(
                  value1,
                  style: TextStyle(
                    fontSize: baseFontSize * 0.9,
                    fontFamily: 'Afacad',
                    color: Colors.black87.withOpacity(0.75),
                  ),
                ),
              ],
            ),
          ),
          if (label2 != null && value2 != null) ...[
            SizedBox(width: baseFontSize),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label2,
                    style: TextStyle(
                      fontSize: baseFontSize * 0.95,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Afacad',
                      color: Colors.black87.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: baseFontSize * 0.25),
                  Text(
                    value2,
                    style: TextStyle(
                      fontSize: baseFontSize * 0.9,
                      fontFamily: 'Afacad',
                      color: Colors.black87.withOpacity(0.75),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog(
      double baseFontSize,
      double extBasePadding,
      ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFAF2FE),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Center(child: Text('Logging out', style: TextStyle(fontWeight: FontWeight.bold, fontSize: baseFontSize * 1.2, color: Colors.black87, fontFamily: 'Afacad'))),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[Text('Are you sure you want to log out?', textAlign: TextAlign.center, style: TextStyle(fontSize: baseFontSize * 0.9, color: Colors.black54, fontFamily: 'Afacad'))])),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: EdgeInsets.only(bottom: extBasePadding, left: extBasePadding, right: extBasePadding),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0), side: const BorderSide(color: Colors.red, width: 1.5)), padding: EdgeInsets.symmetric(horizontal: extBasePadding * 1.5, vertical: extBasePadding * 0.5)),
              child: Text(' Yes ', style: TextStyle(fontSize: baseFontSize * 0.9, fontWeight: FontWeight.bold, fontFamily: 'Afacad')),
              onPressed: () async { // Made async
                Navigator.of(dialogContext).pop(); // Dismiss dialog
                await _authService.logoutUser(); // Clear session
                if (!mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                );
                print('User confirmed logout! Navigating to LoginScreen.');
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0), side: const BorderSide(color: Colors.green, width: 1.5)), padding: EdgeInsets.symmetric(horizontal: extBasePadding * 1.5, vertical: extBasePadding * 0.5)),
              child: Text(' No ', style: TextStyle(fontSize: baseFontSize * 0.9, fontWeight: FontWeight.bold, fontFamily: 'Afacad')),
              onPressed: () { Navigator.of(dialogContext).pop(); },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteAccountConfirmationDialog(
      double baseFontSize,
      double extBasePadding,
      ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFAF2FE),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Center(child: Text('Delete Account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: baseFontSize * 1.2, color: Colors.red[700], fontFamily: 'Afacad'))),
          content: SingleChildScrollView(child: ListBody(children: <Widget>[Text('Are you sure you want to permanently delete your account? This action cannot be undone.', textAlign: TextAlign.center, style: TextStyle(fontSize: baseFontSize * 0.9, color: Colors.black87, fontFamily: 'Afacad'))])),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: EdgeInsets.only(bottom: extBasePadding, left: extBasePadding, right: extBasePadding),
          actions: <Widget>[
            ElevatedButton( // Changed "Delete" button to be primary action here
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700], foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)), padding: EdgeInsets.symmetric(horizontal: extBasePadding * 1.5, vertical: extBasePadding * 0.5)),
              child: Text('Delete', style: TextStyle(fontSize: baseFontSize * 0.9, fontWeight: FontWeight.bold, fontFamily: 'Afacad')),
              onPressed: () async { // Make onPressed async
                Navigator.of(dialogContext).pop(); // Dismiss the dialog first

                bool deleted = await _authService.deleteUser(_currentUserData.email);
                if (!mounted) return;

                if (deleted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Account deleted successfully.'), backgroundColor: Colors.green),
                  );
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to delete account. User not found or error occurred.'), backgroundColor: Colors.red),
                  );
                }
                print('User confirmed account deletion! Attempted delete for: ${_currentUserData.email}');
              },
            ),
            TextButton(
              child: Text('Cancel', style: TextStyle(fontSize: baseFontSize * 0.9, color: Colors.grey[700], fontFamily: 'Afacad')),
              onPressed: () { Navigator.of(dialogContext).pop(); },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double baseFontSize = screenWidth * 0.04;
    final double avatarRadius = screenWidth * 0.14;
    final double avatarTopPadding = screenWidth * 0.06;
    final double containerTopOffset = avatarTopPadding + avatarRadius;
    final double contentTopSpacerHeight = avatarRadius * 0.8;
    final String userId = _currentUserData.email.hashCode.toString().substring(0,8);
    final double localBasePadding = screenWidth * 0.04;

    final ButtonStyle lightPurpleButtonStyle = ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFFBF33FF), padding: EdgeInsets.symmetric(horizontal: baseFontSize * 2.2, vertical: baseFontSize * 0.9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: const BorderSide(color: Color(0xFFBF33FF), width: 1.5)), elevation: 2, shadowColor: Colors.grey.withOpacity(0.2));
    final ButtonStyle logoutButtonStyle = ElevatedButton.styleFrom(backgroundColor: const Color(0xFFBF33FF), foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: baseFontSize * 4.5, vertical: baseFontSize * 1.0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: const BorderSide(color: Color(0xFFBF33FF), width: 1.5)), elevation: 3);

    return Stack(
      children: [
        Positioned(
          top: containerTopOffset,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            margin: EdgeInsets.all(localBasePadding * 0.75),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
              color: const Color(0xFFF0E0FF),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: localBasePadding * 1.2, right: localBasePadding * 1.2, top: contentTopSpacerHeight + localBasePadding * 0.2, bottom: localBasePadding * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_currentUserData.fullName, style: TextStyle(fontSize: baseFontSize * 1.6, fontWeight: FontWeight.bold, fontFamily: 'Afacad', color: Colors.black87)),
                    SizedBox(height: baseFontSize * 0.2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("ID: $userId", style: TextStyle(fontSize: baseFontSize * 0.85, fontFamily: 'Afacad', color: Colors.black54)),
                        SizedBox(width: baseFontSize * 0.4),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: userId)).then((_) {
                              if(!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('ID is copied to the clipboard', textAlign: TextAlign.center, style: TextStyle(color: Colors.black87, fontFamily: 'Afacad')), backgroundColor: const Color(0xFFE6D8FF), behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 20), elevation: 4));
                            });
                          },
                          child: Icon(Icons.copy_outlined, size: baseFontSize * 0.9, color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(height: baseFontSize * 0.2),
                    SizedBox(height: baseFontSize * 1.5),
                    _buildDetailRow(label1: "Email", value1: _currentUserData.email, baseFontSize: baseFontSize),
                    _buildDetailRow(label1: "Phone Number", value1: _currentUserData.phoneNumber, baseFontSize: baseFontSize),
                    _buildDetailRow(label1: "Nationality", value1: _currentUserData.nationality ?? "N/A", label2: "City", value2: _currentUserData.city, baseFontSize: baseFontSize),
                    _buildDetailRow(label1: "School", value1: _currentUserData.school, baseFontSize: baseFontSize),
                    _buildDetailRow(label1: "Gender", value1: _currentUserData.gender, label2: "Date of Birth", value2: _currentUserData.dateOfBirth, baseFontSize: baseFontSize),
                    SizedBox(height: baseFontSize * 1.8),
                    ElevatedButton(
                      onPressed: () async {
                        final updatedData = await Navigator.push<UserData>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewAccount(existingUserData: _currentUserData),
                          ),
                        );
                        if (updatedData != null && mounted) {
                          setState(() {
                            _currentUserData = updatedData;
                            _profileImageFile = updatedData.profileImageFile;
                          });
                        }
                      },
                      style: lightPurpleButtonStyle,
                      child: Text("Edit info", style: TextStyle(fontFamily: 'Afacad', fontSize: baseFontSize * 0.9, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: baseFontSize * 0.8),
                    ElevatedButton(
                      onPressed: () { _showLogoutConfirmationDialog(baseFontSize, localBasePadding); },
                      style: logoutButtonStyle,
                      child: Text("Log out", style: TextStyle(fontFamily: 'Afacad', fontSize: baseFontSize * 1.0, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: baseFontSize * 0.6),
                    TextButton(
                      onPressed: () {
                        _showDeleteAccountConfirmationDialog(baseFontSize, localBasePadding);
                      },
                      child: Text("Delete account", style: TextStyle(fontFamily: 'Afacad', fontSize: baseFontSize * 0.9, color: Colors.red)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: avatarTopPadding),
            child: GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: avatarRadius - 5,
                  backgroundImage: _profileImageFile != null
                      ? FileImage(_profileImageFile!)
                      : (_currentUserData.profileImageFile != null
                      ? FileImage(_currentUserData.profileImageFile!)
                      : const AssetImage('assets/people/avatar.jpg')) as ImageProvider<Object>?,
                  child: _profileImageFile == null && _currentUserData.profileImageFile == null
                      ? Icon(Icons.add_a_photo_outlined, size: avatarRadius * 0.6, color: Colors.grey[400])
                      : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
