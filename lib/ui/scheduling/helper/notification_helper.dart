import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/model/list_restaurant.dart';
import 'package:submission3nanda/data/network/api_service.dart';

import '../../../data/model/restaurant_model.dart';

class NotificationHelper extends GetxController {
  final RxString selectNotificationSubject = ''.obs;

  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettingsIOS = const IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ListRestaurant restaurant) async {
    var androidPlatformChannelSpecifics = _createAndroidNotificationDetails();
    var iOSPlatformChannelSpecifics = _createIOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var restaurantList = await _fetchRestaurantList();
    var restaurantRandom = _getRandomRestaurant(restaurantList);

    var titleNotification = "<b>New Restaurant Alert!</b>";
    var titleRestaurant = '<b>${restaurantRandom.name}</b>';
    var city = '<b>${restaurantRandom.city}</b>';
    var rating = restaurantRandom.rating.toString();

    var notificationMessage = "Explore Restaurant $titleRestaurant\n"
        "in $city\n"
        "rating of $rating";

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, notificationMessage, platformChannelSpecifics,
        payload: json.encode(restaurantRandom.toJson()));
  }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificationSubject.listen((String payload) async {
      var data = Restaurant.fromJson(json.decode(payload));
      Get.toNamed(route, arguments: data.id);
    });
  }

  Future<ListRestaurant> _fetchRestaurantList() async {
    return await ApiService(Client()).listRestaurant();
  }

  Restaurant _getRandomRestaurant(ListRestaurant restaurantList) {
    var restaurantItem = restaurantList.restaurants;
    var randomIndex = Random().nextInt(restaurantItem.length);
    return restaurantItem[randomIndex];
  }

  Future<void> _onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    selectNotificationSubject.value = payload ?? Constants.emptyPayload;
  }

  AndroidNotificationDetails _createAndroidNotificationDetails() {
    return const AndroidNotificationDetails(
        "1", Constants.channelOne, Constants.restaurantChannel,
        importance: Importance.max,
        priority: Priority.high,
        ticker: Constants.tickerNotification,
        styleInformation: DefaultStyleInformation(true, true));
  }

  IOSNotificationDetails _createIOSNotificationDetails() {
    return const IOSNotificationDetails();
  }
}
