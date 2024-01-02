import 'package:get/get.dart';
import 'package:submission3nanda/ui/themes/initial_controller.dart';
import 'package:submission3nanda/ui/themes/theme_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController(),fenix: true);
    Get.lazyPut<InitialController>(() => InitialController(),fenix: true);
  }
}