part of 'business_trip_bloc.dart';

abstract class BusinessTripEvent extends Equatable {
  const BusinessTripEvent();

  @override
  List<Object> get props => [];
}

class StartDatePicker extends BusinessTripEvent {
  final DateTime pickedDate;

  const StartDatePicker({required this.pickedDate});

  @override
  List<Object> get props => [pickedDate];
}

class StartDateNotPick extends BusinessTripEvent {}

class EndDatePicker extends BusinessTripEvent {
  final DateTime pickedDate;

  const EndDatePicker({required this.pickedDate});

  @override
  List<Object> get props => [pickedDate];
}

class EndDateNotPick extends BusinessTripEvent {}

class PickFile extends BusinessTripEvent {}

class SendBusinessTrip extends BusinessTripEvent {
  final String nip;
  final String officeId;
  final String presenceId;
  final String startDate;
  final String endDate;
  final File file;

  const SendBusinessTrip({
    required this.nip,
    required this.officeId,
    required this.presenceId,
    required this.startDate,
    required this.endDate,
    required this.file,
  });

  @override
  List<Object> get props => [startDate, endDate, file];
}
