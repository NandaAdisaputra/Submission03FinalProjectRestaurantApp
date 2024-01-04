import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/utils/error_helper/error_handler.dart';
import 'package:submission3nanda/data/base/endpoints.dart' as Endpoints;
import 'package:submission3nanda/utils/widget/custom_progress_indicator.dart';

class SearchRestaurantController extends GetxController {
  final queryRestaurantsSearch = TextEditingController();
  var queryInp = ''.obs;
  var listBodyRestaurants;
  var isDataLoading = false.obs;

  Future<dynamic> getListRestaurant() async {
    isDataLoading(true);
    CustomProgressIndicator.openLoadingDialog();
    WidgetsFlutterBinding.ensureInitialized();
    String urlSearch = Endpoints.getSearch.search + "?q=$queryInp";
    final response = await http
        .get(Uri.parse(urlSearch))
        .timeout(const Duration(seconds: 5));
    var responseJson = json.decode(response.body)[Constants.restaurants];
    listBodyRestaurants = responseJson;
    try {
      if (response.statusCode == 200) {
        return listBodyRestaurants;
      } else {
        throw Exception(ErrorHandler.handle(dynamic));
      }
    } on Error {
      await CustomProgressIndicator.closeLoadingOverlay();
      isDataLoading(false);
      rethrow;
    } finally {
      update();
    }
  }
}
