import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final bool obscureTextBool ;
   const TextFieldCustom({super.key, required this.label, required this.controller,this.obscureTextBool = false});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureTextBool,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
