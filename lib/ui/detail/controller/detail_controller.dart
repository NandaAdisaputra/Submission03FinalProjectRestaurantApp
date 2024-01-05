import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:submission3nanda/data/model/detail_restaurant.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/ui/review/controller/review_controller.dart';
import 'package:submission3nanda/utils/result_state.dart';

class DetailRestaurantController extends GetxController {
  final reviewController = Get.find<ReviewController>();
  String? idRestaurant = ' ';

  DetailRestaurantController({this.idRestaurant = ''}) {
    getListRestaurant(idRestaurant);
  }

  final Rx<DetailRestaurant> _listRestaurant = DetailRestaurant().obs;
  final Rx<ResultState> _state = ResultState.loading.obs;
  final RxString _message = ''.obs;

  RxString get message => _message;

  Rx<DetailRestaurant> get result => _listRestaurant;

  ResultState get state => _state.value;

  Future<dynamic> getListRestaurant(String? idRestaurant) async {
    try {
      _state(ResultState.loading); // Set the value using the Rx object
      update();
      final restaurant =
          await ApiService(Client()).detailRestaurant(idRestaurant);
      if (restaurant.restaurant == null) {
        _state(ResultState.noData); // Set the value using the Rx object
        update();
        _message('No Data Restaurant Found');
      } else {
        _state(ResultState.hasData); // Set the value using the Rx object
        _listRestaurant(restaurant);
        update();
        debugPrint("data $restaurant");
      }
    } catch (e) {
      _state(ResultState.error);
      _message('Check Your Internet Connection!');
    } finally {
      update();
    } // Set the value using the Rx object
  }
}
