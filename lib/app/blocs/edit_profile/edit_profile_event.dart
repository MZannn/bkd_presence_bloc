part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class PickImage extends EditProfileEvent {}

class EditProfile extends EditProfileEvent {
  const EditProfile({
    required this.phoneNumber,
    this.file,
  });
  final String phoneNumber;
  final File? file;

  @override
  List<Object> get props => [phoneNumber, file!];
}
