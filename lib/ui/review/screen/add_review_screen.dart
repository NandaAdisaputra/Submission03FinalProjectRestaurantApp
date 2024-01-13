import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/data/preferences/preference_helper.dart';
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
    Get.put(PreferencesController(preferencesHelper: PreferencesHelper()));

class AddReviewScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final String? restaurantID;
  final ReviewController reviewRestaurantController;
  final TextFieldController textFieldController =
  Get.put(TextFieldController());

  AddReviewScreen({
    Key? key,
    required this.reviewRestaurantController,
    this.restaurantID,
  }) : super(key: key);

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
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: _buildAppBarTitle(),
      elevation: 0,
      leading: _buildAppBarLeading(),
      actions: [
        _buildSearchIcon(context),
        _buildSettingsIcon(context),
      ],
    );
  }

  Text _buildAppBarTitle() {
    return const Text(
      Constants.reviewScreen,
      style: TextStyle(
        color: CustomColors.whiteColor,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildAppBarLeading() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Image.asset(ImageAssets.imageLeading),
    );
  }

  Widget _buildSearchIcon(BuildContext context) {
    return Padding(
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
                MaterialPageRoute(builder: (context) => const SearchScreen()),
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
    );
  }

  Widget _buildSettingsIcon(BuildContext context) {
    return Padding(
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
                    leading: _buildThemeIcon(),
                    title: _buildThemeText(),
                    onTap: () {
                      favoriteController.changeAppTheme();
                      Get.back();
                    },
                  ),
                  const Divider(color: Colors.black, height: 36),
                  _buildSwitchListTile(),
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
    );
  }

  Icon _buildThemeIcon() {
    return Icon(
      Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
    );
  }

  Text _buildThemeText() {
    return Text(
      Get.isDarkMode
          ? Constants.changeToLightMode
          : Constants.changeToDarkMode,
    );
  }

  SwitchListTile _buildSwitchListTile() {
    return SwitchListTile(
      title: const Text(Constants.enableDailyReminder),
      subtitle: const Text(Constants.enableOrDisableReminders),
      value: preferencesController.isRestaurantDailyActive.value,
      onChanged: (value) async {
        await schedulingController.scheduledRestaurant(value);
        preferencesController.enableDailyRestaurant(value);
      },
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              controller: textFieldController.nameController,
              labelText: AppStrings.reviewName,
              prefixIcon: Icons.person,
            ),
            _buildTextField(
              controller: textFieldController.reviewController,
              labelText: AppStrings.reviewDesc,
              prefixIcon: Icons.description,
            ),
            _buildTextField(
              controller: textFieldController.dateController,
              labelText: AppStrings.reviewDate,
              prefixIcon: Icons.date_range,
            ),
            AppSizes.hSizeBox20,
            Obx(() {
              return Container(
                margin: const EdgeInsets.only(left: 16, right: 16),
                child: ElevatedButton(
                  onPressed: textFieldController.isButtonEnabled.value
                      ? _createNewReview
                      : null,
                  child: Text(AppStrings.addReview),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.deepOrange,
        ),
        labelText: labelText,
        hintText: labelText,
      ),
    );
  }
}

