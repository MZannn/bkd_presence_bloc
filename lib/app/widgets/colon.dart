import 'package:flutter/material.dart';

class ColonWidget extends StatelessWidget {
  const ColonWidget({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 12,
      child: Text(
        ":",
        style: textTheme.bodySmall!.copyWith(color: Colors.black),
      ),
    );
  }
}
