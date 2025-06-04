import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final String imageAssetPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final double iconSize;
  final double labelSize;

  const BottomNavItem({
    super.key,
    required this.imageAssetPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = Colors.white, // Selected items on purple bar are white
    this.unselectedColor = Colors.white70, // Dimmer white for unselected items
    this.iconSize = 28.0, // Default icon size, can be overridden
    this.labelSize = 12.0,  // Default label size, can be overridden
  });

  @override
  Widget build(BuildContext context) {
    // Determine current color based on selection state for both icon and text
    final Color itemColor = isSelected ? selectedColor : unselectedColor;
    final FontWeight itemFontWeight = isSelected ? FontWeight.bold : FontWeight.normal;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0), // Optional: for tap ripple effect
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0), // Padding around the column
          child: Column(
            mainAxisSize: MainAxisSize.min, // Column takes minimum vertical space
            mainAxisAlignment: MainAxisAlignment.center, // Centers content (Icon & Text) vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Centers content horizontally
            children: [
              Image.asset(
                imageAssetPath,
                width: iconSize,
                height: iconSize,
                color: itemColor, // Apply tinting based on selection
                // If your assets are already colored for selected/unselected states,
                // you might remove this 'color' property from Image.asset.
                // Ensure the original assets are suitable for tinting (e.g., white or single color).
              ),
              const SizedBox(height: 4), // Space between icon and text
              Text(
                label,
                style: TextStyle(
                  color: itemColor, // Text color also changes with selection
                  fontSize: labelSize,
                  fontWeight: itemFontWeight,
                  fontFamily: 'Afacad', // Assuming you want this font
                ),
                overflow: TextOverflow.ellipsis, // Handle long labels
                maxLines: 1, // Ensure label is on one line
              ),
            ],
          ),
        ),
      ),
    );
  }
}
