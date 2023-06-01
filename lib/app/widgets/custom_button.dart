import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.textTheme,
    required this.child,
    required this.width,
    required this.height,
    required this.onPressed,
  });

  final TextTheme textTheme;
  final Widget child;
  final double width;
  final double height;
  final void Function()? onPressed;

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
