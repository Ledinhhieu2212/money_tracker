import 'package:flutter/material.dart';
import 'package:money_tracker/constants/app_colors.dart';

// ignore: must_be_immutable
class ButtonToolSettingRightIcon extends StatefulWidget {
  VoidCallback? onPressed;
  String? title;
  Color? backgroundIcon;
  Icon? icon;
  ButtonToolSettingRightIcon(
      {super.key,
      required this.icon,
      required this.onPressed,
      required this.title,
      required this.backgroundIcon});

  @override
  State<ButtonToolSettingRightIcon> createState() =>
      _ButtonToolSettingRightIconState();
}

class _ButtonToolSettingRightIconState
    extends State<ButtonToolSettingRightIcon> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(white),
        shadowColor: null,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      onPressed: widget.onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: widget.backgroundIcon,
                    borderRadius: BorderRadius.circular(50)),
                child: widget.icon,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("${widget.title}")),
            ],
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
