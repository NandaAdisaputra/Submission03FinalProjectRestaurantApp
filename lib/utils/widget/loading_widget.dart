import 'package:flutter/material.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';

class LoadingWidget extends StatelessWidget {
  final bool? visible;

  const LoadingWidget({Key? key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: visible == true ? 1.0 : 0.0,
      child: Container(
        alignment: FractionalOffset.center,
        child: const CircularProgressIndicator(
            backgroundColor: CustomColors.darkOrange),
      ),
    );
  }
}
