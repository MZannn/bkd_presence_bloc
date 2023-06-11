part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class ImagePicked extends EditProfileState {
  final String fileName;
  final File file;

  const ImagePicked({
    required this.fileName,
    required this.file,
  });

  @override
  List<Object> get props => [fileName, file];
}

class ImageNotPicked extends EditProfileState {
  final String message;

  const ImageNotPicked({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class EditProfileSuccess extends EditProfileState {
  final String message;

  const EditProfileSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class EditProfileFailed extends EditProfileState {
  final String message;

  const EditProfileFailed({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
