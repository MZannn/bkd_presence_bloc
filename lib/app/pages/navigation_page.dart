import 'dart:async';

import 'package:bkd_presence_bloc/app/blocs/home/home_bloc.dart';
import 'package:bkd_presence_bloc/app/models/user_model.dart';
import 'package:bkd_presence_bloc/app/pages/home_page.dart';
import 'package:bkd_presence_bloc/app/pages/profile_page.dart';
import 'package:bkd_presence_bloc/app/themes/text_themes.dart';
import 'package:bkd_presence_bloc/app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../blocs/navigation/navigation_bloc.dart';
import '../constants/color_constants.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationBloc = context.read<NavigationBloc>();
    final homeBloc = context.read<HomeBloc>();
    final textTheme = Themes.light.textTheme;

    return Scaffold(
      body: BlocBuilder(
        bloc: navigationBloc,
        builder: (context, state) {
          if (state is NavigationLoaded) {
            switch (state.selectedIndex) {
              case 0:
                return const HomePage();
              case 1:
                return BlocBuilder<HomeBloc, HomeState>(
                  bloc: homeBloc,
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      final UserModel userModel = state.userModel!;
                      return ProfilePage(
                          userModel: userModel, textTheme: textTheme);
                    }
                    return const SizedBox();
                  },
                );
              default:
                return const SizedBox();
            }
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: BlocBuilder(
        bloc: navigationBloc,
        builder: (context, state) {
          if (state is NavigationLoaded) {
            return BottomAppBar(
              color: Colors.white,
              padding: EdgeInsets.zero,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        navigationBloc.add(
                          const NavigationChanged(selectedIndex: 0),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: SvgPicture.asset(
                              'assets/icons/home${state.selectedIndex == 0 ? '_active.svg' : '.svg'}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Home",
                            style: textTheme.bodySmall!.copyWith(
                              color: state.selectedIndex == 0
                                  ? ColorConstants.mainColor
                                  : ColorConstants.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigationBloc.add(
                          const NavigationChanged(selectedIndex: 1),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: SvgPicture.asset(
                              'assets/icons/profile${state.selectedIndex == 1 ? '_active.svg' : '.svg'}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Akun",
                            style: textTheme.bodySmall!.copyWith(
                              color: state.selectedIndex == 1
                                  ? ColorConstants.mainColor
                                  : ColorConstants.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: BlocConsumer(
        bloc: homeBloc,
        listener: (context, state) {
          if (state is HomeLoaded) {
            if (state.position.isMocked == true) {
              SnackBar snackBar = CustomSnackBar(
                content: const Text("Anda Terdeteksi Menggunakan FakeGPS"),
                backgroundColor: ColorConstants.redColor,
              );
              bool isMockedFirst = true;
              if (isMockedFirst) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                isMockedFirst = false;
              }
              Timer.periodic(const Duration(seconds: 5), (timer) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            }
          }
        },
        builder: (context, state) {
          if (state is HomeLoaded) {
            final UserModel userModel = state.userModel!;
            final presence = userModel.data.presences?.first;
            String today = DateFormat('yyyy-MM-dd').format(state.dateTime!);
            DateTime endWork =
                DateTime.parse("$today ${userModel.data.user.office.endWork}");
            return FloatingActionButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onPressed: () {
                if (state.position.isMocked == true) {
                  SnackBar snackBar = CustomSnackBar(
                    content: const Text("Anda Terdeteksi Menggunakan FakeGPS"),
                    backgroundColor: ColorConstants.redColor,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (presence?.attendanceEntryStatus == null) {
                  SnackBar snackBar = CustomSnackBar(
                    content: const Text("Anda Belum Melakukan Presensi Masuk"),
                    backgroundColor: ColorConstants.redColor,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (presence?.attendanceExitStatus != null) {
                  SnackBar snackBar = CustomSnackBar(
                    content: const Text("Anda Sudah Melakukan Presensi Keluar"),
                    backgroundColor: ColorConstants.redColor,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (state.dateTime!.isBefore(endWork)) {
                  SnackBar snackBar = CustomSnackBar(
                    content: const Text(
                        "Anda Belum Bisa Melakukan Presensi Keluar, Silahkan Tunggu Hingga Waktu Pulang"),
                    backgroundColor: ColorConstants.redColor,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else if (presence?.attendanceEntryStatus != null &&
                    presence?.attendanceExitStatus == null &&
                    state.dateTime!.isAfter(endWork) &&
                    state.position.isMocked == false) {
                  homeBloc.add(PresenceOut());
                }
              },
              backgroundColor: presence?.attendanceEntryStatus != null &&
                      presence?.attendanceExitStatus == null &&
                      state.dateTime!.isAfter(endWork)
                  ? ColorConstants.mainColor
                  : ColorConstants.greyColor,
              child: SvgPicture.asset(
                "assets/icons/${presence?.attendanceEntryStatus != null && presence?.attendanceExitStatus == null && state.dateTime!.isAfter(endWork) ? 'presence.svg' : 'presence_disabled.svg'}",
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
