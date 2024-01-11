import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/data/preferences/preferences_controller.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';
import 'package:submission3nanda/ui/home/controller/home_controller.dart';
import 'package:submission3nanda/ui/scheduling/controller/sheduling_controller.dart';
import 'package:submission3nanda/ui/search/screen/search_restaurant.dart';
import 'package:submission3nanda/ui/themes/theme_controller.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/result_state.dart';
import 'package:submission3nanda/utils/widget/card_restaurant.dart';
import 'package:submission3nanda/utils/widget/load_data_error.dart';

final homeController =
    Get.put(HomeController(apiService: ApiService(Client())));
final themeController = Get.put(ThemeController());
final PreferencesController preferencesController =
    Get.put(PreferencesController());
final SchedulingController schedulingController =
    Get.put(SchedulingController());
final FavoriteController favoriteController =
    Get.put(FavoriteController(databaseHelper: DatabaseHelper()));

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Constants.homeScreen,
          style: TextStyle(
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
                            Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
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
                          subtitle:
                              const Text(Constants.enableOrDisableReminders),
                          value: preferencesController.isRestaurantDailyActive.value,
                          onChanged: (value) async {
                            await schedulingController
                                .scheduledRestaurant(value);
                            preferencesController.enableDailyRestaurant(value);
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
      body: RefreshIndicator(
        backgroundColor: Colors.deepOrange,
        onRefresh: () async {
          homeController.fetchAllRestaurant();
        },
        child: _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Obx(
      () {
        final state = homeController.state;
        if (state == ResultState.error) {
          return LoadDataError(
            title: Constants.problemOccurred,
            subtitle: homeController.message,
            bgColor: Colors.red,
            onTap: () {
              homeController.fetchAllRestaurant();
            },
          );
        } else if (state == ResultState.hasData) {
          final dataList = homeController.result;
          if (dataList.restaurants.isEmpty) {
            return const Center(
              child: Text(Constants.noDataFound),
            );
          }
          return ListView.builder(
            itemCount: dataList.restaurants.length,
            itemBuilder: (context, index) {
              return CardRestaurant(
                  restaurant: dataList.restaurants[index],
                  isAccessedFromHomePage: false);
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrange,
            ),
          );
        }
      },
    );
  }
}
