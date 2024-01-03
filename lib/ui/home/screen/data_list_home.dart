import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/ui/home/controller/home_controller.dart';
import 'package:submission3nanda/utils/result_state.dart';
import 'package:submission3nanda/utils/widget/card_restaurant.dart';
import 'package:submission3nanda/utils/widget/load_data_error.dart';

final HomeController homeController =
    Get.put(HomeController(apiService: ApiService()));

class DataListHomeScreen extends StatelessWidget {
  DataListHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        backgroundColor: Colors.deepOrange,
        onRefresh: () async {
          homeController.fetchAllRestaurant();
        },
        child: _buildList(context));
  }
}

Widget _buildList(BuildContext context) {
  final state = homeController.state;
  print("Controller state: $state");
  if (state == ResultState.error) {
    return LoadDataError(
      title: 'Problem Occurred',
      subtitle: homeController.message,
      bgColor: Colors.red,
      onTap: () {
        homeController.fetchAllRestaurant();
      },
    );
  } else if (state == ResultState.hasData) {
    final dataList = homeController.result;
    if (dataList.restaurants.isEmpty) {
      print("Data in dataList.restaurants: ${dataList.restaurants}");
      return const Center(
        child: Text('Tidak ada data ditemukan'),
      );
    }
    return ListView.builder(
      itemCount: dataList.restaurants.length,
      itemBuilder: (context, index) {
        print("Building CardRestaurant for index $index");
        return CardRestaurant(restaurant: dataList.restaurants[index]);
      },
    );
  } else {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}
