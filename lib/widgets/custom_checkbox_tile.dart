import 'package:flutter/material.dart';

class CustomCheckboxTile extends StatefulWidget {
  const CustomCheckboxTile({
    super.key,
    required this.title,
    required this.initialValue,
    required this.onChanged,
    required this.backgroundColor,
    required this.textColor,
    required this.fontSize,
  });

  final String title;
  final bool initialValue;
  final ValueChanged<bool> onChanged;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;

  @override
  State<CustomCheckboxTile> createState() => _CustomCheckboxTileState();
}

class _CustomCheckboxTileState extends State<CustomCheckboxTile> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  @override
  void didUpdateWidget(CustomCheckboxTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        _isChecked = widget.initialValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _isChecked = !_isChecked;
            widget.onChanged(_isChecked);
          });
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'Afacad',
                  fontWeight: FontWeight.w400,
                  fontSize: widget.fontSize,
                  color: widget.textColor.withOpacity(0.8),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: _isChecked
                    ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                )
                    : BoxDecoration(
                  border: Border.all(
                    color: widget.textColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: _isChecked
                    ? Icon(
                  Icons.check,
                  size: 18.0,
                  color: widget.backgroundColor,
                )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
