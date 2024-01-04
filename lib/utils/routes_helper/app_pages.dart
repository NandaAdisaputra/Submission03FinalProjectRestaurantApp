import 'package:get/get.dart';
import 'package:submission3nanda/ui/home/binding/home_binding.dart';
import 'package:submission3nanda/ui/navbar/binding/navbar_binding.dart';
import 'package:submission3nanda/ui/review/binding/review_binding.dart';
import 'package:submission3nanda/ui/review/screen/add_field_review_screen.dart';
import 'package:submission3nanda/ui/search/binding/search_binding.dart';
import 'package:submission3nanda/ui/splash/binding/splash_binding.dart';
import 'package:submission3nanda/ui/home/screen/home_screen.dart';
import 'package:submission3nanda/ui/navbar/screen/navbar_screen.dart';
import 'package:submission3nanda/ui/search/screen/search_restaurant.dart';
import 'package:submission3nanda/ui/splash/screen/splash_screen.dart';
import 'package:submission3nanda/utils/routes_helper/routes.dart';

class AppPages {
  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<SplashScreen>(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      preventDuplicates: true,
    ),
    GetPage<HomeScreen>(
      name: AppRoutes.HOME,
      page: () =>  HomeScreen(),
      transition: Transition.fadeIn,
      binding: HomeBinding(),
      preventDuplicates: true,
    ),
    GetPage<SearchScreen>(
      name: AppRoutes.SEARCH,
      page: () =>  SearchScreen(),
      transition: Transition.fadeIn,
      binding: SearchBinding(),
      preventDuplicates: true,
    ),
    GetPage<AddReviewFormScreen>(
      name: AppRoutes.REVIEW,
      page: () => AddReviewFormScreen(),
      transition: Transition.fadeIn,
      binding: ReviewRestaurantBinding(),
      preventDuplicates: true,
    ),
    GetPage<NavBarScreen>(
      name: AppRoutes.NAVBAR,
      page: () => const NavBarScreen(),
      transition: Transition.fadeIn,
      binding: NavBarBinding(),
      preventDuplicates: true,
    ),
  ];
}