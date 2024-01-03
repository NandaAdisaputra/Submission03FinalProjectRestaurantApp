import 'package:get/get.dart';
import 'package:submission3nanda/data/database/database_helper.dart';
import 'package:submission3nanda/ui/favorite/controller/favorite_controller.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(
        () => FavoriteController(databaseHelper: DatabaseHelper()),
        fenix: true);
  }
}
