part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationChanged extends NavigationEvent {
  final int selectedIndex;
  const NavigationChanged({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
