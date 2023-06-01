import 'package:flutter/material.dart';

class PresenceLabelClock extends StatelessWidget {
  const PresenceLabelClock({
    super.key,
    required this.textTheme,
    required this.attendanceClock,
  });

  final String? attendanceClock;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Text(
      attendanceClock ?? "-",
      style: textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
