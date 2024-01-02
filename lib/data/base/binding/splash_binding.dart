import 'package:get/get.dart';
import 'package:submission3nanda/ui/splash/splash_screen_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),fenix: true
    );
  }
}
