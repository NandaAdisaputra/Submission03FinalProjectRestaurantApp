import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:submission3nanda/data/preferences/preferences_controller.dart';
import 'package:submission3nanda/ui/detail/controller/detail_controller.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/ui/home/controller/home_controller.dart';
import 'package:submission3nanda/ui/review/controller/review_controller.dart';
import 'package:submission3nanda/ui/themes/theme_controller.dart';
import 'package:submission3nanda/utils/resource_helper/themes/theme.dart';
import 'package:submission3nanda/utils/routes_helper/app_pages.dart';
import 'package:submission3nanda/utils/routes_helper/routes.dart';
import 'package:submission3nanda/utils/widget/custom_error_screen.dart';
import 'ui/themes/binding/initial_binding.dart';
import 'data/const/constants.dart';
import 'utils/widget/keyboards.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var apiService = ApiService();
  Get.put(HomeController(apiService: apiService));
  await Hive.openBox('settings');
  InitialBinding().dependencies();
  await GetStorage.init();
  Get.put(ReviewController());
  Get.put(PreferencesController());
  // Get.put(DetailRestaurantController());
  runApp(const MyApp());
}

final FavoriteController favoriteController =
    Get.put(FavoriteController(databaseHelper: DatabaseHelper()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    () => KeyboardUtil.hideKeyboard(context);
    final ThemeController _themeController = Get.put(ThemeController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.title,
      initialRoute: AppRoutes.NAVBAR,
      defaultTransition: Transition.fadeIn,
      getPages: AppPages.routes,
      themeMode: _themeController.themeStateFromHiveSettingBox,
      initialBinding: InitialBinding(),
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomErrorScreen(errorDetails: errorDetails);
        };
        final MediaQueryData mediaQueryData = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQueryData.copyWith(
            platformBrightness: Brightness.light,
            alwaysUse24HourFormat: true,
            textScaler: TextScaler.linear(1),
            boldText: false,
          ),
          child: ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget!),
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(450, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
              background: Container(color: Color(0xFFF5F5F5))),
        );
      },
      enableLog: kDebugMode,
      logWriterCallback: (String text, {bool isError = false}) {
        debugPrint("GetXLog: $text");
      },
      navigatorObservers: <NavigatorObserver>[
        GetObserver(),
      ],
    );
  } // CustomThemeData for Dark Theme
}
