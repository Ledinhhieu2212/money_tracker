import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_style.dart';
import 'package:money_tracker/constants/app_colors.dart';

Widget customButtonBackground({
  VoidCallback? onPressed,
  required String? title,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 48,
      width: getScreenWidth(context),
      child: FilledButton.tonal(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: const Color(primary),
        ),
        child: Text(
          title ?? "Save",
          style: const TextStyle(
            color: Color(white),
          ),
        ),
      ),
    ),
  );
}
