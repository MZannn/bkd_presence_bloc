import 'package:bkd_presence_bloc/app/widgets/presence_label_clock.dart';
import 'package:bkd_presence_bloc/app/widgets/presence_label_text.dart';
import 'package:bkd_presence_bloc/app/widgets/text_presecense_date.dart';
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class PresencesCard extends StatelessWidget {
  const PresencesCard({
    super.key,
    required this.textTheme,
    required this.presencesDate,
    this.entryStatus,
    this.attendanceClock,
  });

  final TextTheme textTheme;
  final String? attendanceClock;
  final String presencesDate;
  final String? entryStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PresenceLabelText(
                    label: "Masuk",
                    textTheme: textTheme,
                  ),
                  PresenceLabelClock(
                    attendanceClock: attendanceClock,
                    textTheme: textTheme,
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  entryStatus == "Terlambat"
                      ? Text(
                          entryStatus!,
                          style: textTheme.labelMedium!
                              .copyWith(color: ColorConstants.redColor),
                        )
                      : const SizedBox(
                          height: 14,
                        ),
                  TextPresenceDate(
                    presencesDate: presencesDate,
                    textTheme: textTheme,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PresenceLabelText(
                    label: "Keluar",
                    textTheme: textTheme,
                  ),
                  PresenceLabelClock(
                    attendanceClock: attendanceClock,
                    textTheme: textTheme,
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextPresenceDate(
                    presencesDate: presencesDate,
                    textTheme: textTheme,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
