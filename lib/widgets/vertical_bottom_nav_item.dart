import 'package:flutter/material.dart';

class VerticalBottomNavItem extends StatelessWidget {
  final String imageAssetPath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final double iconSize;
  final double labelSize;

  const VerticalBottomNavItem({
    super.key,
    required this.imageAssetPath,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = Colors.white, // White for selected on purple bar
    this.unselectedColor = Colors.white70, // Dimmer white for unselected
    this.iconSize = 28.0,
    this.labelSize = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final Color itemColor = isSelected ? selectedColor : unselectedColor;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imageAssetPath,
                width: iconSize,
                height: iconSize,
                color: itemColor, // Apply tinting
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: itemColor,
                  fontSize: labelSize,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontFamily: 'Afacad',
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
