import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/preferences/preference_helper.dart';

final ThemeData darkTheme = ThemeData.dark();
final ThemeData lightTheme = ThemeData.light();

class PreferencesController extends GetxController {
  late PreferencesHelper preferencesHelper;

  final RxBool _isDarkTheme = false.obs;

  ThemeData get themeData => _isDarkTheme.value ? darkTheme : lightTheme;

  RxBool get isDarkTheme => _isDarkTheme;

  final RxBool _isRestaurantDailyActive = false.obs;

  RxBool get isRestaurantDailyActive => _isRestaurantDailyActive;

  @override
  void onInit() {
    super.onInit();
    _getDarkThemePreferences();
    _getDailyRestaurantPreferences();
  }

  void _getDarkThemePreferences() async {
    _isDarkTheme.value = await preferencesHelper.isDarkTheme;
  }

  void _getDailyRestaurantPreferences() async {
    _isRestaurantDailyActive.value =
        await preferencesHelper.isDailyRestaurantActive;
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getDarkThemePreferences();
    update();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    _getDailyRestaurantPreferences();
    update();
  }
}
