import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_tracker/constants/images.dart';

class FlashMessageScreen extends StatelessWidget {
  final String textMessage;
  final String titleMessage;
  final Color colors;
  final String iconMessage;
  final String imageMessage;
  const FlashMessageScreen({
    super.key,
    required this.titleMessage,
    required this.textMessage,
    required this.colors,
    required this.iconMessage,
    required this.imageMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 100,
          decoration: BoxDecoration(
            color: colors,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: Row(
              children: [
                const SizedBox(width: 48),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleMessage,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        textMessage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          decorationThickness: 2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(20)),
            child: SvgPicture.asset(
              iconMessage,
              height: 60,
            ),
          ),
        ),
        Positioned(
          top: -10,
          left: 10,
          child: SvgPicture.asset(
            imageMessage,
            height: 40,
          ),
        ),
      ],
    );
  }
}

dynamic buildErrorMessage(
  String titleMessage,
  String textMessage,
  BuildContext context,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: FlashMessageScreen(
          iconMessage: imageBase().iconFail,
          imageMessage: imageBase().fail,
          colors: Colors.red,
          titleMessage: titleMessage,
          textMessage: textMessage),
    ),
  );
}

dynamic buildSuccessMessage(
  String titleMessage,
  String textMessage,
  BuildContext context,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: FlashMessageScreen(
          iconMessage: imageBase().iconSuccess,
          imageMessage: imageBase().success,
          colors: Colors.green,
          titleMessage: titleMessage,
          textMessage: textMessage),
    ),
  );
}

dynamic buildWarningMessage(
  String titleMessage,
  String textMessage,
  BuildContext context,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: FlashMessageScreen(
          iconMessage: imageBase().iconWarning,
          imageMessage: imageBase().warning,
          colors: Colors.orange,
          titleMessage: titleMessage,
          textMessage: textMessage),
    ),
  );
}
