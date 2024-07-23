import 'package:flutter/material.dart';

class ButtonToolSettingNoRightIcon extends StatelessWidget {
  VoidCallback? onPressed;
  String? title;
  Color? backgroundIcon;
  Icon? icon;
  ButtonToolSettingNoRightIcon(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.title,
      required this.backgroundIcon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: null,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: backgroundIcon, 
                borderRadius: BorderRadius.circular(50)),
            child: icon,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13.0),
            child: Text("$title"),
          ),
        ],
      ),
    );
  }
}
