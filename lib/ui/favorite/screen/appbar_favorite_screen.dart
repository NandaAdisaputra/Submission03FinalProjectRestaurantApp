import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/ui/favorite/screen/data_list_favorite.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/fonts.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';

class AppBarFavoriteScreen extends StatelessWidget {
  final FavoriteController favoriteController =
      Get.put(FavoriteController(databaseHelper: DatabaseHelper()));

  AppBarFavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? CustomColors.Jet
              : CustomColors.SelectiveYellow,
          child: Center(
            child: Text(
              Constants.title,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? CustomColors.White
                    : CustomColors.Scarlet,
                fontSize: displayWidth(context) * FontSize.s008,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all_outlined,
                color: CustomColors.White, size: 40),
            onPressed: () {
              favoriteController.removeAllFavorite();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            height: 30,
            child: Divider(
              color: Theme.of(context).brightness == Brightness.dark
                  ? CustomColors.MiddleYellow
                  : CustomColors.Scarlet,
            ),
          ),
          Center(
            child: Text(
              Constants.subTitle,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? CustomColors.MiddleYellow
                    : CustomColors.Scarlet,
                fontSize: displayWidth(context) * FontSize.s0045,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AppSizes.hSizeBox30,
          Expanded(child: DataListFavorite())
        ],
      ),
    );
  }
}
