import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/ui/review/controller/review_controller.dart';
import 'package:submission3nanda/ui/review/screen/text_field_controller.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';
import 'package:submission3nanda/utils/resource_helper/strings.dart';

var reviewRestaurantController = Get.put(ReviewController());

class AddReviewScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final String? restaurantID;
  final ReviewController reviewRestaurantController;
  final TextFieldController textFieldController =
      Get.put(TextFieldController());

  AddReviewScreen(
      {Key? key, required this.reviewRestaurantController, this.restaurantID})
      : super(key: key);

  void _createNewReview() {
    final name = nameController.text;
    final review = reviewController.text;
    final date = dateController.text;

    reviewRestaurantController.createReview(
      name: name,
      review: review,
      date: date,
      id: restaurantID,
    );

    nameController.clear();
    reviewController.clear();
    dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.reviewManagement),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: textFieldController.nameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.deepOrange,
                  ),
                  labelText: AppStrings.reviewName,
                  hintText: AppStrings.reviewName,
                ),
              ),
              TextField(
                controller: textFieldController.reviewController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.description,
                    color: Colors.deepOrange,
                  ),
                  labelText: AppStrings.reviewDesc,
                  hintText: AppStrings.reviewDesc,
                ),
              ),
              TextField(
                controller: textFieldController.dateController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.date_range,
                    color: Colors.deepOrange,
                  ),
                  labelText: AppStrings.reviewDate,
                  hintText: AppStrings.reviewDate,
                ),
              ),
              AppSizes.hSizeBox20,
              Obx(() {
                return ElevatedButton(
                  onPressed: textFieldController.isButtonEnabled.value
                      ? () {
                          _createNewReview;
                        }
                      : null,
                  child: Text(AppStrings.addReview),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
