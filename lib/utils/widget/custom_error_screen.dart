import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomErrorScreen extends StatelessWidget {
  const CustomErrorScreen({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  final FlutterErrorDetails errorDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            Text(
              kDebugMode
                  ? errorDetails.summary.toString()
                  : "app.something.went.wrong".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kDebugMode ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              "app.try.later".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
