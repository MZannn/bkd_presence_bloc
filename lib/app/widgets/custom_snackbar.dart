import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  const CustomSnackBar({
    Key? key,
    required Widget content,
    required Color backgroundColor,
    EdgeInsetsGeometry margin =
        const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 40),
    Duration duration = const Duration(seconds: 3),
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    ShapeBorder? shape,
    Animation<double>? animation,
    DismissDirection dismissDirection = DismissDirection.down,
    EdgeInsetsGeometry? padding,
  }) : super(
          key: key,
          animation: animation,
          padding: padding,
          content: content,
          duration: duration,
          backgroundColor: backgroundColor,
          margin: margin,
          behavior: behavior,
          shape: shape,
          dismissDirection: dismissDirection,
        );
}
