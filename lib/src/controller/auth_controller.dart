import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/model/user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AuthencationController extends ControllerMVC {
  List<User> user = <User>[];
  final Dio _dio = Dio();
}
