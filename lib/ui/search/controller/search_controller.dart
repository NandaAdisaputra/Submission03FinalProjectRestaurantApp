import 'package:get/get.dart';
import 'package:submission3nanda/data/model/search_restaurant.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/utils/result_state.dart';

class SearchRestaurantController extends GetxController {
  final ApiService apiService;

  SearchRestaurantController({required this.apiService});

  final Rx<ResultState> _state = ResultState.noData.obs;
  final Rx<String> _message = ''.obs;
  final Rx<SearchRestaurant> _searchRestaurant = SearchRestaurant(restaurants: []).obs;
  final RxString _query = ''.obs;

  String get message => _message.value;
  SearchRestaurant get result => _searchRestaurant.value;
  ResultState get state => _state.value;
  String get query => _query.value;

  set query(String value) => _query.value = value;

  Future<void> search(String query) async {
    await _fetchSearchRestaurant(query);
  }

  Future<void> _fetchSearchRestaurant(String query) async {
    try {
      if (query.isEmpty) {
        _state(ResultState.noData);
        _searchRestaurant(SearchRestaurant(restaurants: []));
        _message.value = 'No Data Restaurant Found';
        return;
      }

      _state(ResultState.loading);
      final restaurant = await apiService.searchRestaurant(query.toLowerCase());
      if (restaurant.restaurants.isEmpty) {
        _state(ResultState.noData);
        _searchRestaurant(SearchRestaurant(restaurants: []));
        _message.value = 'No Data Restaurant Found';
        return;
      } else {
        _state(ResultState.hasData);
        _searchRestaurant(restaurant);
      }
    } catch (e) {
      _state(ResultState.error);
      _searchRestaurant(SearchRestaurant(restaurants: []));
      _message.value = 'Check Your Internet Connection!';
    }
  }
}