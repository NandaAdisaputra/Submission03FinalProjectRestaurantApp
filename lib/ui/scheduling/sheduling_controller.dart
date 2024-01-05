import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:submission3nanda/ui/scheduling/background_service.dart';

class SchedulingController extends GetxController {
  var isRestaurantDailyActive = false.obs;

  bool get isScheduled => isRestaurantDailyActive.value;

  Future<bool> scheduledRestaurant(bool value) async {
    isRestaurantDailyActive.value = value;
    update();
    if (isRestaurantDailyActive.value) {
      if (kDebugMode) {
        print('Scheduling Restaurant Activated');
      }
      update();
      final SendPort? send = IsolateNameServer.lookupPortByName('alarmIsolate');
      send?.send(value);
      return await AndroidAlarmManager.oneShotAt(
        DateTime.now().add(const Duration(seconds: 5)),
        1,
        BackgroundService.callback,
        exact: true,
        wakeup: true,
      );
    } else {
      if (kDebugMode) {
        debugPrint('Scheduling Restaurant Canceled');
      }
      final SendPort? send = IsolateNameServer.lookupPortByName('alarmIsolate');
      send?.send(value);
      update();
      return await AndroidAlarmManager.cancel(1);
    }
  }

  void startIsolate() async {
    ReceivePort port = ReceivePort();
    IsolateNameServer.registerPortWithName(port.sendPort, 'alarmIsolate');

    await Isolate.spawn(_isolateEntryPoint, port.sendPort);
  }

  static void _isolateEntryPoint(SendPort sendPort) {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    port.listen((message) {
      BackgroundService.callback();
    });
  }
}
