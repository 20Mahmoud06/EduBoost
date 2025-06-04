import 'package:flutter/material.dart';
// ### IMPORT THE CORRECT ITEM WIDGET ###
import 'package:learny/widgets/vertical_bottom_nav_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final double iconSize;
  final double labelSize;
  final double barHeight;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.iconSize,
    required this.labelSize,
    required this.barHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: barHeight,
      decoration: BoxDecoration(
        color: const Color(0xFFBF33FF), // Your purple background
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // ### USE VerticalBottomNavItem ###
          VerticalBottomNavItem(
            imageAssetPath: 'assets/buttons/enroll.png',
            label: 'Enroll',
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
            iconSize: iconSize,
            labelSize: labelSize,
            // selectedColor and unselectedColor will use defaults from VerticalBottomNavItem
            // which are suitable for a purple bar (white/white70)
          ),
          VerticalBottomNavItem(
            imageAssetPath: 'assets/buttons/classes.png',
            label: 'Classes',
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
            iconSize: iconSize,
            labelSize: labelSize,
          ),
          VerticalBottomNavItem(
            imageAssetPath: 'assets/buttons/account.png',
            label: 'Account',
            isSelected: currentIndex == 2,
            onTap: () => onTap(2),
            iconSize: iconSize,
            labelSize: labelSize,
          ),
        ],
      ),
    );
  }
}
