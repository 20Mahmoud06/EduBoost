import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center', style: TextStyle(fontFamily: 'Afacad', color: Colors.white)),
        backgroundColor: const Color(0xFFBF33FF), // Your app's primary color
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildHelpItem(
            context,
            icon: Icons.question_answer_outlined,
            title: 'Frequently Asked Questions (FAQ)',
            onTap: () {
              // TODO: Navigate to FAQ section or show FAQ content
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('FAQ section tapped (Not implemented)')),
              );
            },
          ),
          const Divider(),
          _buildHelpItem(
            context,
            icon: Icons.contact_support_outlined,
            title: 'Contact Support',
            onTap: () {
              // TODO: Implement contact support (e.g., email, chat link)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contact Support tapped (Not implemented)')),
              );
            },
          ),
          const Divider(),
          _buildHelpItem(
            context,
            icon: Icons.policy_outlined,
            title: 'Terms of Service',
            onTap: () {
              // TODO: Navigate to Terms of Service page or link
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Terms of Service tapped (Not implemented)')),
              );
            },
          ),
          const Divider(),
          _buildHelpItem(
            context,
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {
              // TODO: Navigate to Privacy Policy page or link
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy Policy tapped (Not implemented)')),
              );
            },
          ),
          // Add more help topics here
        ],
      ),
    );
  }

  Widget _buildHelpItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFBF33FF), size: 28),
      title: Text(title, style: const TextStyle(fontFamily: 'Afacad', fontSize: 18, color: Colors.black87)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}
