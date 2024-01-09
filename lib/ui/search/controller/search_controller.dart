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
  var hasError = false.obs;
  var hasData = false.obs;
  late String _message = '';

  String get message => _message;

  @override
  void onInit() {
    super.onInit();
    queryRestaurantsSearch.clear();
    clearRestaurantData();
  }

  void clearRestaurantData() {
    listBodyRestaurants = [];
    queryInp.value = '';
    update();
  }

  Future<dynamic> getListRestaurant() async {
    if (queryInp.isEmpty) {
      clearRestaurantData();
      return null;
    }
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
        hasError(false);
        hasData(true);
        return listBodyRestaurants;
      } else {
        hasError(true);
        throw Exception(ErrorHandler.handle(dynamic));
      }
    } on TimeoutException {
      hasError(true);
      throw Exception(_message = Constants.requestTimedOut);
    } on SocketException {
      hasError(true);
      throw Exception(_message = Constants.noInternetConnection);
    } catch (error) {
      hasError(true);
      throw Exception(_message = "An error occurred: $error");
    } finally {
      isDataLoading(false);
      update();
    }
  }
}
