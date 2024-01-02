import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/base/database/database_controller.dart';
import 'package:submission3nanda/data/base/database/database_helper.dart';
import 'package:submission3nanda/utils/result_state.dart';
import 'package:submission3nanda/utils/widget/card_restaurant.dart';

class RestaurantFavoritePage extends StatefulWidget {
  static const favoritesTitle = 'Favorite Restaurants';

  const RestaurantFavoritePage({Key? key}) : super(key: key);

  @override
  State<RestaurantFavoritePage> createState() => _RestaurantFavoritePageState();
}

class _RestaurantFavoritePageState extends State<RestaurantFavoritePage> {
  final DatabaseController databaseController =
  Get.put(DatabaseController(databaseHelper: DatabaseHelper()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(RestaurantFavoritePage.favoritesTitle),
      ),
      body: GetBuilder<DatabaseController>(
        builder: (controller) {
          if (controller.state.value == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.state.value == ResultState.hasData) {
            return ListView.builder(
              itemCount: controller.favorites.length,
              itemBuilder: (context, index) {
                return CardRestaurant(restaurant: controller.favorites[index]);
              },
            );
          } else if (controller.state.value == ResultState.noData) {
            return Center(child: Text(controller.message.value));
          } else if (controller.state.value == ResultState.error) {
            return Center(child: Text(controller.message.value));
          } else {
            return const Center(child: Text('Please try again later'));
          }
        },
      ),
    );
  }
}