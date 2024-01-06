import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const String imagePath = "assets/images";
const String jsonPath = "assets/animations";

class ImageAssets {
  static String imageNewPlaceHolder = "$imagePath/place_holder.jpg";
  static String imageLeading = "$imagePath/sendok_garpu.png";
  static String imageProfile = "$imagePath/profile.png";
  static String imageNoInternetAccess = "$imagePath/no_internet_access.png";
  static App app = App();
  static ImagesVector imagesVector = ImagesVector();
}

class App {
  late Dio client;
  bool restartRequired = false;
}

class ImagesVector {
  String get appIconPath => "assets/icons/app_icon.svg";

  String get appIconPngPath => "assets/icons/app_icon.png";

  String get appLogoPath => "assets/icons/app_logo.png";
}

class JsonAssets {
  static String search = "$jsonPath/search.json";
  static String splash = "$jsonPath/lottie_restaurant.json";
}

class IconAssets {
  static Icon nextIcon = const Icon(Icons.arrow_forward_ios);
  static Icon addIcon = const Icon(Icons.add, color: Colors.white);
}
