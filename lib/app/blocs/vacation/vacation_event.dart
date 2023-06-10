part of 'vacation_bloc.dart';

abstract class VacationEvent extends Equatable {
  const VacationEvent();

  @override
  List<Object> get props => [];
}

class StartDatePicker extends VacationEvent {
  final DateTime currentTime;

  const StartDatePicker({required this.currentTime});

  @override
  List<Object> get props => [currentTime];
}

class StartDateNotPick extends VacationEvent {}

class EndDatePicker extends VacationEvent {
  final DateTime currentTime;

  const EndDatePicker({required this.currentTime});

  @override
  List<Object> get props => [currentTime];
}

class EndDateNotPick extends VacationEvent {}

class PickFile extends VacationEvent {}

class SendVacation extends VacationEvent {
  final String nip;
  final String officeId;
  final String presenceId;
  final String startDate;
  final String endDate;
  final String leaveType;
  final String reason;
  final File file;

  const SendVacation(
      {required this.nip,
      required this.officeId,
      required this.presenceId,
      required this.reason,
      required this.startDate,
      required this.leaveType,
      required this.endDate,
      required this.file});

  @override
  List<Object> get props => [startDate, endDate, leaveType, reason, file];
}
