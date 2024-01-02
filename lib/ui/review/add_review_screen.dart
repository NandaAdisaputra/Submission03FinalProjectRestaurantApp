import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/ui/review/review_controller.dart';
import '../../utils/resource_helper/sizes.dart';
import '../../utils/resource_helper/strings.dart';

var reviewRestaurantController = Get.put(ReviewController());

// ignore: must_be_immutableZ, must_be_immutable
class AddReviewScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final String? restaurantID;

  AddReviewScreen({super.key, this.restaurantID});

  void _createNewReview() {
    final name = nameController.text;
    final review = reviewController.text;
    final date = dateController.text;

    reviewRestaurantController.createReview(
        name: name, review: review, date: date, id: restaurantID);

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
          margin: EdgeInsets.fromLTRB(16, 8, 8, 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.deepOrange,
                  ),
                  labelText: AppStrings.reviewName,
                  hintText: AppStrings.reviewName),
            ),
            TextField(
              controller: reviewController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.description,
                    color: Colors.deepOrange,
                  ),
                  labelText: AppStrings.reviewDesc,
                  hintText: AppStrings.reviewDesc),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.date_range,
                    color: Colors.deepOrange,
                  ),
                  labelText: AppStrings.reviewDate,
                  hintText: AppStrings.reviewDate),
            ),
            AppSizes.hSizeBox20,
            Container(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _createNewReview,
                child: Text(AppStrings.addReview),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
