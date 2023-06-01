part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class HiddenPasswordOnPressed extends LoginEvent {}

class LoginButtonOnPressed extends LoginEvent {
  final String nip;
  final String password;
  final String deviceId;

  const LoginButtonOnPressed(
      {required this.nip, required this.password, required this.deviceId});

  @override
  List<Object> get props => [nip, password, deviceId];
}

class GetDeviceId extends LoginEvent {}
