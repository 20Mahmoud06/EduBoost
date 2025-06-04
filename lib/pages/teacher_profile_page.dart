// lib/pages/teacher_profile_page.dart
import 'package:flutter/material.dart';
import 'package:learny/widgets/custom_appbar.dart'; // Assuming this exists
import 'package:learny/widgets/horizontal_pill_nav_item.dart'; // Assuming this exists
import 'package:learny/pages/live_section.dart';
import 'package:learny/pages/video.dart';
import 'package:learny/pages/tasks_section.dart';
import 'package:learny/data/teacher_profile_data.dart';

class TeacherProfilePage extends StatefulWidget {
  final TeacherProfileData teacherData;

  const TeacherProfilePage({super.key, required this.teacherData});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  int _selectedSectionIndex = 0; // Default to 'Live' or first tab
  late List<Widget> _sectionPageOptions;

  @override
  void initState() {
    super.initState();
    _sectionPageOptions = <Widget>[
      LiveSection(teacherData: widget.teacherData),   // Index 0 for Live
      Video(teacherData: widget.teacherData),         // Index 1 for Videos
      TasksSection(teacherData: widget.teacherData),  // Index 2 for Tasks
    ];
  }

  void _onSectionItemTapped(int index) {
    setState(() {
      _selectedSectionIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double sectionNavIconSize = screenWidth * 0.055;
    final double sectionNavLabelSize = screenWidth * 0.03;
    final double sectionNavBarHeight = screenHeight * 0.08; // Adjusted for typical bottom nav bar height

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // Assuming CustomAppbar is a PreferredSizeWidget or similar
        appBar: const CustomAppbar(), // Make sure this widget is correctly implemented
        body: Column(
          children: [
            // Teacher Info Header (as you had it)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border(bottom: BorderSide(color: Colors.grey.shade300))
              ),
              child: AppBar(
                backgroundColor: Colors.transparent, // Make AppBar transparent to use container's decoration
                elevation: 0,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min, // Important to keep title centered
                  children: [
                    Text(
                      widget.teacherData.name,
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: screenWidth * 0.048,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '(${widget.teacherData.subject})',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: screenWidth * 0.042,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                centerTitle: true, // This ensures the Row itself is centered
              ),
            ),
            Expanded(
              child: IndexedStack( // Using IndexedStack to preserve state of each tab
                index: _selectedSectionIndex,
                children: _sectionPageOptions,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: sectionNavBarHeight,
          decoration: const BoxDecoration(
            color: Color(0xFFBF33FF), // Your theme purple color
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(20),
            //   topRight: Radius.circular(20),
            // ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.1),
            //     spreadRadius: 0,
            //     blurRadius: 10,
            //   ),
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              HorizontalPillNavItem(
                imageAssetPath: 'assets/buttons/live.png', // Ensure asset exists
                label: 'Live', // Changed from 'Lives'
                isSelected: _selectedSectionIndex == 0,
                onTap: () => _onSectionItemTapped(0),
                iconSize: sectionNavIconSize,
                labelSize: sectionNavLabelSize,
                selectedColor: Colors.white,
                unselectedIconColor: Colors.white.withOpacity(0.7),
                selectedTextColor: Colors.white,
                pillBackgroundColor: Colors.white.withOpacity(0.25),
              ),
              HorizontalPillNavItem(
                imageAssetPath: 'assets/buttons/videos.png', // Ensure asset exists
                label: 'Videos',
                isSelected: _selectedSectionIndex == 1,
                onTap: () => _onSectionItemTapped(1),
                iconSize: sectionNavIconSize,
                labelSize: sectionNavLabelSize,
                selectedColor: Colors.white,
                unselectedIconColor: Colors.white.withOpacity(0.7),
                selectedTextColor: Colors.white,
                pillBackgroundColor: Colors.white.withOpacity(0.25),
              ),
              HorizontalPillNavItem(
                imageAssetPath: 'assets/buttons/tasks.png', // Ensure asset exists
                label: 'Tasks',
                isSelected: _selectedSectionIndex == 2,
                onTap: () => _onSectionItemTapped(2),
                iconSize: sectionNavIconSize,
                labelSize: sectionNavLabelSize,
                selectedColor: Colors.white,
                unselectedIconColor: Colors.white.withOpacity(0.7),
                selectedTextColor: Colors.white,
                pillBackgroundColor: Colors.white.withOpacity(0.25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy CustomAppbar for compilation if you don't have it.
// Replace with your actual CustomAppbar.
class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('EduBoost', style: TextStyle(fontFamily: 'Afacad', color: Color(0xFFBF33FF))),
      backgroundColor: Colors.white,
      elevation: 1,
      iconTheme: const IconThemeData(color: Color(0xFFBF33FF)),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Dummy HorizontalPillNavItem for compilation.
// Replace with your actual HorizontalPillNavItem.
class HorizontalPillNavItem extends StatelessWidget {
  final String imageAssetPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double iconSize;
  final double labelSize;
  final Color selectedColor;
  final Color unselectedIconColor;
  final Color selectedTextColor;
  final Color pillBackgroundColor;

  const HorizontalPillNavItem({
    super.key,
    required this.imageAssetPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.iconSize = 24,
    this.labelSize = 12,
    this.selectedColor = Colors.blue,
    this.unselectedIconColor = Colors.grey,
    this.selectedTextColor = Colors.blue,
    this.pillBackgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? pillBackgroundColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                imageAssetPath,
                width: iconSize,
                height: iconSize,
                color: isSelected ? selectedColor : unselectedIconColor,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: iconSize, color: Colors.red),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                    fontSize: labelSize,
                    color: isSelected ? selectedTextColor : unselectedIconColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontFamily: 'Afacad'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
