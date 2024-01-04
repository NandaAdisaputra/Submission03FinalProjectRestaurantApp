import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const String IMAGE_PATH = "assets/images";
const String JSON_PATH = "assets/animations";

class ImageAssets {
  static String imageNewPlaceHolder = "$IMAGE_PATH/place_holder.jpg";
  static String imageLeading = "$IMAGE_PATH/sendok_garpu.png";
  static String imageProfile = "$IMAGE_PATH/profile.png";
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
  static String search = "$JSON_PATH/search.json";
  static String splash = "$JSON_PATH/lottie_restaurant.json";
}

class IconAssets {
  static Icon nextIcon = const Icon(Icons.arrow_forward_ios);
  static Icon addIcon = const Icon(Icons.add, color: Colors.white);
}

