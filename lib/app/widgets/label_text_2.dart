import 'package:flutter/material.dart';

class LabelText2 extends StatelessWidget {
  const LabelText2({
    super.key,
    required this.label,
    required this.textTheme,
  });
  final String label;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: textTheme.bodySmall!.copyWith(
        color: Colors.black,
      ),
    );
  }
}
