import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/ui/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(apiService: ApiService(Client())), fenix: true);
  }
}
