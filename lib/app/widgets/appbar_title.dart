import 'package:bkd_presence_bloc/app/themes/text_themes.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Themes.light.textTheme.titleMedium,
    );
  }
}
