import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/data/preferences/preferences_controller.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';
import 'package:submission3nanda/ui/profile/screen/component/sliver_delegate.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/ui/profile/controller/profile_user_controller.dart';
import 'package:submission3nanda/ui/scheduling/controller/sheduling_controller.dart';
import 'package:submission3nanda/ui/search/screen/search_restaurant.dart';
import 'package:submission3nanda/ui/themes/theme_controller.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/resource_helper/colors.dart';
import '../../../utils/resource_helper/fonts.dart';

var profileUsers = Get.put(ProfileUserController());
final FavoriteController favoriteController =
    Get.put(FavoriteController(databaseHelper: DatabaseHelper()));
final SchedulingController schedulingController =
    Get.put(SchedulingController());
final themeController = Get.put(ThemeController());
final PreferencesController preferencesController =
    Get.put(PreferencesController());

class ProfileUserScreen extends GetView<ProfileUserController> {
  const ProfileUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.profileScreen, style: TextStyle(
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
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              minHeight: 50,
              maxHeight: 50,
              child: Container(
                color: CustomColors.darkOrange,
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Text(
                    Constants.detailProfile,
                    style: TextStyle(
                        color: CustomColors.whiteColor,
                        fontFamily: Constants.helvetica,
                        fontSize: displayWidth(context) * FontSize.s005),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 24),
              child: Image(
                  image: AssetImage('assets/images/profile.png'),
                  width: 150,
                  height: 150),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const SliverToBoxAdapter(
            child: Center(
              child: Text(
                Constants.nameProfile,
                style: TextStyle(
                    color: CustomColors.orangePeel,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                Constants.descriptionProfile,
                maxLines: 10,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: CustomColors.orangePeel),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 40,
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? CustomColors.jetColor
                              : CustomColors.darkOrange),
                  onPressed: () {
                    launchUrlStart(url: Constants.urlLinkedin);
                  },
                  child: Text(
                    Constants.visitLinkedin,
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? CustomColors.whiteColor
                            : CustomColors.whiteColor,
                        fontFamily: Constants.helvetica,
                        fontSize: displayWidth(context) * FontSize.s005),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
