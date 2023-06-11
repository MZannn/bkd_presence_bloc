import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.textTheme,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.child,
  });

  final TextTheme textTheme;
  final double width;
  final double height;
  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              100,
            ),
          ),
          elevation: 0,
        ),
        child: child,
      ),
    );
  }
}
