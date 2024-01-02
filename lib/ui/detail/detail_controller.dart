import 'package:get/get.dart';
import 'package:submission3nanda/data/model/detail_restaurant.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/utils/result_state.dart';

class DetailRestaurantController extends GetxController {
  late final ApiService apiService;
  late Rx<DetailRestaurant> _detailRestaurant;
  late Rx<ResultState> _state;
  final RxString _message = ''.obs;

  DetailRestaurant get result => _detailRestaurant.value;
  ResultState get state => _state.value;
  String get message => _message.value;

  Future<void> fetchDetailRestaurant(String id) async {
    try {
      if (id.isEmpty) {
        _state(ResultState.noData);
        _message('No Data Restaurant Found');
      } else {
        _state(ResultState.loading);
        final restaurant = await apiService.detailRestaurant(id);
        _detailRestaurant.value = restaurant; // Update the value using `.value`
        _state(ResultState.hasData);
      }
    } catch (e) {
      _state(ResultState.error);
      _message('Check Your Internet Connection!');
    }
  }
}