import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/ui/scheduling/notification_helper.dart';

class BackgroundService extends GetxService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static final Rx<SendPort?> _uiSendPort = Rx<SendPort?>(null);

  Rx<ReceivePort> port = ReceivePort().obs;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  @override
  void onInit() {
    super.onInit();
    initializeIsolate();
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.value.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    debugPrint('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().listRestaurant();
    await notificationHelper.showNotification(
        FlutterLocalNotificationsPlugin(), result);

    _uiSendPort.value ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort.value?.send(null);
  }
}
