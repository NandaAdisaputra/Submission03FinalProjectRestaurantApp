import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/data/model/restaurant_model.dart';
import 'package:submission3nanda/ui/themes/theme_controller.dart';
import 'package:submission3nanda/utils/result_state.dart';

class FavoriteController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ThemeController _themeController = Get.find<ThemeController>();
  final count = 0.obs;
  Rx<String> currentModeName = ''.obs;
  RxBool isDarkMode = false.obs;
  late Color textColor;
  double fontSize = 20;
  late AnimationController animationController;

  late final DatabaseHelper databaseHelper;

  FavoriteController({required this.databaseHelper}) {
    getFavorites();
  }

  final Rx<ResultState> _state = ResultState.loading.obs;

  Rx<ResultState> get state => _state;

  final RxList<Restaurant> _favorites = <Restaurant>[].obs;

  RxList<Restaurant> get favorites => _favorites;

  @override
  void onInit() {
    isDarkMode.value = _themeController.isDarkTheme;
    currentModeName.value = _themeController.isDarkTheme ? 'Dark' : 'Light';

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 430));
    animationController.reset();
    textColor = isDarkMode.value ? Colors.white : Colors.red;
    fontSize = isDarkMode.value ? 30 : 20;
    getFavorites();
    super.onInit();
  }

  void changeAppTheme() => _changeTheme();

  bool toggleTheme() {
    _changeTheme();
    return isDarkMode.value;
  }

  void _animate() {
    if (isDarkMode.value) {
      fontSize = 30;
      textColor = Colors.white;
      animationController.reverse();
    } else {
      fontSize = 20;
      textColor = Colors.red;
      animationController.forward();
    }
  }

  void _changeTheme() {
    _themeController.changeTheme(
      isDarkMode: isDarkMode,
      modeName: currentModeName,
    );
    _animate();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void getFavorites() async {
    _state(ResultState.loading);
    _favorites(await databaseHelper.getFavorite());
    if (_favorites.isNotEmpty) {
      _state(ResultState.hasData);
    } else {
      _state(ResultState.noData);
      showMessage('Favorite Restaurant not found');
    }
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      getFavorites();
    } catch (e) {
      _state(ResultState.error);
      showMessage('Add Favorite Restaurant failed');
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      update();
      getFavorites();
    } catch (e) {
      _state(ResultState.error);
      showMessage('Remove Favorite Restaurant failed');
    }
  }

  void removeAllFavorite() async {
    try {
      await databaseHelper.removeAllFavorite();
      update();
      getFavorites();
    } catch (e) {
      _state(ResultState.error);
      showMessage('Remove All Favorite Restaurant failed');
    }
  }

  final RxString _message = ''.obs;

  RxString get message => _message;

  void showMessage(String value) {
    _message(value);
    update(); // Trigger UI update
  }
}
