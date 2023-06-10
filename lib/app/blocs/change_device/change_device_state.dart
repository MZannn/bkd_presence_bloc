part of 'change_device_bloc.dart';

abstract class ChangeDeviceState extends Equatable {
  const ChangeDeviceState();

  @override
  List<Object> get props => [];
}

class ChangeDeviceInitial extends ChangeDeviceState {}

class ChangeDeviceApiSuccess extends ChangeDeviceState {
  final String message;

  const ChangeDeviceApiSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ChangeDeviceApiFailed extends ChangeDeviceState {
  final String message;

  const ChangeDeviceApiFailed({required this.message});

  @override
  List<Object> get props => [message];
}
