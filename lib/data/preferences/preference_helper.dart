import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission3nanda/data/const/constants.dart';

class PreferencesHelper {
  static final PreferencesHelper _instance = PreferencesHelper._internal();

  late SharedPreferences _prefs;

  PreferencesHelper._internal() {
    _initPreferences();
  }

  factory PreferencesHelper() {
    return _instance;
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const darkThemeKey = Constants.darkThemeTitle;
  static const dailyRestaurantKey = Constants.dailyTitle;

  bool get isDarkTheme => _prefs.getBool(darkThemeKey) ?? false;

  setDarkTheme(bool value) {
    _prefs.setBool(darkThemeKey, value);
  }

  bool get isDailyRestaurantActive =>
      _prefs.getBool(dailyRestaurantKey) ?? false;

  setDailyRestaurant(bool value) {
    _prefs.setBool(dailyRestaurantKey, value);
  }
}
