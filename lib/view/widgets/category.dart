import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            "Chọn danh mục",
            style: TextStyle(fontSize: 20),
          )),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
