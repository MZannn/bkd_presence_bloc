import 'package:bkd_presence_bloc/app/constants/date_formatting.dart';
import 'package:bkd_presence_bloc/app/constants/initial_name.dart';

import 'package:bkd_presence_bloc/app/models/user_model.dart';
import 'package:bkd_presence_bloc/app/pages/home_error_page.dart';
import 'package:bkd_presence_bloc/app/pages/home_loading_page.dart';
import 'package:bkd_presence_bloc/app/routes/routes.dart';
import 'package:bkd_presence_bloc/app/services/api_constant.dart';
import 'package:bkd_presence_bloc/app/themes/text_themes.dart';
import 'package:bkd_presence_bloc/app/widgets/presence_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/home/home_bloc.dart';
import '../constants/color_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Themes.light.textTheme;
    final homeBloc = context.read<HomeBloc>();

    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is HomeLoading) {
            return const HomeLoadingPage();
          }
          if (state is HomeLoaded) {
            final UserModel userModel = state.userModel!;
            final office = userModel.data.user.office;
            final user = userModel.data.user;
            final presences = userModel.data.presences;
            String presencesDate = formatDate(presences!.first.presenceDate!);
            return Stack(
              children: [
                Container(
                  color: ColorConstants.mainColor,
                ),
                SafeArea(
                  child: RefreshIndicator(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24,
                            left: 16,
                            bottom: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.office.name,
                                style: textTheme.titleMedium,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(3),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: user.profilePhotoPath == null
                                            ? CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Text(
                                                  initialName(user.name),
                                                  style: textTheme.bodyLarge!
                                                      .copyWith(
                                                    fontSize: 22,
                                                    color: ColorConstants
                                                        .mainColor,
                                                  ),
                                                ),
                                              )
                                            : Image.network(
                                                '${ApiConstants.apiUrl}/storage/${user.profilePhotoPath!}',
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.name,
                                          style: textTheme.bodyLarge,
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          user.position,
                                          style: textTheme.bodySmall,
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: GoogleMap(
                                  markers: {
                                    Marker(
                                      markerId: const MarkerId('1'),
                                      position: LatLng(
                                        office.latitude,
                                        office.longitude,
                                      ),
                                    ),
                                  },
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                      state.position.latitude,
                                      state.position.longitude,
                                    ),
                                    zoom: 14,
                                  ),
                                  onCameraMove: (position) {
                                    state.cameraPosition ?? position;
                                  },
                                  zoomControlsEnabled: false,
                                  circles: {
                                    Circle(
                                      circleId: const CircleId('1'),
                                      center: LatLng(
                                        office.latitude,
                                        office.longitude,
                                      ),
                                      radius: office.radius *
                                          1000, // convert ke meter
                                      strokeWidth: 1,
                                      strokeColor: ColorConstants.mainColor,
                                      fillColor: ColorConstants.mainColor
                                          .withOpacity(0.1),
                                    ),
                                  },
                                  gestureRecognizers: <
                                      Factory<OneSequenceGestureRecognizer>>{}
                                    ..add(Factory<PanGestureRecognizer>(
                                        () => PanGestureRecognizer()))
                                    ..add(Factory<ScaleGestureRecognizer>(
                                        () => ScaleGestureRecognizer()))
                                    ..add(Factory<TapGestureRecognizer>(
                                        () => TapGestureRecognizer()))
                                    ..add(
                                      Factory<VerticalDragGestureRecognizer>(
                                        () => VerticalDragGestureRecognizer(),
                                      ),
                                    )
                                    ..add(
                                      Factory<HorizontalDragGestureRecognizer>(
                                        () => HorizontalDragGestureRecognizer(),
                                      ),
                                    ),
                                  myLocationEnabled: true,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.detailPresence,
                                      arguments:
                                          userModel.data.presences?.first);
                                },
                                child: PresencesCard(
                                  attendanceClock:
                                      presences.first.attendanceClock,
                                  textTheme: textTheme,
                                  entryStatus:
                                      presences.first.attendanceEntryStatus,
                                  presencesDate: presencesDate,
                                  attendanceClockOut:
                                      presences.first.attendanceClockOut,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Presensi 5 hari terakhir",
                                      style: textTheme.labelMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.presenceHistory,
                                      );
                                    },
                                    child: const Text("Lebih banyak"),
                                  ),
                                ],
                              ),
                              userModel.data.presences?.isEmpty == true
                                  ? const SizedBox()
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          userModel.data.presences?.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, Routes.detailPresence,
                                                arguments: userModel
                                                    .data.presences?[index]);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 16),
                                            child: PresencesCard(
                                              textTheme: textTheme,
                                              attendanceClock: presences[index]
                                                  .attendanceClock,
                                              attendanceClockOut:
                                                  presences[index]
                                                      .attendanceClockOut,
                                              entryStatus: presences[index]
                                                  .attendanceEntryStatus,
                                              presencesDate: formatDate(
                                                  presences[index]
                                                      .presenceDate!),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onRefresh: () {
                      return Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          homeBloc.add(
                            GetAllData(
                              position: state.position,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
          if (state is HomeError) {
            return HomeErrorPage(
              onRefresh: () {
                return Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    homeBloc.add(
                      GetAllData(
                        position: state.position,
                      ),
                    );
                  },
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
