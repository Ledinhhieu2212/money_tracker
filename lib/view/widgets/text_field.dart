import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:money_tracker/constants/app_colors.dart';
import 'package:money_tracker/constants/config.dart';

Widget textFormFieldAuth(
    {required String label,
    required TextEditingController controller,
    bool obscureTextBool = false}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureTextBool,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        // color: Colors.grey,
      ),
      focusedBorder: const OutlineInputBorder(
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
    bool isEnabled = true}) {
  return Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: TextField(
          enabled: isEnabled,
          keyboardType: TextInputType.number,
          inputFormatters: [MoneyInputFormatter()],
          controller: controller,
          textAlign: TextAlign.end,
          // obscureText: false,
          style: TextStyle(color: color, fontSize: 30),
          decoration: InputDecoration(
            hintText: "0",
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
