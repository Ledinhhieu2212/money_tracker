import 'package:flutter/material.dart';
import 'package:money_tracker/src/model/styles/colors.dart';

class CatgoryBetweenConfigApp extends StatelessWidget {
  VoidCallback? onTap;
  String? title;
  String? titleConfig;
  CatgoryBetweenConfigApp({super.key, required this.onTap, required this.title, required this.titleConfig});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: const Color(white),
            border: Border.all(width: 1, color: const Color(grey))),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text("$title"),
            RichText(
              text: TextSpan(
                text: '$titleConfig ',
                style: const TextStyle(color: Colors.blue, fontSize: 15),
                children: const [
                  WidgetSpan(
                      child: Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
