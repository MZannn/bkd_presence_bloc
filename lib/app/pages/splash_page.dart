import 'package:bkd_presence_bloc/app/routes/routes.dart';
import 'package:flutter/material.dart';
import '../blocs/splash/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(Navigate());
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is NavigateToLoginPage) {
            Navigator.pushReplacementNamed(context, Routes.login);
          }
          if (state is NavigateToHomePage) {
            Navigator.pushReplacementNamed(context, Routes.navigation);
          }
        },
        child: Container(
          color: Colors.white,
          child: Center(
            child: Image.asset(
              "assets/images/pemprov_kalteng.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
