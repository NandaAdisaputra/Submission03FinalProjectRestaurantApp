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
  var listBodyRestaurants = <dynamic>[];
  var isDataLoading = false.obs;
  var hasError = false.obs;
  var hasData = false.obs;
  late String _message = '';

  String get message => _message;

  SearchRestaurantController() {
    clearRestaurantData();
  }

  @override
  void onInit() {
    super.onInit();
    clearRestaurantData();
  }

  void clearRestaurantData() {
    queryRestaurantsSearch.clear();
    listBodyRestaurants.clear();
    hasData.value = false;
    hasError.value = false;
    _message = '';
    update();
  }

  Future<dynamic> getListRestaurant() async {
    if (queryRestaurantsSearch.text.isEmpty) {
      clearRestaurantData();
      return null;
    }
    isDataLoading(true);
    try {
      final responseJson = await fetchData();
      listBodyRestaurants = responseJson;
      hasError(false);
      hasData(true);
      return listBodyRestaurants;
    } catch (error) {
      handleErrorResponse(error);
    } finally {
      isDataLoading(false);
      update();
    }
  }

  Future<List<dynamic>> fetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    String urlSearch = "${end_points.getSearch.search}?q=${queryRestaurantsSearch.text}";
    final response = await http.get(Uri.parse(urlSearch)).timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      return json.decode(response.body)[Constants.restaurants];
    } else {
      throw Exception(ErrorHandler.handle(dynamic));
    }
  }

  void handleErrorResponse(dynamic error) {
    hasError(true);
    if (error is TimeoutException) {
      _message = Constants.requestTimedOut;
    } else if (error is SocketException) {
      _message = Constants.noInternetConnection;
    } else {
      _message = "An error occurred: $error";
    }
  }

  @override
  void onClose() {
    queryRestaurantsSearch.clear();
    listBodyRestaurants.clear();
    super.onClose();
  }
}
