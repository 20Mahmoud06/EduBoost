import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFBF33FF), // Purple background
      elevation: 2.0, // Optional: adds a slight shadow
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white,size: 30,), // White hamburger icon
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Opens the drawer
        },
      ),
      // titleSpacing: 0, // Adjust if needed to bring "En" closer to menu icon
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // The "En" Text Button
          // TextButton(
          //   onPressed: () {
          //     // TODO: Implement language change functionality
          //     print('Language button (En) tapped!');
          //     // You might want to show a language selection dialog or navigate
          //   },
          //   style: TextButton.styleFrom(
          //     padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust padding as needed
          //     minimumSize: const Size(0, 0), // Allow smaller size if needed
          //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //   ),
          //   child: const Text(
          //     'En',
          //     style: TextStyle(
          //       fontFamily: 'Afacad', // Or your desired font
          //       color: Colors.white,
          //       fontSize: 18, // Adjust size as needed
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),
          // const SizedBox(width: 10), // Spacing between "En" and "EduBoost"
          // The "EduBoost" Title
          const Text(
            'EduBoost',
            style: TextStyle(
              fontFamily: 'Afacad', // Or your desired font
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 30, // Adjust size as needed
            ),
          ),
        ],
      ),
      centerTitle: false , // Set to false to allow the Row to align start
      // If you want "EduBoost" more centered overall,
      // you might need a more complex title structure or use flexible spacing.
      // For the image provided, `centerTitle: false` with the Row seems appropriate.
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height
}
