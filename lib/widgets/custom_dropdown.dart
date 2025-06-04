import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String hint;
  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final String? Function(String?)? validator;
  final Color errorTextColor; // Property for error text color

  const CustomDropdownField({
    super.key,
    required this.hint,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.backgroundColor = const Color(0xFFBF33FF),
    this.textColor = Colors.white,
    required this.fontSize,
    this.validator,
    this.errorTextColor = Colors.red, // Default error text color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
              // ### SIMPLIFIED ERROR STYLE ###
              errorStyle: TextStyle(
                color: errorTextColor, // Directly use the passed errorTextColor
                fontWeight: FontWeight.w500,
                fontSize: fontSize * 0.75, // Optional: adjust error font size
              ),
              errorBorder: InputBorder.none, // Keep field background on error
              focusedErrorBorder: InputBorder.none, // Keep field background on error
            ),
            dropdownColor: backgroundColor,
            icon: Icon(Icons.keyboard_arrow_down, color: textColor),
            style: TextStyle(
              color: textColor,
              fontFamily: 'Afacad',
              fontSize: fontSize,
              fontWeight: FontWeight.w400,
            ),
            hint: Text(
              hint,
              style: TextStyle(
                color: textColor.withOpacity(0.8),
                fontFamily: 'Afacad',
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
              ),
            ),
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            isExpanded: true,
            selectedItemBuilder: (BuildContext context) {
              return items.map<Widget>((String item) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: textColor,
                      fontFamily: 'Afacad',
                      fontSize: fontSize,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
