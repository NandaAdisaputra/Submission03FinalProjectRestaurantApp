import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/data/preferences/preferences_controller.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';
import 'package:submission3nanda/ui/review/controller/review_controller.dart';
import 'package:submission3nanda/ui/review/screen/text_field_controller.dart';
import 'package:submission3nanda/ui/scheduling/controller/sheduling_controller.dart';
import 'package:submission3nanda/ui/search/screen/search_restaurant.dart';
import 'package:submission3nanda/ui/themes/theme_controller.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';
import 'package:submission3nanda/utils/resource_helper/strings.dart';

var reviewRestaurantController = Get.put(ReviewController());
final FavoriteController favoriteController =
    Get.put(FavoriteController(databaseHelper: DatabaseHelper()));
final SchedulingController schedulingController =
    Get.put(SchedulingController());
final themeController = Get.put(ThemeController());
final PreferencesController preferencesController =
    Get.put(PreferencesController());

class AddReviewScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final String? restaurantID;
  final ReviewController reviewRestaurantController;
  final TextFieldController textFieldController =
      Get.put(TextFieldController());

  AddReviewScreen(
      {Key? key, required this.reviewRestaurantController, this.restaurantID})
      : super(key: key);

  void _createNewReview() {
    final name = nameController.text;
    final review = reviewController.text;
    final date = dateController.text;

    reviewRestaurantController.createReview(
      name: name,
      review: review,
      date: date,
      id: restaurantID,
    );

    nameController.clear();
    reviewController.clear();
    dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.reviewScreen,style: TextStyle(
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
                          value: schedulingController
                              .isRestaurantDailyActive.value,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: textFieldController.nameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.deepOrange,
                  ),
                  labelText: AppStrings.reviewName,
                  hintText: AppStrings.reviewName,
                ),
              ),
              TextField(
                controller: textFieldController.reviewController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.description,
                    color: Colors.deepOrange,
                  ),
                  labelText: AppStrings.reviewDesc,
                  hintText: AppStrings.reviewDesc,
                ),
              ),
              TextField(
                controller: textFieldController.dateController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.date_range,
                    color: Colors.deepOrange,
                  ),
                  labelText: AppStrings.reviewDate,
                  hintText: AppStrings.reviewDate,
                ),
              ),
              AppSizes.hSizeBox20,
              Obx(() {
                return Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  child: ElevatedButton(
                    onPressed: textFieldController.isButtonEnabled.value
                        ? () {
                            _createNewReview;
                          }
                        : null,
                    child: Text(AppStrings.addReview),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
