import 'package:flutter/material.dart';

class PresenceLabelText extends StatelessWidget {
  const PresenceLabelText({
    super.key,
    required this.textTheme,
    required this.label,
  });

  final TextTheme textTheme;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: textTheme.labelMedium,
    );
  }
}
