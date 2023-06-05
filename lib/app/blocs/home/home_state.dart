part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final UserModel? userModel;
  final Position position;
  final CameraPosition? cameraPosition;
  final DateTime? dateTime;
  const HomeLoaded({
    this.userModel,
    required this.position,
    this.cameraPosition,
    this.dateTime,
  });

  @override
  List<Object?> get props => [userModel, position];
}

class HomeError extends HomeState {
  final String message;
  final Position position;
  const HomeError({required this.message, required this.position});

  @override
  List<Object?> get props => [message, position];
}

class PresenceError extends HomeState {
  final String message;
  const PresenceError({required this.message});

  @override
  List<Object?> get props => [message];
}
