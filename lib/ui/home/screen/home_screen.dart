import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/main.dart';
import 'package:submission3nanda/ui/home/controller/home_controller.dart';
import 'package:submission3nanda/ui/home/screen/app_bar_home.dart';
import 'package:submission3nanda/ui/search/screen/search_restaurant.dart';
import 'package:submission3nanda/ui/themes/theme_controller.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';

var homeController = Get.put(HomeController(apiService: ApiService()));
var themeController = Get.put(ThemeController());

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(ImageAssets.imageLeading),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Tooltip(
                message: Constants.search,
                child: Material(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? CustomColors.Jet
                      : CustomColors.DarkOrange,
                  child: InkWell(
                    onTap: () => Get.to(
                      const SearchScreen(),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: InkWell(
                onTap: () => Get.to(
                  Get.bottomSheet(
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? CustomColors.Jet
                              : CustomColors.DarkOrange,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Get.isDarkMode
                                ? Icons.light_mode
                                : Icons.dark_mode),
                            title: Text(Get.isDarkMode
                                ? Constants.lightMode
                                : Constants.darkMode),
                            onTap: () {
                              favoriteController.changeAppTheme();
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
        body: AppBarHomeScreen());
  }
}
