import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';

class CustomProgressIndicator {
  static bool isShowing = false;

  static Future<void> closeLoadingOverlay() async {
    if (CustomProgressIndicator.isShowing) {
      Navigator.of(Get.overlayContext ?? Get.context!).pop();
      CustomProgressIndicator.isShowing = false;
      await Future<dynamic>.delayed(const Duration(microseconds: 200));
    }
  }

  static Future<void> openLoadingDialog() async {
    if (!CustomProgressIndicator.isShowing && !Get.isSnackbarOpen) {
      CustomProgressIndicator.isShowing = true;
      showDialog(
        context: Get.overlayContext ?? Get.context!,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (_) => const LoadingOverlay(),
      );
    }
  }
}

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  LoadingOverlayState createState() => LoadingOverlayState();
}

class LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200000),
      lowerBound: 10,
      upperBound: 20,
      vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: SizedBox(
          height: Get.context?.height ?? Get.height,
          width: Get.context?.width ?? Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RotationTransition(
                turns:
                    Tween<double>(begin: 0.0, end: 10.0).animate(_controller),
                child: Center(
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints boxConstraints) {
                      if (Get.context?.isTablet ?? Get.width >= 700) {
                        return SizedBox(
                          height: 90,
                          width: 90,
                          child: Image.asset(ImageAssets.imageLeading),
                        );
                      } else {
                        return SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset(ImageAssets.imageLeading));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
