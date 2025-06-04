import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.backgroundColor,
    required this.textColor,
    required this.width, // This is for fontSize
    this.keyboardType,
    this.inputFormatters,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.suffixIcon,
    this.errorTextColor = Colors.red, // Default error text color to red
  });

  final String hint;
  final Color backgroundColor;
  final Color textColor;
  final double width; // This controls the font size
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Color errorTextColor; // Property for error text color

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0), // Internal padding for text field content
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField( // Using TextFormField for validation
          controller: widget.controller,
          validator: widget.validator,
          obscureText: _isObscured,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          cursorColor: widget.textColor,
          style: TextStyle(
            fontSize: widget.width, // widget.width is used as fontSize
            fontWeight: FontWeight.w500,
            fontFamily: 'Afacad',
            color: widget.textColor,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: widget.textColor.withOpacity(0.8),
              fontFamily: 'Afacad',
              fontWeight: FontWeight.w400,
              fontSize: widget.width,
            ),
            // Remove all borders from InputDecoration as Container handles it
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none, // Keep field background on error
            focusedErrorBorder: InputBorder.none, // Keep field background on error
            isDense: true, // Helps in controlling the height
            contentPadding: const EdgeInsets.symmetric(vertical: 16.0), // Consistent vertical padding
            suffixIcon: widget.isPassword
                ? GestureDetector(
              onTap: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
              child: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
                color: widget.textColor.withOpacity(0.8),
              ),
            )
                : widget.suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              minHeight: 24,
              minWidth: 24,
            ),
            errorStyle: TextStyle(
              color: widget.errorTextColor, // Use the passed error text color
              fontWeight: FontWeight.w500, // Optional: style error text
              fontSize: widget.width * 0.75, // Optional: slightly smaller error text
            ),
          ),
        ),
      ),
    );
  }
}
