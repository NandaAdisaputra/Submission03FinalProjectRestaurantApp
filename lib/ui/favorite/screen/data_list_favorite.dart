import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/fonts.dart';
import 'package:submission3nanda/utils/result_state.dart';

import '../../../utils/resource_helper/sizes.dart';
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
                restaurant: favoriteController.favorites[index]);
          },
        );
      } else if (favoriteController.state.value == ResultState.noData) {
        return Center(
          child: Text(
            favoriteController.message.value,
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? CustomColors.orangePeel
                    : CustomColors.darkOrange,
                fontSize: displayWidth(context) * FontSize.s0045,
                fontWeight: FontWeight.bold,
                fontFamily: Constants.helvetica),
          ),
        );
      } else if (favoriteController.state.value == ResultState.error) {
        return Center(child: Text(favoriteController.message.value));
      } else {
        return const Center(child: Text(Constants.tryAgainLater));
      }
    });
  }
}
