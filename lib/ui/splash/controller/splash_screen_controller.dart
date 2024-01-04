import 'dart:async';
import 'package:get/get.dart';
import 'package:submission3nanda/ui/navbar/screen/navbar_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(
      const Duration(seconds: 5),
      () => Get.off(const NavBarScreen()),
    );
  }
}
