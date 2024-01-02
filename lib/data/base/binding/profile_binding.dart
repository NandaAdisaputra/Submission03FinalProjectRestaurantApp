import 'package:get/get.dart';
import 'package:submission3nanda/ui/profile/profile_user_controller.dart';
class ProfileUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileUserController>(
      () => ProfileUserController(),fenix: true
    );
  }
}
