import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask(
    (taskName, inputData) {
      print('Native called background task: $taskName');
      print("yapıyoruzzzzz");
      return Future.value(true);
    },
  );
}
