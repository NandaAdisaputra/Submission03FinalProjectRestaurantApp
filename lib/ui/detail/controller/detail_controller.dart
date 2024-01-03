import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:submission3nanda/data/base/endpoints.dart' as Endpoints;
import 'package:submission3nanda/ui/review/controller/review_controller.dart';
import 'package:submission3nanda/utils/error_helper/error_handler.dart';


class DetailRestaurantController extends GetxController {
  final reviewController = Get.find<ReviewController>();
  var listBodyRestaurants;
  var listBodyRestaurantsMenusFoods = [];
  var listBodyRestaurantsMenusDrinks = [];
  var idRestaurant = ' ';

  Future<dynamic> getListRestaurant() async {
    WidgetsFlutterBinding.ensureInitialized();
    String urlDetail = Endpoints.getDetailRestaurant.detail + "/$idRestaurant";
    final response = await http
        .get(Uri.parse(urlDetail))
        .timeout((const Duration(seconds: 5)));
    var responseJson = json.decode(response.body);
    listBodyRestaurants = responseJson;
    listBodyRestaurantsMenusFoods =
    responseJson['restaurant']['menus']['foods'];
    listBodyRestaurantsMenusDrinks =
    responseJson['restaurant']['menus']['drinks'];
    try {
      if (response.statusCode == 200) {
        return listBodyRestaurants;
      } else {
        throw Exception(ErrorHandler.handle(dynamic));
      }
    } on Error {
      rethrow;
    }
  }
}
