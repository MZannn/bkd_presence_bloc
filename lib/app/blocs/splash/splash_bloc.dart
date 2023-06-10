import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<Navigate>(
      (event, emit) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        print(token);
        emit(SplashLoading());
        await Future.delayed(
          const Duration(seconds: 2),
        );
        if (token != null) {
          emit(NavigateToHomePage());
        } else {
          emit(NavigateToLoginPage());
        }
      },
    );
  }
}
