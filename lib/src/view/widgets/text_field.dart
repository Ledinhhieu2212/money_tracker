import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  const TextFieldCustom({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
