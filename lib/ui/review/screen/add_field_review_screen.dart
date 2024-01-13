import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/ui/review/controller/review_controller.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';
import 'package:submission3nanda/utils/resource_helper/strings.dart';
import 'text_field_controller.dart';

class AddReviewFormScreen extends StatelessWidget {
  final ReviewController reviewController = Get.find();
  final TextFieldController textFieldController =
      Get.put(TextFieldController());
  final String? restaurantID;

  AddReviewFormScreen({Key? key, this.restaurantID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        AppStrings.addReview,
        style: const TextStyle(
            color: Colors.white, fontFamily: Constants.helvetica),
      ),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? CustomColors.jetColor
          : CustomColors.darkOrange,
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        buildTextField(
          controller: textFieldController.nameController,
          labelText: AppStrings.reviewName,
          prefixIcon: Icons.person,
          context: context,
        ),
        buildTextField(
          controller: textFieldController.reviewController,
          labelText: AppStrings.reviewDesc,
          prefixIcon: Icons.description,
          context: context,
        ),
        buildTextField(
          controller: textFieldController.dateController,
          labelText: AppStrings.reviewDate,
          prefixIcon: Icons.date_range,
          context: context,
        ),
        AppSizes.hSizeBox20,
        buildElevatedButton(context),
      ],
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: Icon(
            prefixIcon,
            color: Theme.of(context).brightness == Brightness.dark
                ? CustomColors.whiteColor
                : CustomColors.darkOrange,
          ),
          labelText: labelText,
          hintText: labelText,
        ),
      ),
    );
  }

  Widget buildElevatedButton(BuildContext context) {
    return Obx(() {
      final isButtonEnabled = textFieldController.isButtonEnabled.value;
      return SizedBox(
        height: 45,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? CustomColors.jetColor
                  : CustomColors.darkOrange,
            ),
            onPressed: isButtonEnabled
                ? () {
                    createNewReview();
                    clearTextFields();
                  }
                : null,
            child: Text(
              AppStrings.addReview,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? CustomColors.whiteColor
                    : CustomColors.whiteColor,
                fontFamily: Constants.helvetica,
              ),
            ),
          ),
        ),
      );
    });
  }

  void createNewReview() {
    final name = textFieldController.nameController.text;
    final review = textFieldController.reviewController.text;
    final date = textFieldController.dateController.text;

    reviewController.createReview(
        name: name, review: review, date: date, id: restaurantID);
  }

  void clearTextFields() {
    textFieldController.nameController.clear();
    textFieldController.reviewController.clear();
    textFieldController.dateController.clear();
  }
}
