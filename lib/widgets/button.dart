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
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: const Color(blue)),
        child: Text(
          title,
          style: const TextStyle(color: Color(white)), 
        ), 
      ),
    );
  }
}
