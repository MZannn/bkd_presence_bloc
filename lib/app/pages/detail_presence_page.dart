import 'package:bkd_presence_bloc/app/constants/date_formatting.dart';
import 'package:bkd_presence_bloc/app/models/user_model.dart';
import 'package:bkd_presence_bloc/app/themes/text_themes.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_appbar.dart';
import 'package:bkd_presence_bloc/app/widgets/detail_presence_text.dart';
import 'package:bkd_presence_bloc/app/widgets/presence_label_text.dart';
import 'package:bkd_presence_bloc/app/widgets/text_presecense_date.dart';
import 'package:flutter/material.dart';

class DetailPresencePage extends StatelessWidget {
  const DetailPresencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Presence;
    final textTheme = Themes.light.textTheme;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Detail Presensi",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: TextPresenceDate(
                  presencesDate: formatDate(
                    arguments.presenceDate!,
                  ),
                  textTheme: textTheme,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              PresenceLabelText(
                textTheme: textTheme,
                label: "Masuk",
              ),
              const SizedBox(
                height: 8,
              ),
              DetailPresenceText(
                title: "Jam",
                desc: arguments.attendanceClock,
                textTheme: textTheme,
              ),
              DetailPresenceText(
                title: "Status Kehadiran",
                desc: arguments.attendanceEntryStatus,
                textTheme: textTheme,
              ),
              DetailPresenceText(
                title: "Lokasi Kehadiran",
                desc: arguments.entryPosition,
                textTheme: textTheme,
              ),
              DetailPresenceText(
                title: "Jarak Kehadiran",
                desc: arguments.entryDistance,
                textTheme: textTheme,
                distance: true,
              ),
              const SizedBox(
                height: 8,
              ),
              PresenceLabelText(
                textTheme: textTheme,
                label: "Keluar",
              ),
              const SizedBox(
                height: 8,
              ),
              DetailPresenceText(
                title: "Jam",
                desc: arguments.attendanceClockOut,
                textTheme: textTheme,
              ),
              DetailPresenceText(
                title: "Status Kehadiran",
                desc: arguments.attendanceExitStatus,
                textTheme: textTheme,
              ),
              DetailPresenceText(
                title: "Lokasi Kehadiran",
                desc: arguments.exitPosition,
                textTheme: textTheme,
              ),
              DetailPresenceText(
                title: "Jarak Kehadiran",
                desc: arguments.exitDistance,
                textTheme: textTheme,
                distance: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
