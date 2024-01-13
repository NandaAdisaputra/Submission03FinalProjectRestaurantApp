import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/model/detail_restaurant.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/ui/review/controller/review_controller.dart';
import 'package:submission3nanda/utils/result_state.dart';

class DetailRestaurantController extends GetxController {
  final reviewController = Get.find<ReviewController>();

  final Rx<DetailRestaurant> _listRestaurant = DetailRestaurant().obs;
  final Rx<ResultState> _state = ResultState.loading.obs;
  final RxString _message = ''.obs;

  RxString get message => _message;

  Rx<DetailRestaurant> get result => _listRestaurant;

  ResultState get state => _state.value;

  Future<dynamic> getListRestaurant(String? idRestaurant) async {
    try {
      _state(ResultState.loading); // Corrected
      update();
      final restaurant =
      await ApiService(Client()).detailRestaurant(idRestaurant);
      if (restaurant.restaurant == null) {
        _state(ResultState.noData); // Corrected
        update();
        _message(Constants.noDataFound);
      } else {
        _state(ResultState.hasData); // Corrected
        _listRestaurant(restaurant); // Corrected
        update();
      }
    } catch (e) {
      _state(ResultState.error); // Corrected
      _message(Constants.checkYourInternetConnection);
    } finally {
      update();
    }
  }
}