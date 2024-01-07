import 'package:flutter/material.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'no_data_widget.dart';

class EmptyWidget extends StatelessWidget {
  final bool? visible;

  const EmptyWidget({Key? key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: visible == true ? 1.0 : 0.0,
      child: Container(
        alignment: FractionalOffset.center,
        child: const NoDataWidget(
            title: Constants.noData, subTitle: Constants.noDataFound),
      ),
    );
  }
}
