import 'package:flutter/material.dart';

class AppSizes {
  static const wSizeBox20 = SizedBox(
    width: 20,
  );
  static const wSizeBox30 = SizedBox(
    width: 30,
  );
  static const wSizeBox15 = SizedBox(
    width: 15,
  );
  static const wSizeBox10 = SizedBox(
    width: 10,
  );
  static const wSizeBox12 = SizedBox(
    width: 12,
  );
  static const wSizeBox8 = SizedBox(
    width: 8,
  );
  static const wSizeBox5 = SizedBox(
    width: 5,
  );
  static const wSizeBox50 = SizedBox(
    width: 50,
  );

  static const hSizeBox20 = SizedBox(
    height: 20,
  );
  static const hSizeBox30 = SizedBox(
    height: 30,
  );
  static const hSizeBox15 = SizedBox(
    height: 15,
  );
  static const hSizeBox8 = SizedBox(
    height: 8,
  );
  static const hSizeBox5 = SizedBox(
    height: 5,
  );
  static const hSizeBox12 = SizedBox(
    height: 12,
  );
  static const hSizeBox50 = SizedBox(
    height: 50,
  );
  static const hSizeBox10 = SizedBox(
    height: 10,
  );
}

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  return displaySize(context).width;
}
