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

  Color getThemeColor(BuildContext context, Color darkColor, Color lightColor) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkColor
        : lightColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          color: getThemeColor(
              context, CustomColors.jetColor, CustomColors.selectiveYellow),
          child: Center(
            child: Text(
              Constants.title,
              style: TextStyle(
                color: getThemeColor(context, CustomColors.whiteColor,
                    CustomColors.scarletColor),
                fontSize: displayWidth(context) * FontSize.s008,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(Constants.deleteAllConfirmation),
                    content: const Text(Constants.areYouSureAllRemove),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          favoriteController.removeAllFavorite();
                          Navigator.of(context).pop();
                          favoriteController.update();
                        },
                        child: const Text(Constants.yesAction),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          favoriteController.update();
                        },
                        child: const Text(Constants.noAction),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.clear_all_outlined,
                color: CustomColors.whiteColor, size: 40),
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
              color: getThemeColor(context, CustomColors.middleYellow,
                  CustomColors.scarletColor),
            ),
          ),
          Center(
            child: Text(
              Constants.subTitle,
              style: TextStyle(
                color: getThemeColor(context, CustomColors.middleYellow,
                    CustomColors.scarletColor),
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
