import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    Future.delayed(
      Duration.zero,
      () {
        add(const NavigationChanged(selectedIndex: 0));
      },
    );
    on<NavigationChanged>(
      (event, emit) {
        emit(NavigationLoaded(selectedIndex: event.selectedIndex));
      },
    );
  }
}
