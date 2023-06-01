import 'package:bkd_presence_bloc/app/blocs/home/home_bloc.dart';
import 'package:bkd_presence_bloc/app/blocs/login/login_bloc.dart';
import 'package:bkd_presence_bloc/app/blocs/navigation/navigation_bloc.dart';
import 'package:bkd_presence_bloc/app/blocs/splash/splash_bloc.dart';
import 'package:bkd_presence_bloc/app/pages/home_page.dart';
import 'package:bkd_presence_bloc/app/pages/login_page.dart';
import 'package:bkd_presence_bloc/app/pages/navigation_page.dart';
import 'package:bkd_presence_bloc/app/pages/splash_page.dart';
import 'package:bkd_presence_bloc/app/repositories/geolocation_repository.dart';
import 'package:flutter/material.dart';

class Routes {
  Route route(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SplashBloc(),
            child: const SplashPage(),
          ),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomeBloc(
                geolocationRepository: context.read<GeolocationRepository>())
              ..add(LoadGeolocation()),
            child: const HomePage(),
          ),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginBloc(),
            child: const LoginPage(),
          ),
        );
      case '/navigation':
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => NavigationBloc(),
              ),
              BlocProvider(
                create: (context) => HomeBloc(
                    geolocationRepository:
                        context.read<GeolocationRepository>())
                  ..add(
                    LoadGeolocation(),
                  ),
              ),
            ],
            child: const NavigationPage(),
          ),
        );

      default:
        return MaterialPageRoute(builder: (context) => const Scaffold());
    }
  }
}
