import 'dart:async';

import 'package:bkd_presence_bloc/app/constants/time_formatting.dart';
import 'package:bkd_presence_bloc/app/models/user_model.dart';
import 'package:bkd_presence_bloc/app/repositories/geolocation_repository.dart';
import 'package:bkd_presence_bloc/app/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GeolocationRepository _geolocationRepository;
  StreamSubscription? _geolocationSubscription;
  late UserModel userModel;
  late DateTime now;

  HomeBloc({required GeolocationRepository geolocationRepository})
      : _geolocationRepository = geolocationRepository,
        super(HomeInitial()) {
    final ApiService apiService = ApiService();
    on<GetAllData>((event, emit) async {
      emit(HomeLoading());

      try {
        final Position position = event.position;
        Map<String, dynamic> response = await apiService.get(
          endpoint: 'user',
          requireToken: true,
        );
        userModel = UserModel.fromJson(response);
        var timeResponse = await Dio().get(
          'https://www.timeapi.io/api/Time/current/zone?timeZone=Asia/Jakarta',
        );
        String dateTime = timeResponse.data['dateTime'];
        now = timeFormatting(dateTime);
        Timer.periodic(const Duration(seconds: 1), (timer) {
          now = now.add(const Duration(seconds: 1));
        });
        final attendanceClock = DateFormat('HH:mm:ss').format(now);
        _geolocationSubscription =
            Geolocator.getPositionStream().listen((event) async {
          double distance = Geolocator.distanceBetween(
            event.latitude,
            event.longitude,
            userModel.data.user.office.latitude,
            userModel.data.user.office.longitude,
          );
          final userPresence = userModel.data.presences?.first;
          final userOffice = userModel.data.user.office;
          DateFormat format = DateFormat('yyyy-MM-dd');
          String today = format.format(now);
          DateTime startWork = DateTime.parse('$today ${userOffice.startWork}');
          DateTime startBreakWork =
              DateTime.parse('$today ${userOffice.startBreak}');
          DateTime maximalLate =
              DateTime.parse('$today ${userOffice.lateTolerance}');
          final isLate = now.isAfter(startBreakWork);
          final entryStatus = isLate ? 'TERLAMBAT' : 'HADIR';
          if (distance <= userModel.data.user.office.radius &&
              userPresence?.attendanceEntryStatus == null &&
              event.isMocked == false &&
              now.isAfter(startWork) &&
              now.isBefore(maximalLate)) {
            Map<String, dynamic> response = await apiService.put(
              endpoint: 'presence-in/${userPresence?.id}',
              requireToken: true,
              body: {
                'attendance_clock': attendanceClock,
                'entry_position': "${event.latitude}, ${event.longitude}",
                'entry_distance': distance * 1000, // convert to meter
                'attendance_entry_status': entryStatus,
              },
            );

            userModel = UserModel.fromJson(response);
            emit(
              HomeLoaded(
                userModel: userModel,
                position: position,
                cameraPosition: CameraPosition(
                  target: LatLng(event.latitude, event.longitude),
                  zoom: 16,
                ),
              ),
            );
          }
        });

        emit(HomeLoaded(userModel: userModel, position: position));
      } catch (e) {
        emit(HomeError(message: e.toString(), position: event.position));
      }
    });

    on<LoadGeolocation>((event, emit) {
      _geolocationSubscription?.cancel();
      _geolocationSubscription = _geolocationRepository
          .getCurrentLocation()
          .asStream()
          .listen((Position position) => add(GetAllData(position: position)));
    });
  }

  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadGeolocation) {
      yield* _mapLoadGeolocationToState();
    } else if (event is GetAllData) {
      yield* _mapUpdateGeolocationToState(event);
    }
  }

  Stream<HomeState> _mapLoadGeolocationToState() async* {
    _geolocationSubscription?.cancel();
    final Position position = await _geolocationRepository.getCurrentLocation();
    add(GetAllData(position: position));
  }

  Stream<HomeState> _mapUpdateGeolocationToState(GetAllData event) async* {
    yield HomeLoaded(position: event.position, userModel: userModel);
  }

  @override
  Future<void> close() {
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
