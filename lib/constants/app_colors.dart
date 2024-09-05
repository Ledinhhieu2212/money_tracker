import 'package:flutter/material.dart'; 
import 'dart:ui';
const blue = 0xff3C35E4;

const primary = 0xff00AFF0;

const lightAmber = 0xffFFF9E7;

const amber = 0xffEDB200;

const green = 0xff009120;

const grey = 0xffE9E9E9;

const lightGrey = 0xffF5F5F5;

const white = 0xffFFFFFF;

const black = 0xff06051B;

const linearGradient = LinearGradient(
  colors: [Color(blue), Color(primary)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);


extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
      alpha,
      (red * value).round(),
      (green * value).round(),
      (blue * value).round(),
    );
  }

  Color lighten([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = percent / 100;
    return Color.fromARGB(
      alpha,
      (red + ((255 - red) * value)).round(),
      (green + ((255 - green) * value)).round(),
      (blue + ((255 - blue) * value)).round(),
    );
  }

  Color avg(Color other) {
    final red = (this.red + other.red) ~/ 2;
    final green = (this.green + other.green) ~/ 2;
    final blue = (this.blue + other.blue) ~/ 2;
    final alpha = (this.alpha + other.alpha) ~/ 2;
    return Color.fromARGB(alpha, red, green, blue);
  }
}