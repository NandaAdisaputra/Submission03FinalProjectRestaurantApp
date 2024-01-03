import 'package:get/get.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/ui/detail/controller/detail_controller.dart';

class DetailRestaurantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailRestaurantController>(
      () => DetailRestaurantController(),fenix: true
    );
  }
}
