part of 'presence_history_bloc.dart';

abstract class PresenceHistoryState extends Equatable {
  const PresenceHistoryState();

  @override
  List<Object> get props => [];
}

class PresenceHistoryInitial extends PresenceHistoryState {}

class PresenceHistoryLoading extends PresenceHistoryState {}

class PresenceHistoryLoaded extends PresenceHistoryState {
  final List<Presence> presences;
  const PresenceHistoryLoaded({required this.presences});

  @override
  List<Object> get props => [presences];
}

class PresenceHistoryError extends PresenceHistoryState {
  final String message;
  const PresenceHistoryError({required this.message});

  @override
  List<Object> get props => [message];
}
