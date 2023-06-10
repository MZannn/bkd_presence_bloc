import 'package:bkd_presence_bloc/app/constants/color_constants.dart';
import 'package:flutter/material.dart';

class DetailPresenceText extends StatelessWidget {
  const DetailPresenceText({
    super.key,
    required this.desc,
    required this.textTheme,
    required this.title,
    this.distance = false,
  });

  final String? desc;
  final TextTheme textTheme;
  final String title;

  final bool distance;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title :",
          style: textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        Flexible(
          child: Text(
            " ${desc ?? "-"} ${distance ? "m" : ""}",
            style: desc == "TERLAMBAT"
                ? textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: ColorConstants.redColor,
                  )
                : textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
          ),
        ),
      ],
    );
  }
}
