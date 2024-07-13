import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:money_tracker/model/Styles/colors.dart';
import 'package:money_tracker/model/Styles/app_style.dart';

class ButtonCustom extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  const ButtonCustom({
    super.key,
    required this.onPressed,
    this.title = "Save",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48,
        width: getScreenWidth(context),
        child: FilledButton.tonal(
          onPressed: onPressed,
          style: FilledButton.styleFrom(backgroundColor: blue),
          child: Text(
            title,
            style: TextStyle(color: white),
          ),
        ),
      ),
    );
  }
}
