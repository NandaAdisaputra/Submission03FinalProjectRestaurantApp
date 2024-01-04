import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:submission3nanda/ui/scheduling/background_service.dart';

import 'date_helper.dart';

class SchedulingController extends GetxController {
  final RxBool _isScheduled = false.obs;

  bool get isScheduled => _isScheduled.value;

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled.value = value;
    if (_isScheduled.value) {
      if (kDebugMode) {
        print('Scheduling Restaurant Activated');
      }
      update();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format().value,
        exact: true,
        wakeup: true,
      );
    } else {
      if (kDebugMode) {
        print('Scheduling Restaurant Canceled');
      }
      update();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
