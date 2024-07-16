import 'package:flutter/material.dart';
import 'package:money_tracker/src/model/styles/colors.dart';
// import 'package:money_tracker/models/Styles/app_style.dart';

Widget customButtomIcon({VoidCallback? call, IconData? icon, Color? colorIcon}) {
  return IconButton(
    icon: Icon(
      icon ?? Icons.abc,
      color: (colorIcon ??  Color(white)),
    ),
    onPressed: call,
  );
}
