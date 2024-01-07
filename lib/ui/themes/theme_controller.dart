import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:submission3nanda/data/const/constants.dart';

class ThemeController extends GetxController {
  late bool isDarkTheme;
  late bool themeHiveSetting;

  final Box<dynamic> settingsHiveBox = Hive.box(Constants.settings);

  ThemeMode get themeStateFromHiveSettingBox =>
      _getThemeFromHiveBox() ? ThemeMode.dark : ThemeMode.light;

  @override
  void onInit() {
    isDarkTheme = _getThemeFromHiveBox();
    super.onInit();
  }

  bool _getThemeFromHiveBox() {
    themeHiveSetting =
        settingsHiveBox.get(Constants.isDarkMode, defaultValue: Get.isDarkMode);
    return themeHiveSetting;
  }

  void _updateHiveThemeSetting(bool boolData) {
    settingsHiveBox.put(Constants.isDarkMode, boolData);
  }

  void changeTheme({
    required RxBool isDarkMode,
    required Rx<String> modeName,
  }) {
    if (Get.isDarkMode) {
      modeName.value = Constants.lightMode;
      isDarkMode.value = false;
      isDarkTheme = false;
      _updateHiveThemeSetting(false);
      _changeThemeMode(ThemeMode.light);
    } else {
      modeName.value = Constants.darkMode;
      isDarkMode.value = true;
      isDarkTheme = true;
      _updateHiveThemeSetting(true);
      _changeThemeMode(ThemeMode.dark);
    }
  }

  void _changeThemeMode(ThemeMode themeMode) => Get.changeThemeMode(themeMode);
}
