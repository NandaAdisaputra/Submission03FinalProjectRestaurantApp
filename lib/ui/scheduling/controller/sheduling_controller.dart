import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/ui/scheduling/helper/date_helper.dart';
import 'package:submission3nanda/ui/scheduling/service/background_service.dart';


class SchedulingController extends GetxController {
  var isRestaurantDailyActive = false.obs;

  bool get isScheduled => isRestaurantDailyActive.value;

  Future<bool> scheduledRestaurant(bool value) async {
    try {
      isRestaurantDailyActive.value = value;
      if (isRestaurantDailyActive.value) {
        if (kDebugMode) {
          debugPrint(Constants.schedulingActivated);
        }

        await AndroidAlarmManager.periodic(
          const Duration(hours: 24),
          1,
          BackgroundService.callback,
          startAt: DateTimeHelper.nextScheduledDateTime().value,
          exact: true,
          wakeup: true,
        );
      } else {
        if (kDebugMode) {
          debugPrint(Constants.schedulingCanceled);
        }
        final SendPort? send = IsolateNameServer.lookupPortByName(Constants.alarmIsolate);
        send?.send(value);
        await AndroidAlarmManager.cancel(1);
      }

      update();
      return true;
    } catch (e) {
      return false;
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
