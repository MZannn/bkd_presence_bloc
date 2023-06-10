part of 'change_device_bloc.dart';

abstract class ChangeDeviceEvent extends Equatable {
  const ChangeDeviceEvent();

  @override
  List<Object> get props => [];
}

class ChangeDevice extends ChangeDeviceEvent {
  final String nip;
  final String officeId;
  final String reason;

  const ChangeDevice({
    required this.nip,
    required this.officeId,
    required this.reason,
  });

  @override
  List<Object> get props => [nip, officeId, reason];
}
