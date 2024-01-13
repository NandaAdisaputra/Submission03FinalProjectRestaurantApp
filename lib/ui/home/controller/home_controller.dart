import 'package:get/get.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/model/list_restaurant.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';
import 'package:submission3nanda/utils/result_state.dart';

class HomeController extends GetxController {
  late final ApiService apiService;

  HomeController({required this.apiService}) {
    fetchAllRestaurant();
  }

  late final RxList<ListRestaurant> _listRestaurant = <ListRestaurant>[].obs;
  late final Rx<ResultState> _state = ResultState.loading.obs;
  late String _message = '';

  String get message => _message;

  RxList<ListRestaurant> get result => _listRestaurant;

  ResultState get state => _state.value;

  Future<void> fetchAllRestaurant() async {
    try {
      _state(ResultState.loading);
      update();
      final restaurant = await apiService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state(ResultState.noData);
        update();
        _message = Constants.noDataFound;
      } else {
        _state(ResultState.hasData);
        update();
        List<ListRestaurant> listRestaurants = restaurant.restaurants
            .map((innerRestaurant) => ListRestaurant(
          error: false,
          message: "Data loaded successfully",
          count: restaurant.restaurants.length,
          restaurants: [innerRestaurant],
        ))
            .toList();

        _listRestaurant.assignAll(listRestaurants);
      }
    } catch (e) {
      _state(ResultState.error);
      update();
      _message = Constants.noInternetAccess;
    }
  }

  void updateFavorites() {
    final favoriteController = Get.find<FavoriteController>();
    _listRestaurant.assignAll(favoriteController.favorites
        .map((restaurant) => ListRestaurant(
      error: false,
      message: "Favorite restaurant: ${restaurant.name}",
      count: favoriteController.favorites.length,
      restaurants: [restaurant],
    ))
        .toList()
        .obs);
    update();
  }
  void updateNonFavorites() {
    fetchAllRestaurant();
    update();
  }
}
