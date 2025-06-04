import 'package:flutter/material.dart';
import 'package:learny/services/auth_service.dart'; // Your AuthService
import 'package:learny/pages/ResetPasswordScreen.dart'; // We'll create this next
// Assuming _buildTextField styling is similar to LoginScreen,
// or you can create a shared custom text field widget.

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  static const Color primaryPurpleColor = Color(0xFFBF33FF); // From LoginScreen
  static const Color lightPurpleHintColor = Color(0xFFAB47BC);
  static const Color textFieldBackgroundColor = Colors.white;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _isLoading = true);

    final email = _emailController.text;
    final userExists = await _authService.getUserByEmail(email);

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (userExists != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(email: email),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No account found with this email address.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Widget _buildEmailField(double screenWidth) {
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
        controller: _emailController,
        style: TextStyle(color: primaryPurpleColor, fontFamily: 'Afacad', fontSize: screenWidth * 0.045),
        cursorColor: primaryPurpleColor,
        decoration: InputDecoration(
          hintText: 'Enter your Email',
          hintStyle: TextStyle(color: lightPurpleHintColor.withOpacity(0.7), fontFamily: 'Afacad', fontSize: screenWidth * 0.045),
          prefixIcon: Icon(Icons.email_outlined, color: lightPurpleHintColor, size: screenWidth * 0.055),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.04, horizontal: screenWidth * 0.05),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Please enter your email';
          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return 'Please enter a valid email';
          return null;
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: primaryPurpleColor,
      appBar: AppBar( // Simple AppBar for back navigation
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                    'Forgot Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Enter your email address and we\'ll help you reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: screenWidth * 0.04,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  _buildEmailField(screenWidth),
                  SizedBox(height: screenHeight * 0.04),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
                      : ElevatedButton(
                    onPressed: _submitEmail,
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
                    child: const Text('Submit'),
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
