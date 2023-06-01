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
  const HomeLoaded({
    this.userModel,
    required this.position,
    this.cameraPosition,
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

class FakeGpsDetected extends HomeState {
  final String message;
  const FakeGpsDetected({required this.message});

  @override
  List<Object?> get props => [message];
}
