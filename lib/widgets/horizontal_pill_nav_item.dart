import 'package:flutter/material.dart';

class HorizontalPillNavItem extends StatelessWidget {
  final String imageAssetPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedIconColor;
  final Color selectedTextColor;
  final double iconSize;
  final double labelSize;
  final double spacingBetweenIconAndText;
  final Color pillBackgroundColor;

  const HorizontalPillNavItem({
    super.key,
    required this.imageAssetPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = Colors.white,
    this.unselectedIconColor = Colors.white,
    this.selectedTextColor = Colors.white,
    this.iconSize = 24.0,
    this.labelSize = 12.0,
    this.spacingBetweenIconAndText = 6.0,
    this.pillBackgroundColor = Colors.white24,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (isSelected) {
      content = Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0), // Your existing padding for selected
        decoration: BoxDecoration(
          color: pillBackgroundColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageAssetPath,
              width: iconSize,
              height: iconSize,
              color: selectedColor,
            ),
            SizedBox(width: spacingBetweenIconAndText),
            Text(
              label,
              style: TextStyle(
                color: selectedTextColor,
                fontSize: labelSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'Afacad',
              ),
            ),
          ],
        ),
      );
    } else {
      // Unselected state: Just the icon
      content = Padding(
        // ### FIX IS HERE ###
        // Use a similar padding as the selected state for consistency,
        // or EdgeInsets.zero if you want no padding for the unselected icon.
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
        child: Image.asset(
          imageAssetPath,
          width: iconSize,
          height: iconSize,
          color: unselectedIconColor,
        ),
      );
    }

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.0),
        child: Center(
          child: content,
        ),
      ),
    );
  }
}
