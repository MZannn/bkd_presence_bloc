part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {}

class NavigationLoaded extends NavigationState {
  final int selectedIndex;
  const NavigationLoaded({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
