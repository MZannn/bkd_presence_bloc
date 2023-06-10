part of 'presence_history_bloc.dart';

abstract class PresenceHistoryEvent extends Equatable {
  const PresenceHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetAllPresenceHistory extends PresenceHistoryEvent {}
