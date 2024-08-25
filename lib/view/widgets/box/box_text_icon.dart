import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_style.dart';

class BoxTextIcon extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onPress;
  const BoxTextIcon(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: getScreenWidth(context) * 0.3,
      width: getScreenWidth(context) * 0.45,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: MaterialButton(
        onPressed: onPress,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: icon,
              ),
            ),
            Center(child: Text(title)),
          ],
        ),
      ),
    );
  }
}
