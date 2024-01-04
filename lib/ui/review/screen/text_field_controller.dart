import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldController extends GetxController {
  final nameController = TextEditingController();
  final reviewController = TextEditingController();
  final dateController = TextEditingController();
  final isButtonEnabled = false.obs;

  @override
  void onInit() {
    nameController.addListener(updateButtonState);
    reviewController.addListener(updateButtonState);
    dateController.addListener(updateButtonState);
    super.onInit();
  }

  void updateButtonState() {
    if (nameController.text.isEmpty ||
        reviewController.text.isEmpty ||
        dateController.text.isEmpty) {
      isButtonEnabled.value = false;
    } else {
      isButtonEnabled.value = true;
    }
  }
}
