import 'package:flutter/material.dart';
import 'package:learny/services/auth_service.dart'; // Your AuthService
import 'package:learny/data/user_data.dart';       // Your UserData model
import 'package:learny/pages/login.dart';         // To navigate back to login

class ResetPasswordScreen extends StatefulWidget {
  final String email; // Email of the user resetting password

  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  static const Color primaryPurpleColor = Color(0xFFBF33FF); // From LoginScreen
  static const Color lightPurpleHintColor = Color(0xFFAB47BC);
  static const Color textFieldBackgroundColor = Colors.white;


  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _isLoading = true);

    final newPassword = _newPasswordController.text;
    UserData? userToUpdate = await _authService.getUserByEmail(widget.email);

    if (userToUpdate != null) {
      // Create a new UserData object with the updated password
      UserData updatedUser = UserData(
        firstName: userToUpdate.firstName,
        lastName: userToUpdate.lastName,
        email: userToUpdate.email,
        password: newPassword, // Set the new password
        phoneNumber: userToUpdate.phoneNumber,
        nationality: userToUpdate.nationality,
        city: userToUpdate.city,
        school: userToUpdate.school,
        gender: userToUpdate.gender,
        day: userToUpdate.day,
        month: userToUpdate.month,
        year: userToUpdate.year,
        profileImagePath: userToUpdate.profileImagePath,
        profileImageFile: userToUpdate.profileImageFile,
      );

      bool success = await _authService.updateUser(updatedUser);
      if (!mounted) return;
      setState(() => _isLoading = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset successfully! Please log in with your new password.'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate back to Login Screen, removing all routes until LoginScreen
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => route.isFirst, // Or (route) => false if you want to clear everything
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to reset password. Please try again.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } else {
      // Should not happen if email was validated on previous screen
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: User not found.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureState,
    required VoidCallback onVisibilityToggle,
    FormFieldValidator<String>? validator,
    required double screenWidth,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: textFieldBackgroundColor,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ]
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureState,
        style: TextStyle(color: primaryPurpleColor, fontFamily: 'Afacad', fontSize: screenWidth * 0.045),
        cursorColor: primaryPurpleColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: lightPurpleHintColor.withOpacity(0.7), fontFamily: 'Afacad', fontSize: screenWidth * 0.045),
          prefixIcon: Icon(Icons.lock_outline, color: lightPurpleHintColor, size: screenWidth * 0.055),
          suffixIcon: IconButton(
            icon: Icon(
              obscureState ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: lightPurpleHintColor,
              size: screenWidth * 0.055,
            ),
            onPressed: onVisibilityToggle,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.04, horizontal: screenWidth * 0.05),
        ),
        validator: validator,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryPurpleColor,
      appBar: AppBar(
        title: const Text('Reset Password', style: TextStyle(color: Colors.white, fontFamily: 'Afacad')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), // For back button
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Create New Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  _buildPasswordField(
                    controller: _newPasswordController,
                    hintText: 'New Password',
                    obscureState: _obscureNewPassword,
                    onVisibilityToggle: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
                    screenWidth: screenWidth,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter a new password';
                      if (value.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm New Password',
                    obscureState: _obscureConfirmPassword,
                    onVisibilityToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                    screenWidth: screenWidth,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please confirm your new password';
                      if (value != _newPasswordController.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                      : ElevatedButton(
                    onPressed: _resetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: primaryPurpleColor,
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      textStyle: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Reset Password'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
