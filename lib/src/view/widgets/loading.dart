import 'package:flutter/material.dart';
import 'package:money_tracker/core/app_style.dart';
import 'package:money_tracker/model/Styles/colors.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight(context),
      color: white,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}