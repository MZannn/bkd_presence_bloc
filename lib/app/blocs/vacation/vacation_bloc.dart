import 'dart:io';

import 'package:bkd_presence_bloc/app/blocs/business_trip/business_trip_bloc.dart';
import 'package:bkd_presence_bloc/app/services/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'vacation_event.dart';
part 'vacation_state.dart';

class VacationBloc extends Bloc<VacationEvent, VacationState> {
  VacationBloc() : super(VacationInitial()) {
    final ApiService apiService = ApiService();
    on<StartDatePicker>(
      (event, emit) {
        emit(
          StartDatePicked(
            currentTime:
                DateFormat('yyyy-MM-dd').format(event.currentTime).toString(),
          ),
        );
      },
    );
    on<StartDateNotPick>((event, emit) {
      emit(
        const StartDateNotPicked(
          message: "Tanggal Mulai Harus Dipilih",
        ),
      );
    });
    on<EndDatePicker>(
      (event, emit) {
        emit(
          EndDatePicked(
            currentTime:
                DateFormat('yyyy-MM-dd').format(event.currentTime).toString(),
          ),
        );
      },
    );
    on<EndDateNotPick>((event, emit) {
      emit(
        const EndDateNotPicked(
          message: "Tanggal Berakhir Harus Dipilih",
        ),
      );
    });
    on<PickFile>((event, emit) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
      );
      if (result != null) {
        File file = File(result.files.single.path!);
        String fileName = basename(file.path);
        emit(
          FilePicked(
            fileName: fileName,
            file: file,
          ),
        );
      } else {
        emit(
          const FileNotPicked(
            message: "Surat Cuti Harus Dipilih",
          ),
        );
      }
    });

    on<SendVacation>((event, emit) async {
      try {
        var form = FormData.fromMap({
          'nip': event.nip,
          'office_id': event.officeId,
          'presence_id': event.presenceId,
          'start_date': event.startDate,
          'end_date': event.endDate,
          'leave_type': event.leaveType,
          'reason': event.reason,
          'file': await MultipartFile.fromFile(
            event.file.path,
            filename: basename(
              event.file.path,
            ),
          ),
        });
        await apiService.post(
          endpoint: 'vacation',
          body: form,
          requireToken: true,
        );
        emit(
          const SendVacationApiSuccess(message: "Berhasil Mengajukan Cuti"),
        );
      } catch (e) {
        emit(
          SendVacationApiFailed(message: e.toString()),
        );
      }
    });
  }
}
