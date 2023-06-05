part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class GetAllData extends HomeEvent {
  final Position position;
  const GetAllData({required this.position});
  @override
  List<Object?> get props => [position];
}

class PresenceOutChecker extends HomeEvent {}

class PresenceOut extends HomeEvent {}

class PresenceIn extends HomeEvent {
  final Position position;
  final CameraPosition? cameraPosition;
  const PresenceIn({
    required this.position,
    this.cameraPosition,
  });
  @override
  List<Object?> get props => [position];
}

class LoadGeolocation extends HomeEvent {}
