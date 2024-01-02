import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:submission3nanda/ui/splash/splash_screen_controller.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';

import '../../utils/resource_helper/colors.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? CustomColors.Jet
          : CustomColors.DarkOrange,
      body: Center(
        child: Lottie.asset(JsonAssets.splash, width: 250, height: 250),
      ),
    );
  }
}
