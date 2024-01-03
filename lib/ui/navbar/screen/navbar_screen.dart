import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/ui/favorite/screen/favorite_screen.dart';
import 'package:submission3nanda/ui/home/screen/home_screen.dart';
import 'package:submission3nanda/ui/navbar/controller/navbar_controller.dart';
import 'package:submission3nanda/ui/profile/screen/profile_user_screen.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  final controller = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(builder: (context) {
      return Scaffold(
        body: IndexedStack(
          index: controller.tabIndex,
          children:  [
            HomeScreen(),
            FavoriteScreen(),
            ProfileUserScreen()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: CustomColors.Scarlet,
          unselectedItemColor: CustomColors.DarkOrange,
          currentIndex: controller.tabIndex,
          onTap: controller.changeTabIndex,
          items: [
            _bottomBarItem(Icons.home, Constants.home),
            _bottomBarItem(Icons.favorite, Constants.favorite),
            _bottomBarItem(Icons.person, Constants.profileUsers)
          ],
        ),
      );
    });
  }
}

_bottomBarItem(IconData icon, String label) {
  return BottomNavigationBarItem(icon: Icon(icon), label: label);
}