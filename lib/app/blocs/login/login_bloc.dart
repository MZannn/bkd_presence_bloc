import 'dart:io';

import 'package:bkd_presence_bloc/app/services/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService = ApiService();
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonOnPressed>((event, emit) async {
      try {
        emit(LoginLoading());
        final response = await apiService.post(
          endpoint: 'login',
          body: {
            'nip': event.nip,
            'password': event.password,
            'device_id': event.deviceId,
          },
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response['data']['access_token']);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginError(message: e.toString()));
      }
    });

    on<GetDeviceId>((event, emit) async {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidDeviceInfo =
            await deviceInfoPlugin.androidInfo;
        emit(DeviceId(deviceId: androidDeviceInfo.id));
      }
    });

    on<HiddenPasswordOnPressed>((event, emit) {
      if (state is HiddenPassword) {
        final currentState = state as HiddenPassword;
        emit(HiddenPassword(isHiddenPassword: !currentState.isHiddenPassword));
      } else {
        emit(const HiddenPassword(isHiddenPassword: true));
      }
    });
  }
}
