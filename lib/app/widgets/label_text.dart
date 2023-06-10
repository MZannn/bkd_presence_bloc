import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  const LabelText({
    super.key,
    required this.width,
    required this.label,
    required this.textTheme,
  });
  final String label;
  final TextTheme textTheme;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        label,
        style: textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 10,
          color: Colors.black,
        ),
      ),
    );
  }
}
