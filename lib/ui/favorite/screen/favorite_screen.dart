import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/preferences/preference_helper.dart';
import 'package:submission3nanda/data/preferences/preferences_controller.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/ui/favorite/screen/appbar_favorite_screen.dart';
import 'package:submission3nanda/ui/scheduling/controller/sheduling_controller.dart';
import 'package:submission3nanda/ui/search/screen/search_restaurant.dart';
import 'package:submission3nanda/ui/themes/theme_controller.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';

class FavoriteScreen extends StatefulWidget {
  static const favoritesTitle = Constants.titleFavorite;

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FavoriteController favoriteController =
      Get.put(FavoriteController(databaseHelper: DatabaseHelper()));
  final SchedulingController schedulingController =
      Get.put(SchedulingController());
  final themeController = Get.put(ThemeController());
  final PreferencesController preferencesController =
      Get.put(PreferencesController(preferencesHelper: PreferencesHelper()));

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            title: const Text(Constants.favoriteScreen,style: TextStyle(
                color: CustomColors.whiteColor, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
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
                        ? CustomColors.jetColor
                        : CustomColors.darkOrange,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen()),
                        );
                      },
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
                  onTap: () => Get.bottomSheet(
                    Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? CustomColors.jetColor
                              : CustomColors.darkOrange,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Get.isDarkMode
                                    ? Icons.light_mode
                                    : Icons.dark_mode,
                              ),
                              title: Text(
                                Get.isDarkMode
                                    ? Constants.changeToLightMode
                                    : Constants.changeToDarkMode,
                              ),
                              onTap: () {
                                favoriteController.changeAppTheme();
                                Get.back();
                              },
                            ),
                            const Divider(color: Colors.black, height: 36),
                            SwitchListTile(
                              title: const Text(Constants.enableDailyReminder),
                              subtitle: const Text(
                                  Constants.enableOrDisableReminders),
                              value: preferencesController.isRestaurantDailyActive.value,
                              onChanged: (value) async {
                                await schedulingController
                                    .scheduledRestaurant(value);
                                preferencesController
                                    .enableDailyRestaurant(value);
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
          body: AppBarFavoriteScreen());
    });
  }
}
