import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final notificationPlugin = FlutterLocalNotificationsPlugin();
  final bool _initialized = false;
  bool get isInitialized => _initialized;

  // Initialize the notification service
  Future<void> initNotification() async {
    if (_initialized) return;

    // prepare settings for the android
    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // prepare settings for the iOS

    // initialize the settings
    final initSettings = InitializationSettings(
      android: initSettingsAndroid,
    );

    await notificationPlugin.initialize(
      initSettings,
    );
    await notificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // Notification details
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notification',
        channelDescription: 'channel description',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  // Show notification
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationPlugin.show(
      id,
      title,
      body,
       notificationDetails(),
    );
  }
}
