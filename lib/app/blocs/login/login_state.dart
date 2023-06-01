part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class HiddenPassword extends LoginState {
  final bool isHiddenPassword;
  const HiddenPassword({required this.isHiddenPassword});

  @override
  List<Object> get props => [isHiddenPassword];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String message;
  const LoginError({required this.message});
  @override
  List<Object> get props => [message];
}

class DeviceId extends LoginState {
  final String deviceId;
  const DeviceId({required this.deviceId});
  @override
  List<Object> get props => [deviceId];
}

class DeviceIdLoaded extends LoginState {}
