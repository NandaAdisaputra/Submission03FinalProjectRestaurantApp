import 'package:get/get.dart';

class NavBarController extends GetxController {
  final tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    updateUI();
  }

  void updateUI() => update();
}
