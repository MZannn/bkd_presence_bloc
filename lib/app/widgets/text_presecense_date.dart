import 'package:flutter/material.dart';

class TextPresenceDate extends StatelessWidget {
  const TextPresenceDate({
    super.key,
    required this.presencesDate,
    required this.textTheme,
  });

  final String presencesDate;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Text(
      presencesDate,
      style: textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
