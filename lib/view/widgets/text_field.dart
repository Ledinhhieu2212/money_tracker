import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/app_colors.dart';

Widget textFormFieldAuth(
    {required String label,
    required TextEditingController controller,
    bool obscureTextBool = false}) {
  return TextField(
    controller: controller,
    obscureText: obscureTextBool,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(blue), // Màu của đường viền khi được nhấn vào
          width: 2.0,
        ),
      ),
    ),
  );
}

Widget textFormFieldCreateMoney(
    {required TextEditingController controller,
    Color color = const Color(black),
    String error = ''}) {
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.end,
          obscureText: false,
          style: TextStyle(color: color, fontSize: 30),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            hintText: "0",
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.4),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.8),
            ),
            hintStyle: TextStyle(
                color: color, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Positioned(
        right: 0,
        top: 15,
        child: Text(
          "icon_currency".tr,
          style: TextStyle(
              fontSize: 25,
              decoration: TextDecoration.underline,
              color: color,
              fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}
