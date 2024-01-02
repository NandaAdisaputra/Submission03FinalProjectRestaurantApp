import 'package:get/get.dart';
import 'package:submission3nanda/data/base/database/database_helper.dart';
import 'package:submission3nanda/data/model/restaurant_model.dart';
import 'package:submission3nanda/utils/result_state.dart';

class DatabaseController extends GetxController {
  late final DatabaseHelper databaseHelper;

  DatabaseController({required this.databaseHelper}) {
    getFavorites();
  }

  final Rx<ResultState> _state = ResultState.loading.obs;

  Rx<ResultState> get state => _state;

  final RxList<Restaurant> _favorites = <Restaurant>[].obs;

  RxList<Restaurant> get favorites => _favorites;

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
    final favoritedRestaurant = await databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      getFavorites();
    } catch (e) {
      _state(ResultState.error);
      showMessage('Remove Favorite Restaurant failed');
    }
  }

  final RxString _message = ''.obs;

  RxString get message => _message;

  void showMessage(String value) {
    _message(value);
    update(); // Trigger UI update
  }
}