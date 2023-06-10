import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  const LabelButton({
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
      style: textTheme.labelMedium!.copyWith(color: Colors.white),
    );
  }
}
