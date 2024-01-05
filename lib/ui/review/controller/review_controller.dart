import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/data/model/review_model.dart';
import 'package:submission3nanda/data/network/api_service.dart';
import 'package:submission3nanda/utils/widget/custom_progress_indicator.dart';

class ReviewController extends GetxController {
  final ApiService apiServices = ApiService(Client());
  final reviews = <Review>[].obs;
  final readTerms = false.obs;
  final readPrivacy = false.obs;
  final enableIntroButton = false.obs;
  var isDataLoading = false.obs;

  Future<void> createReview(
      {required String? id,
      required String name,
      required String review,
      required String date}) async {
    isDataLoading(true);
    CustomProgressIndicator.openLoadingDialog();
    try {
      final newReview = await apiServices.createReview(
          id: id, name: name, review: review, date: date);
      for (var review in newReview) {
        reviews.add(review);
        debugPrint('id:$id');
        debugPrint('newReview:$review');

      }
      Get.snackbar(
        Constants.success,
        '${Constants.successNewReviewCreate}$name',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      await CustomProgressIndicator.closeLoadingOverlay();
      isDataLoading(false);
    } catch (error, stackTrace) {
      debugPrint('${Constants.errorNewReviewCreate}$error');
      debugPrint('Stack trace: $stackTrace');
      await CustomProgressIndicator.closeLoadingOverlay();
      isDataLoading(false);
    }
  }

  void isIntroButtonDisabled() {
    if (readTerms.value && readPrivacy.value) {
      enableIntroButton.value = true;
    }
  }
}
