import 'package:flutter/material.dart';
import 'package:learny/data/user_data.dart';
import 'package:learny/pages/enroll_page.dart';
import 'package:learny/pages/new_account.dart';
import 'package:learny/services/auth_service.dart';

import 'ForgotPasswordScreen.dart';
// Removed CustomTextField import as we'll define fields locally for this specific style

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true; // To toggle password visibility

  static const Color primaryPurpleColor = Color(0xFFBF33FF); // Darker purple from image
  static const Color lightPurpleHintColor = Color(0xFFAB47BC); // Lighter purple for hints
  static const Color textFieldBackgroundColor = Colors.white;
  static const Color buttonTextColor = primaryPurpleColor;
  static const Color mainTextColor = Colors.white;


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String email = _emailController.text;
    final String password = _passwordController.text;

    UserData? loggedInUser = await _authService.loginUser(email, password);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (loggedInUser != null) {
      await _authService.saveCurrentUserSession(loggedInUser.email);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EnrollPage(userData: loggedInUser)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password. Please try again.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _forgotPassword() {
    // Navigate to the ForgotPasswordScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
    FormFieldValidator<String>? validator,
    required double screenWidth,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: textFieldBackgroundColor,
          borderRadius: BorderRadius.circular(25.0), // More rounded
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
        obscureText: isPassword ? _obscurePassword : false,
        style: TextStyle(color: primaryPurpleColor, fontFamily: 'Afacad', fontSize: screenWidth * 0.045),
        cursorColor: primaryPurpleColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: lightPurpleHintColor.withOpacity(0.7), fontFamily: 'Afacad', fontSize: screenWidth * 0.045),
          prefixIcon: Icon(prefixIcon, color: lightPurpleHintColor, size: screenWidth * 0.055),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: lightPurpleHintColor,
              size: screenWidth * 0.055,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          )
              : null,
          border: InputBorder.none, // Remove default border
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
      backgroundColor: primaryPurpleColor, // Purple background for the whole screen
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  // App Logo
                  Image.asset(
                    'assets/logos/logo.png', // Assuming you have a white version of your logo
                    height: screenHeight * 0.3,
                    // width: screenWidth * 0.4, // Adjust as needed
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    'Log In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Afacad', // Or your preferred title font
                      fontSize: screenWidth * 0.1,
                      fontWeight: FontWeight.bold,
                      color: mainTextColor,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    screenWidth: screenWidth,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your email';
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'Please enter a valid email';
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.025),
                  _buildTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    screenWidth: screenWidth,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your password';
                      return null;
                    },
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                      : ElevatedButton(
                    onPressed: _loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: buttonTextColor,
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
                    child: const Text('Log in'),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextButton(
                    onPressed: _forgotPassword,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        color: mainTextColor.withOpacity(0.8),
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    children: <Widget>[
                      const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.white70, fontSize: screenWidth * 0.035, fontFamily: 'Afacad'),
                        ),
                      ),
                      const Expanded(child: Divider(color: Colors.white54, thickness: 1)),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewAccount()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      textStyle: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: screenWidth * 0.048,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('Create new account'),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
