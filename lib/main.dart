import 'package:bilsoft_srlm/core/di/service_locator.dart';
import 'package:bilsoft_srlm/core/service/notification_service.dart';
import 'package:bilsoft_srlm/core/service/workmanager_service.dart';
import 'package:bilsoft_srlm/features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
  Workmanager().initialize(isInDebugMode: true, callbackDispatcher);
  //Workmanager().registerOneOffTask("oneoff-task-identifier", "simpleTask");
  Workmanager().registerPeriodicTask(
    "periodic-task-identifier",
    "simplePeriodicTask",
    // When no frequency is provided the default 15 minutes is set.
    // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min ifu //have configured a lower frequency.
    initialDelay: Duration(seconds: 10),
  );
  await setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bilsoft SRLM',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}
