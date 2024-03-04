import 'package:flutter/material.dart';

import '../constant/color_constant.dart';

class CustomSnackbar extends SnackBar {
  final String message;
  @override
  final Color backgroundColor;
  final Color textColor;

  CustomSnackbar({
    required this.message,
    Key? key,
    this.backgroundColor = Colors.green, // Default background color
    this.textColor = colorWhite, // Default text color
    Duration duration = const Duration(seconds: 2),
  }) : super(
    key: key,
    content: Center(
      child: Text(
        message,
        style: TextStyle(color: textColor),
      ),
    ),
    duration: duration,
    backgroundColor: backgroundColor,
  );
}
