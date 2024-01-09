import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';
import 'package:submission3nanda/utils/result_state.dart';
import 'package:submission3nanda/utils/widget/empty_result_favorite_widget.dart';
import 'package:submission3nanda/utils/widget/load_data_error.dart';

import '../../../utils/widget/card_restaurant.dart';

class DataListFavorite extends StatelessWidget {
  final FavoriteController favoriteController =
      Get.put(FavoriteController(databaseHelper: DatabaseHelper()));

  DataListFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (favoriteController.state.value == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (favoriteController.state.value == ResultState.hasData) {
        return ListView.builder(
          itemCount: favoriteController.favorites.length,
          itemBuilder: (context, index) {
            return CardRestaurant(
                restaurant: favoriteController.favorites[index], isAccessedFromHomePage: true);
          },
        );
      } else if (favoriteController.state.value == ResultState.noData) {
        return const EmptyFavoriteWidget(visible: true);
      } else if (favoriteController.state.value == ResultState.error) {
        return LoadDataError(
          title: Constants.problemOccurred,
          subtitle: favoriteController.message.value,
          bgColor: Colors.red,
          onTap: () {
            favoriteController.getFavorites();
          },
        );
      } else {
        return const Center(child: Text(Constants.tryAgainLater));
      }
    });
  }
}