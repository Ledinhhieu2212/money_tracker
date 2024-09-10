import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_colors.dart';

class ButtonCustom extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const ButtonCustom({
    super.key,
    required this.onPressed,
    this.title = "Save",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: MaterialButton(
        onPressed: onPressed,
        color: const Color(blue),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Color(white), fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
