import 'package:bkd_presence_bloc/app/services/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'change_device_event.dart';
part 'change_device_state.dart';

class ChangeDeviceBloc extends Bloc<ChangeDeviceEvent, ChangeDeviceState> {
  ChangeDeviceBloc() : super(ChangeDeviceInitial()) {
    final ApiService apiService = ApiService();
    on<ChangeDevice>(
      (event, emit) async {
        try {
          await apiService.post(
            endpoint: 'report-change-device',
            requireToken: true,
            body: {
              'nip': event.nip,
              'office_id': event.officeId,
              'reason': event.reason,
            },
          );
          emit(
            const ChangeDeviceApiSuccess(
              message: "Berhasil Mengajukan Pergantian Device",
            ),
          );
        } catch (e) {
          emit(
            ChangeDeviceApiFailed(
              message: e.toString(),
            ),
          );
        }
      },
    );
  }
}
