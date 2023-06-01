import 'package:bkd_presence_bloc/app/app.dart';
import 'package:bkd_presence_bloc/app/blocs/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/repositories/geolocation_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeolocationRepository>(
          create: (context) => GeolocationRepository(),
        ),
      ],
      child: const App(),
    );
  }
}
