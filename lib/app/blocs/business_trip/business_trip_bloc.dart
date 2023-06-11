import 'dart:io';

import 'package:bkd_presence_bloc/app/services/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'business_trip_event.dart';
part 'business_trip_state.dart';

class BusinessTripBloc extends Bloc<BusinessTripEvent, BusinessTripState> {
  BusinessTripBloc() : super(BusinessTripInitial()) {
    final ApiService apiService = ApiService();
    on<StartDatePicker>((event, emit) async {
      emit(StartDatePicked(
          DateFormat("yyyy-MM-dd").format(event.pickedDate).toString()));
    });

    on<StartDateNotPick>((event, emit) {
      emit(
        const StartDateNotPicked(
          message: "Tanggal Mulai Harus Dipilih",
        ),
      );
    });

    on<EndDateNotPick>((event, emit) {
      emit(
        const EndDateNotPicked(
          message: "Tanggal Selesai Harus Dipilih",
        ),
      );
    });
    on<EndDatePicker>((event, emit) async {
      emit(EndDatePicked(
          DateFormat("yyyy-MM-dd").format(event.pickedDate).toString()));
    });
    on<PickFile>((event, emit) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
        type: FileType.custom,
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
            message: "Surat Dinas Harus Dipilih",
          ),
        );
      }
    });
    on<SendBusinessTrip>((event, emit) async {
      try {
        final formData = FormData.fromMap({
          'nip': event.nip,
          'office_id': event.officeId,
          'presence_id': event.presenceId,
          'start_date': event.startDate,
          'end_date': event.endDate,
          'file': await MultipartFile.fromFile(event.file.path,
              filename: basename(event.file.path)),
        });
        await apiService.post(
          endpoint: 'business-trip',
          body: formData,
          requireToken: true,
        );
        emit(
          const SendBusinessTripApiSuccess(
            message: "Berhasil Mengirim Bukti Tugas Dinas",
          ),
        );
      } catch (e) {
        emit(
          SendBusinessTripApiFailed(
            message: e.toString(),
          ),
        );
      }
    });
  }
}
