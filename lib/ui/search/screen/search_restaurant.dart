import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/data/preferences/preference_helper.dart';
import 'package:submission3nanda/data/preferences/preferences_controller.dart';
import 'package:submission3nanda/ui/detail/screen/detail_restaurant_screen.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';
import 'package:submission3nanda/ui/scheduling/controller/sheduling_controller.dart';
import 'package:submission3nanda/ui/search/controller/search_controller.dart';
import 'package:submission3nanda/ui/themes/theme_controller.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/fonts.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';
import 'package:submission3nanda/utils/widget/empty_result_search_widget.dart';
import 'package:submission3nanda/utils/widget/load_data_error.dart';
import '../../../data/const/constants.dart';

final SearchRestaurantController searchController =
    Get.put(SearchRestaurantController());
final FavoriteController favoriteController =
    Get.put(FavoriteController(databaseHelper: DatabaseHelper()));
final SchedulingController schedulingController =
    Get.put(SchedulingController());
final themeController = Get.put(ThemeController());
final PreferencesController preferencesController =
    Get.put(PreferencesController(preferencesHelper: PreferencesHelper()));

class SearchScreen extends GetView<SearchRestaurantController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dynamicHeight = Get.height - MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: buildSearchContent(context, dynamicHeight),
        ),
      ),
    );
  }

  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        Constants.searchScreen,
        style: TextStyle(
          color: CustomColors.whiteColor,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),
      elevation: 0,
      backgroundColor:
          Get.isDarkMode ? CustomColors.jetColor : CustomColors.darkOrange,
      leading: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.asset(ImageAssets.imageLeading),
      ),
      actions: [
        buildSettingsIcon(context),
      ],
    );
  }

  Widget buildSettingsIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: InkWell(
        onTap: () => showSettingsBottomSheet(context),
        child: const Icon(
          Icons.settings,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }

  void showSettingsBottomSheet(BuildContext context) {
    Get.bottomSheet(
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
                  Get.find<FavoriteController>().changeAppTheme();
                  Get.back();
                },
              ),
              const Divider(color: Colors.black, height: 36),
              SwitchListTile(
                title: const Text(Constants.enableDailyReminder),
                subtitle: const Text(Constants.enableOrDisableReminders),
                value: preferencesController.isRestaurantDailyActive.value,
                onChanged: (value) async {
                  await schedulingController.scheduledRestaurant(value);
                  preferencesController.enableDailyRestaurant(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchContent(BuildContext context, double dynamicHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSearchTitles(context),
        const SizedBox(height: 30),
        buildSearchTextField(),
        Expanded(
          child: buildSearchResults(context),
        ),
      ],
    );
  }

  Widget buildSearchTitles(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            Constants.search,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? CustomColors.whiteColor
                  : CustomColors.darkOrange,
              fontSize: displayWidth(context) * 0.08,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Text(
            Constants.searchRestaurantYourLikes,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? CustomColors.whiteColor
                  : CustomColors.darkOrange,
              fontSize: displayWidth(context) * 0.05,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSearchTextField() {
    return TextField(
      onChanged: (text) {
        if (text.isNotEmpty) {
          Get.find<SearchRestaurantController>().queryRestaurantsSearch.text =
              text;
          Get.find<SearchRestaurantController>().getListRestaurant();
        } else {
          Get.find<SearchRestaurantController>().clearRestaurantData();
        }
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          Icons.search,
          color: Get.isDarkMode
              ? CustomColors.whiteColor
              : CustomColors.darkOrange,
        ),
        labelText: Constants.inputData,
        hintText: Constants.search,
      ),
    );
  }

  Widget buildSearchResults(BuildContext context) {
    return Obx(
      () {
        var searchController = Get.find<SearchRestaurantController>();
        if (searchController.isDataLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (searchController.hasError.value) {
          return buildErrorWidget(context);
        } else if (searchController.hasData.value) {
          return buildRestaurantList(context);
        } else {
          return buildNoDataView(context);
        }
      },
    );
  }

  Widget buildErrorWidget(BuildContext context) {
    var searchController = Get.find<SearchRestaurantController>();
    return Container(
        alignment: Alignment.topCenter,
        child: LoadDataError(
          title: Constants.problemOccurred,
          subtitle: searchController.message,
          bgColor: Colors.red,
          onTap: () {
            searchController.getListRestaurant();
          },
        ),
    );
  }

  Widget buildRestaurantList(BuildContext context) {
    var searchController = Get.find<SearchRestaurantController>();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: searchController.listBodyRestaurants.length,
      itemBuilder: (context, index) {
        var data = searchController.listBodyRestaurants[index];
        return buildRestaurantCard(context, data);
      },
    );
  }

  Widget buildRestaurantCard(BuildContext context, Map<String, dynamic> data) {
    return InkWell(
      onTap: () {
        Get.to(
          () => DetailRestaurantScreen(
            restaurantID: data[Constants.id],
            restaurantNAME: data[Constants.name],
            restaurantCITY: data[Constants.city],
            restaurantDESCRIPTION: data[Constants.description],
            restaurantPICTUREID: data[Constants.image],
            restaurantRATING: data[Constants.rating].toString(),
          ),
        )?.then((result) {
          Get.find<SearchRestaurantController>().clearRestaurantData();
        });
      },
      child: Card(
        margin: const EdgeInsets.only(
          left: 12,
          right: 8,
          top: 4,
          bottom: 12,
        ),
        color: Theme.of(context).brightness == Brightness.dark
            ? CustomColors.jetColor
            : CustomColors.lavenderColor,
        elevation: 8,
        child: Row(
          children: [
            buildRestaurantImageContainer(context, data),
            AppSizes.wSizeBox15,
            buildVerticalDivider(context),
            buildRestaurantInfoContainer(context, data),
          ],
        ),
      ),
    );
  }

  Widget buildRestaurantImageContainer(
      BuildContext context, Map<String, dynamic> data) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl:
                'https://restaurant-api.dicoding.dev/images/medium/${data[Constants.image]}',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: 80,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Widget buildVerticalDivider(BuildContext context) {
    return SizedBox(
      height: 50,
      child: VerticalDivider(
        color: Theme.of(context).brightness == Brightness.dark
            ? CustomColors.darkOrange
            : CustomColors.scarletColor,
      ),
    );
  }

  Widget buildRestaurantInfoContainer(
      BuildContext context, Map<String, dynamic> data) {
    return Flexible(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRestaurantNameRow(context, data),
          buildRestaurantLocationRow(context, data),
          AppSizes.hSizeBox15,
          buildRatingRow(context, data),
        ],
      ),
    );
  }

  Widget buildRestaurantNameRow(
      BuildContext context, Map<String, dynamic> data) {
    return Row(
      children: [
        Text(
          data[Constants.name],
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? CustomColors.orangePeel
                : CustomColors.darkOrange,
            fontSize: displayWidth(context) * FontSize.s0045,
            fontWeight: FontWeight.bold,
            fontFamily: Constants.helvetica,
          ),
        ),
      ],
    );
  }

  Widget buildRestaurantLocationRow(
      BuildContext context, Map<String, dynamic> data) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: Theme.of(context).brightness == Brightness.dark
              ? CustomColors.greenRyb
              : CustomColors.scarletColor,
        ),
        AppSizes.wSizeBox8,
        Text(
          data[Constants.city],
          style: TextStyle(
            fontSize: displayWidth(context) * FontSize.s0045,
            color: Theme.of(context).brightness == Brightness.dark
                ? CustomColors.greenRyb
                : CustomColors.scarletColor,
          ),
        ),
      ],
    );
  }

  Widget buildRatingRow(BuildContext context, Map<String, dynamic> data) {
    return Row(
      children: [
        RatingBar.builder(
          ignoreGestures: true,
          itemSize: displayWidth(context) * FontSize.s005,
          initialRating: data[Constants.rating].toDouble(),
          glowColor: Colors.transparent,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(
            horizontal: 4.0,
          ),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Theme.of(context).brightness == Brightness.dark
                ? CustomColors.goldColor
                : CustomColors.darkCornflowerBlue,
          ),
          onRatingUpdate: (rating) {},
        ),
        AppSizes.wSizeBox50,
      ],
    );
  }

  Widget buildNoDataView(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(JsonAssets.search),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.all(8),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: const EmptySearchWidget(visible: true),
          ),
        ],
      ),
    );
  }
}
