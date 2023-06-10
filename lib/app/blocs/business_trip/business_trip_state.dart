part of 'business_trip_bloc.dart';

abstract class BusinessTripState extends Equatable {
  const BusinessTripState();

  @override
  List<Object> get props => [];
}

class BusinessTripInitial extends BusinessTripState {}

class StartDatePicked extends BusinessTripState {
  final String startDate;

  const StartDatePicked(this.startDate);

  @override
  List<Object> get props => [startDate];
}

class StartDateNotPicked extends BusinessTripState {
  final String message;

  const StartDateNotPicked({required this.message});

  @override
  List<Object> get props => [message];
}

class EndDatePicked extends BusinessTripState {
  final String endDate;

  const EndDatePicked(this.endDate);

  @override
  List<Object> get props => [endDate];
}

class EndDateNotPicked extends BusinessTripState {
  final String message;

  const EndDateNotPicked({required this.message});

  @override
  List<Object> get props => [message];
}

class FilePicked extends BusinessTripState {
  final String fileName;
  final File file;
  const FilePicked({
    required this.fileName,
    required this.file,
  });

  @override
  List<Object> get props => [fileName];
}

class FileNotPicked extends BusinessTripState {
  final String message;
  const FileNotPicked({required this.message});

  @override
  List<Object> get props => [message];
}

class SendBusinessTripApiSuccess extends BusinessTripState {
  final String message;

  const SendBusinessTripApiSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class SendBusinessTripApiFailed extends BusinessTripState {
  final String message;

  const SendBusinessTripApiFailed({required this.message});

  @override
  List<Object> get props => [message];
}
