import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/model/list_restaurant.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/utils/result_state.dart';

class HomeController extends GetxController {
  late final ApiService apiService;

  HomeController({required this.apiService}) {
    fetchAllRestaurant();
  }

  late ListRestaurant _listRestaurant;
  late final Rx<ResultState> _state = ResultState.loading.obs;
  late String _message = '';

  String get message => _message;

  ListRestaurant get result => _listRestaurant;

  ResultState get state => _state.value;

  Future<void> fetchAllRestaurant() async {
    try {
      _state(ResultState.loading); // Set the value using the Rx object
      update();
      final restaurant = await apiService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state(ResultState.noData); // Set the value using the Rx object
        update();
        _message = Constants.noDataFound;
      } else {
        _state(ResultState.hasData); // Set the value using the Rx object
        update();
        _listRestaurant = restaurant;
      }
    } catch (e) {
      _state(ResultState.error); // Set the value using the Rx object
      update();
      _message = Constants.noInternetAccess;
    }
  }

}
