import 'package:bilsoft_srlm/domain/repositories/auth_repository.dart';
import 'package:bilsoft_srlm/features/home/view/home.dart';
import 'package:bilsoft_srlm/features/splash/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..checkUserIsLoggedIn(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Giriş Başarılı'),
                  duration: Duration(seconds: 2),
                ),
              );
            Navigator.of(context).pushReplacement(HomeScreen.route());
          }

          
        },
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
