import 'package:bkd_presence_bloc/app/blocs/home/home_bloc.dart';
import 'package:bkd_presence_bloc/app/blocs/presence_history/presence_history_bloc.dart';
import 'package:bkd_presence_bloc/app/constants/date_formatting.dart';
import 'package:bkd_presence_bloc/app/routes/routes.dart';
import 'package:bkd_presence_bloc/app/themes/text_themes.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_appbar.dart';
import 'package:bkd_presence_bloc/app/widgets/presence_card.dart';
import 'package:flutter/material.dart';

class PresenceHistoryPage extends StatelessWidget {
  const PresenceHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final presenceHistoryBloc = context.read<PresenceHistoryBloc>();
    final textTheme = Themes.light.textTheme;
    return Scaffold(
      appBar: const CustomAppBar(title: "Riwayat Presensi"),
      body: BlocBuilder<PresenceHistoryBloc, PresenceHistoryState>(
        bloc: presenceHistoryBloc,
        builder: (context, state) {
          if (state is PresenceHistoryLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PresenceHistoryLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: state.presences.length,
              itemBuilder: (context, index) {
                final presence = state.presences[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.detailPresence,
                      arguments: presence,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: PresencesCard(
                      textTheme: textTheme,
                      presencesDate: formatDate(presence.presenceDate!),
                      attendanceClock: presence.attendanceClock,
                      attendanceClockOut: presence.attendanceClockOut,
                      entryStatus: presence.attendanceEntryStatus,
                    ),
                  ),
                );
              },
            );
          } else if (state is PresenceHistoryError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
