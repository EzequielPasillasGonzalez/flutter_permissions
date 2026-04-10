import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';

const String fetchBackgroundTaskKey =
    'com.chekepasillas.flutter_permissions.fetch-background-pokemon';

const String fetchPeriodicBackgroundTaskKey =
    'com.chekepasillas.flutter_permissions.fetch-periodic-background-pokemon';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackgroundTaskKey:
        debugPrint(fetchBackgroundTaskKey);
        break;
      case fetchPeriodicBackgroundTaskKey:
        debugPrint(fetchPeriodicBackgroundTaskKey);
        break;

      case Workmanager.iOSBackgroundTask:
        debugPrint('Workmanager.iOSBackgroundTask');
        break;
    }

    return true;

    // debugPrint("Native: Background task: $task");
    // // Your background work here
    // return Future.value(true);
  });
}
