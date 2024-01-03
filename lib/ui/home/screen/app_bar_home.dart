import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/ui/home/controller/home_controller.dart';
import 'package:submission3nanda/ui/home/screen/data_list_home.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/fonts.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';

var homeController = Get.put(HomeController(apiService: ApiService()));

class AppBarHomeScreen extends GetView<HomeController> {

  const AppBarHomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Container(
              color: Theme.of(context).brightness==Brightness.dark
                  ? CustomColors.Jet
                  : CustomColors.SelectiveYellow,
              child: Center(
                child: Text(
                  Constants.title,
                  style: TextStyle(
                      color: Theme.of(context).brightness==Brightness.dark
                          ? CustomColors.White
                          : CustomColors.Scarlet,
                      fontSize: displayWidth(context) * FontSize.s008,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              height: 30,
              child: Divider(
                  color: Theme.of(context).brightness==Brightness.dark
                      ? CustomColors.MiddleYellow
                      : CustomColors.Scarlet)),
          Center(
            child: Text(
              Constants.subTitle,
              style: TextStyle(
                  color: Theme.of(context).brightness==Brightness.dark
                      ? CustomColors.MiddleYellow
                      : CustomColors.Scarlet,
                  fontSize: displayWidth(context) * FontSize.s0045,
                  fontWeight: FontWeight.bold),
            ),
          ),
          AppSizes.hSizeBox30,
          Expanded(child: DataListHomeScreen())
        ],
      ),
    );
  }
}
