import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child:  Text("Thông báo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
      ),
      body: Container(

      ),
    );
  }
}