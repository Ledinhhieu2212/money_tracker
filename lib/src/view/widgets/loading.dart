import 'package:flutter/material.dart';
import 'package:money_tracker/src/model/styles/app_style.dart';
import 'package:money_tracker/src/model/styles/colors.dart';

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
      color:  Color(white),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}