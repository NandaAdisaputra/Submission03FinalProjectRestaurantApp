import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/utils/error_helper/error_handler.dart';
import 'package:submission3nanda/data/base/endpoints.dart' as end_points;

class SearchRestaurantController extends GetxController {
  final queryRestaurantsSearch = TextEditingController();
  var queryInp = ''.obs;
  late List<dynamic> listBodyRestaurants;
  var isDataLoading = false.obs;
  late String _message = '';

  String get message => _message;

  Future<dynamic> getListRestaurant() async {
    isDataLoading(true);
    try {
      WidgetsFlutterBinding.ensureInitialized();
      String urlSearch = "${end_points.getSearch.search}?q=$queryInp";
      final response = await http
          .get(Uri.parse(urlSearch))
          .timeout(const Duration(seconds: 5));
      var responseJson = json.decode(response.body)[Constants.restaurants];
      listBodyRestaurants = responseJson;
      if (response.statusCode == 200) {
        return listBodyRestaurants;
      } else {
        throw Exception(ErrorHandler.handle(dynamic));
      }
    } on TimeoutException {
      throw Exception(
      _message = Constants.requestTimedOut);
    } on SocketException {
      throw Exception(
      _message = Constants.noInternetConnection);
    } catch (error) {
      throw Exception( _message = "An error occurred: $error");
    } finally {
      isDataLoading(false);
      update();
    }
  }
}
