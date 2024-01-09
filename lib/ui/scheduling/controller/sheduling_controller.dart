import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/ui/scheduling/service/background_service.dart';


class SchedulingController extends GetxController {
  var isRestaurantDailyActive = false.obs;

  bool get isScheduled => isRestaurantDailyActive.value;

  Future<bool> scheduledRestaurant(bool value) async {
    isRestaurantDailyActive.value = value;
    update();
    if (isRestaurantDailyActive.value) {
      if (kDebugMode) {
        debugPrint(Constants.schedulingActivated);
      }
      update();
      final SendPort? send = IsolateNameServer.lookupPortByName(Constants.alarmIsolate);
      send?.send(value);
      return await AndroidAlarmManager.oneShotAt(
        DateTime.now().add(const Duration(hours: 24)),
        1,
        BackgroundService.callback,
        exact: true,
        wakeup: true,
      );
    } else {
      if (kDebugMode) {
        debugPrint(Constants.schedulingCanceled);
      }
      final SendPort? send = IsolateNameServer.lookupPortByName(Constants.alarmIsolate);
      send?.send(value);
      update();
      return await AndroidAlarmManager.cancel(1);
    }
  }

  void startIsolate() async {
    ReceivePort port = ReceivePort();
    IsolateNameServer.registerPortWithName(port.sendPort, Constants.alarmIsolate);

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