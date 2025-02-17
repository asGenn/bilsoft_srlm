import 'package:bilsoft_srlm/core/di/service_locator.dart';
import 'package:bilsoft_srlm/core/service/notification_service.dart';
import 'package:bilsoft_srlm/features/splash/splash.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotification();
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
