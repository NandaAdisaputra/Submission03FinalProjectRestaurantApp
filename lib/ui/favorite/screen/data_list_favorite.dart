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
    return Scaffold(
      body: Obx(() {
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState: _getCrossFadeState(),
          firstChild: const EmptyFavoriteWidget(visible: true),
          secondChild: _buildListView(),
        );
      }),
    );
  }

  CrossFadeState _getCrossFadeState() {
    return favoriteController.state.value == ResultState.noData
        ? CrossFadeState.showFirst
        : CrossFadeState.showSecond;
  }

  Widget _buildListView() {
    switch (favoriteController.state.value) {
      case ResultState.loading:
        return _buildLoadingWidget();
      case ResultState.hasData:
        return _buildDataWidget();
      case ResultState.noData:
        return const EmptyFavoriteWidget(visible: true);
      case ResultState.error:
        return _buildErrorWidget();
      default:
        return const Center(child: Text(Constants.tryAgainLater));
    }
  }

  Widget _buildLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildDataWidget() {
    return ListView.builder(
      itemCount: favoriteController.favorites.length,
      itemBuilder: (context, index) {
        return CardRestaurant(
          restaurant: favoriteController.favorites[index],
          isAccessedFromHomePage: false,
        );
      },
    );
  }

  Widget _buildErrorWidget() {
    return Expanded(
      child: LoadDataError(
        title: Constants.problemOccurred,
        subtitle: favoriteController.message.value,
        bgColor: Colors.red,
        onTap: () {
          favoriteController.getFavorites();
        },
      ),
    );
  }
}
