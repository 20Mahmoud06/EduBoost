import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For PlatformException
import 'package:learny/pages/login.dart';
import 'package:learny/pages/enroll_page.dart';
import 'package:learny/services/auth_service.dart';
import 'package:learny/data/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3), // Your animation duration
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Animation completed, now check auth status and navigate
          _checkAuthStatusAndNavigate();
        }
      });

    _animationController.forward();
  }

  // This method now explicitly tries to ensure SharedPreferences is ready
  // and handles potential errors during this check.
  Future<bool> _isSharedPreferencesReady() async {
    try {
      await SharedPreferences.getInstance();
      print("SharedPreferences confirmed ready in SplashScreen.");
      return true;
    } catch (e) {
      print("Error confirming SharedPreferences readiness in SplashScreen: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error initializing storage. Please restart the app. ($e)'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return false;
    }
  }

  Future<void> _checkAuthStatusAndNavigate() async {
    if (!mounted) return;

    bool prefsReady = await _isSharedPreferencesReady();
    if (!prefsReady) {
      // If prefs aren't ready even after the check, default to login or show error
      // This scenario should be rare if main() also initializes.
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
      return;
    }

    // Proceed with auth check now that SharedPreferences should be ready
    try {
      final String? email = await _authService.getCurrentUserEmail();
      if (email != null) {
        final UserData? userData = await _authService.getUserByEmail(email);
        if (userData != null && mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EnrollPage(userData: userData)),
          );
          return;
        }
      }
    } on PlatformException catch (e) { // Catching PlatformException specifically
      print("PlatformException during auth check: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Storage access error. Please try again. ($e)'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) { // Catching any other errors
      print("Error during auth check: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred. ($e)'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    // Fallback: If any error occurred or no user is logged in
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFC347FF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/logos/logo.png', // Make sure this path is correct
              width: screenWidth * 0.5,
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: LinearProgressIndicator(
              value: _progressAnimation.value,
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
