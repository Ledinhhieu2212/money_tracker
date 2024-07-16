import 'package:flutter/material.dart';
import 'package:money_tracker/src/model/styles/app_style.dart';
import 'package:money_tracker/src/model/styles/colors.dart';

Widget customButtonBackground({
  VoidCallback? onPressed,
 required String? title,
 required BuildContext context,
}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 48,
        width: getScreenWidth(context),
        child: FilledButton.tonal(
          onPressed: onPressed,
          style: FilledButton.styleFrom(backgroundColor:  Color(primary)),
          child: Text(
            title ?? "Save",
            style: TextStyle(color:  Color(white)),
          ),
        ),
      ),
    );
  }