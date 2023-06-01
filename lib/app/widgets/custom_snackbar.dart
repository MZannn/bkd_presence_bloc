import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  const CustomSnackBar({
    Key? key,
    required Widget content,
    required Color backgroundColor,
    EdgeInsetsGeometry margin = const EdgeInsets.all(16),
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    ShapeBorder? shape,
  }) : super(
          key: key,
          content: content,
          duration: duration,
          backgroundColor: backgroundColor,
          margin: margin,
          behavior: behavior,
          shape: shape,
        );
}
