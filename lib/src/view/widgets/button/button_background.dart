import 'package:flutter/material.dart';
import 'package:money_tracker/core/app_style.dart';
import 'package:money_tracker/model/Styles/colors.dart';

Widget customButtonBackground({
  VoidCallback? onPressed,
 required String? title,
 required BuildContext context,
}) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: 48,
        width: getScreenWidth(context),
        child: FilledButton.tonal(
          onPressed: onPressed,
          style: FilledButton.styleFrom(backgroundColor: primary),
          child: Text(
            title == null ? "Save" : title,
            style: TextStyle(color: white),
          ),
        ),
      ),
    );
  }