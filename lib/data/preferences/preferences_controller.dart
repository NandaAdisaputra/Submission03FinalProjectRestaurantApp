import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/preferences/preference_helper.dart';

final ThemeData darkTheme = ThemeData.dark();
final ThemeData lightTheme = ThemeData.light();

class PreferencesController extends GetxController {
  final PreferencesHelper preferencesHelper;

  final RxBool isDarkTheme = false.obs;
  final RxBool isRestaurantDailyActive = false.obs;

  PreferencesController({required this.preferencesHelper});

  @override
  void onInit() {
    super.onInit();
    _getPreferences();
  }

  void _getPreferences() {
    isDarkTheme.value = preferencesHelper.isDarkTheme;
    isRestaurantDailyActive.value = preferencesHelper.isDailyRestaurantActive;
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getPreferences();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    _getPreferences();
  }
}
