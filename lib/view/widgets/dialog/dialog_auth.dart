import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogAuth extends StatelessWidget {
  final String message;
  final Icon icon;
  final Color color;
  const DialogAuth({
    super.key,
    required this.message,
    this.icon = const Icon(Icons.error),
    this.color = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                   Align(
                    alignment: Alignment.centerLeft,
                    child: icon,
                  ),
                  const SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(message),
                  )
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Get.back(); // Đóng dialog khi nhấn nút "X"
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
