import 'package:get/get.dart';
import 'package:submission3nanda/ui/review/controller/review_controller.dart';

class ReviewRestaurantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewController>(() => ReviewController(), fenix: true);
  }
}
