import 'dart:io';

import 'package:bkd_presence_bloc/app/models/user_model.dart';
import 'package:bkd_presence_bloc/app/services/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    final ApiService apiService = ApiService();
    on<PickImage>((event, emit) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        File file = File(result.files.single.path!);
        String fileName = basename(file.path);
        final fileSize = await file.length();
        if (fileSize > 2 * 1024 * 1024) {
          await file.delete();
          emit(
            const ImageNotPicked(
              message: "Ukuran Gambar Tidak Boleh Lebih Dari 2 MB",
            ),
          );
          return;
        } else {
          emit(
            ImagePicked(
              fileName: fileName,
              file: file,
            ),
          );
        }
      }
    });

    on<EditProfile>((event, emit) async {
      try {
        var formData = FormData.fromMap({
          'phone_number': event.phoneNumber,
        });
        if (event.file != null) {
          formData.files.add(
            MapEntry(
              'profile_photo_path',
              await MultipartFile.fromFile(
                event.file!.path,
                filename: basename(event.file!.path),
              ),
            ),
          );
        }
        Map<String, dynamic> response = await apiService.post(
          endpoint: 'user',
          body: formData,
          requireToken: true,
        );
        UserModel.fromJson(response);
        emit(
          const EditProfileSuccess(
            message: "Berhasil Mengubah Profile",
          ),
        );
      } catch (e) {
        emit(
          EditProfileFailed(
            message: e.toString(),
          ),
        );
      }
    });
  }
}
