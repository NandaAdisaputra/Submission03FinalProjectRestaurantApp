import 'package:another_flushbar/flushbar.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:submission3nanda/utils/resource_helper/colors.dart";

class SnackbarToastUtil {
  static const Duration _snackBarDuration = Duration(seconds: 8);
  static SnackbarController? currentSnackBar;

  static void showSnackBar({
    required String title,
    required String message,
    Duration? duration,
  }) {
    Flushbar<dynamic>(
      flushbarPosition: FlushbarPosition.TOP,
      title: title,
      message: message,
      duration: _snackBarDuration,
      backgroundColor: CustomColors.darkOrange,
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.white,
      ),
      boxShadows: const <BoxShadow>[
        BoxShadow(
          color: CustomColors.scarletColor,
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        ),
      ],
    ).show(Get.context!);
  }

  static void showErrorSnackBar({
    String? title,
    String? message,
    Duration? duration,
  }) {
    if (Get.context == null) {
      return;
    }

    Flushbar<dynamic>(
      flushbarPosition: FlushbarPosition.TOP,
      title: title?.trim().isNotEmpty == true
          ? title
          : "app.something.went.wrong".tr,
      message:
          message?.trim().isNotEmpty == true ? message : "app.try.later".tr,
      duration: _snackBarDuration,
      backgroundColor: CustomColors.scarletColor,
      icon: const Icon(
        Icons.error_outline_outlined,
        size: 28.0,
        color: Colors.white,
      ),
      boxShadows: const <BoxShadow>[
        BoxShadow(
          color: CustomColors.scarletColor,
          offset: Offset(0.0, 2.0),
          blurRadius: 3.0,
        ),
      ],
      borderRadius: BorderRadius.circular(8),
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    ).show(Get.context!);
  }

  static void showDialog({
    String title = "Alert",
    EdgeInsetsGeometry? titlePadding,
    TextStyle? titleStyle,
    Widget? content,
    EdgeInsetsGeometry? contentPadding,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    VoidCallback? onCustom,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? textConfirm,
    String? textCancel,
    String? textCustom,
    Widget? confirm,
    Widget? cancel,
    Widget? custom,
    Color? backgroundColor,
    bool barrierDismissible = true,
    Color? buttonColor,
    String middleText = "Dialog made in 3 lines of code",
    TextStyle? middleTextStyle,
    double radius = 20.0,
    List<Widget>? actions,
    // ignore: deprecated_member_use
    WillPopCallback? onWillPop,
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    Get.defaultDialog(
      title: title,
      titlePadding: titlePadding,
      titleStyle: titleStyle,
      content: content,
      contentPadding: contentPadding,
      onConfirm: onConfirm,
      onCancel: onCancel,
      onCustom: onCustom,
      cancelTextColor: cancelTextColor,
      confirmTextColor: confirmTextColor,
      textConfirm: textConfirm,
      textCancel: textCancel,
      textCustom: textCustom,
      confirm: confirm,
      cancel: cancel,
      custom: custom,
      backgroundColor: backgroundColor,
      barrierDismissible: barrierDismissible,
      buttonColor: buttonColor,
      middleText: middleText,
      middleTextStyle: middleTextStyle,
      radius: radius,
      actions: actions,
      onWillPop: onWillPop,
      navigatorKey: navigatorKey,
    );
  }

  static void showBottomSheet(
      {BuildContext? context, required List<Widget> widgetList}) {
    showModalBottomSheet(
      context: context ?? Get.context!,
      builder: (BuildContext bc) {
        return SafeArea(
          child: SizedBox(
            child: Wrap(
              children: widgetList,
            ),
          ),
        );
      },
    );
  }
}
