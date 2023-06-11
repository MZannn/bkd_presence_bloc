import 'package:bkd_presence_bloc/app/blocs/business_trip/business_trip_bloc.dart';
import 'package:bkd_presence_bloc/app/blocs/change_device/change_device_bloc.dart';
import 'package:bkd_presence_bloc/app/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:bkd_presence_bloc/app/blocs/home/home_bloc.dart';
import 'package:bkd_presence_bloc/app/blocs/login/login_bloc.dart';
import 'package:bkd_presence_bloc/app/blocs/navigation/navigation_bloc.dart';
import 'package:bkd_presence_bloc/app/blocs/presence_history/presence_history_bloc.dart';
import 'package:bkd_presence_bloc/app/blocs/splash/splash_bloc.dart';
import 'package:bkd_presence_bloc/app/blocs/vacation/vacation_bloc.dart';
import 'package:bkd_presence_bloc/app/pages/business_trip_page.dart';
import 'package:bkd_presence_bloc/app/pages/change_device_page.dart';
import 'package:bkd_presence_bloc/app/pages/detail_presence_page.dart';
import 'package:bkd_presence_bloc/app/pages/edit_profile_page.dart';
import 'package:bkd_presence_bloc/app/pages/home_page.dart';
import 'package:bkd_presence_bloc/app/pages/login_page.dart';
import 'package:bkd_presence_bloc/app/pages/navigation_page.dart';
import 'package:bkd_presence_bloc/app/pages/presence_history_page.dart';
import 'package:bkd_presence_bloc/app/pages/splash_page.dart';
import 'package:bkd_presence_bloc/app/pages/vacation_page.dart';
import 'package:bkd_presence_bloc/app/repositories/geolocation_repository.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String detailPresence = '/detail-presence';
  static const String presenceHistory = '/presence-history';
  static const String businessTrip = '/business-trip';
  static const String vacation = '/vacation';
  static const String navigation = '/navigation';
  static const String changeDevice = '/change-device';
  static const String editProfile = '/edit-profile';
  Route route(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SplashBloc(),
            child: const SplashPage(),
          ),
        );
      case home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomeBloc(
                geolocationRepository: context.read<GeolocationRepository>())
              ..add(LoadGeolocation()),
            child: const HomePage(),
          ),
        );
      case login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginBloc()..add(GetDeviceId()),
            child: const LoginPage(),
          ),
        );
      case detailPresence:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: settings.arguments,
          ),
          builder: (context) => const DetailPresencePage(),
        );
      case presenceHistory:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => PresenceHistoryBloc()
              ..add(
                GetAllPresenceHistory(),
              ),
            child: const PresenceHistoryPage(),
          ),
        );
      case businessTrip:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: settings.arguments,
          ),
          builder: (context) => BlocProvider(
            create: (context) => BusinessTripBloc(),
            child: const BusinessTripPage(),
          ),
        );
      case vacation:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: settings.arguments,
          ),
          builder: (context) => BlocProvider(
            create: (context) => VacationBloc(),
            child: const VacationPage(),
          ),
        );
      case changeDevice:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: settings.arguments,
          ),
          builder: (context) => BlocProvider(
            create: (context) => ChangeDeviceBloc(),
            child: const ChangeDevicePage(),
          ),
        );
      case editProfile:
        return MaterialPageRoute(
          settings: RouteSettings(
            arguments: settings.arguments,
          ),
          builder: (context) => BlocProvider(
            create: (context) => EditProfileBloc(),
            child: const EditProfilePage(),
          ),
        );
      case navigation:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => NavigationBloc()
                  ..add(
                    const NavigationChanged(
                      selectedIndex: 0,
                    ),
                  ),
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
