part of 'vacation_bloc.dart';

abstract class VacationState extends Equatable {
  const VacationState();

  @override
  List<Object> get props => [];
}

class VacationInitial extends VacationState {}

class StartDatePicked extends VacationState {
  final String currentTime;

  const StartDatePicked({required this.currentTime});

  @override
  List<Object> get props => [currentTime];
}

class StartDateNotPicked extends VacationState {
  final String message;

  const StartDateNotPicked({required this.message});

  @override
  List<Object> get props => [message];
}

class EndDatePicked extends VacationState {
  final String currentTime;

  const EndDatePicked({required this.currentTime});

  @override
  List<Object> get props => [currentTime];
}

class EndDateNotPicked extends VacationState {
  final String message;

  const EndDateNotPicked({required this.message});

  @override
  List<Object> get props => [message];
}

class FilePicked extends VacationState {
  final String fileName;
  final File file;

  const FilePicked({required this.fileName, required this.file});

  @override
  List<Object> get props => [fileName, file];
}

class FileNotPicked extends VacationState {
  final String message;

  const FileNotPicked({required this.message});

  @override
  List<Object> get props => [message];
}

class SendVacationApiSuccess extends VacationState {
  final String message;

  const SendVacationApiSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class SendVacationApiFailed extends VacationState {
  final String message;

  const SendVacationApiFailed({required this.message});

  @override
  List<Object> get props => [message];
}
