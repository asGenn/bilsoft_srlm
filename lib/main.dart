import 'package:bilsoft_srlm/core/di/service_locator.dart';
import 'package:bilsoft_srlm/core/service/notification_service.dart';
import 'package:bilsoft_srlm/core/service/workmanager_service.dart';
import 'package:bilsoft_srlm/features/home/cubit/home_cubit.dart';
import 'package:bilsoft_srlm/features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workmanager/workmanager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  Workmanager().initialize(isInDebugMode: true, callbackDispatcher);
  //Workmanager().registerOneOffTask("oneoff-task-identifier", "simpleTask");

  await setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getStokList(),
      child: MaterialApp(
        title: 'Bilsoft SRLM',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
