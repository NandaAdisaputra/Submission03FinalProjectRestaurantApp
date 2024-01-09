import 'package:flutter/material.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/fonts.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';

class NoDataWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const NoDataWidget({Key? key, required this.title, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 250,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  ImageAssets.imageNewPlaceHolder,
                  fit: BoxFit.cover,
                  // color: iconColor ?? MyColors.appPrimaryColor.withAlpha(200),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? CustomColors.orangePeel
                      : CustomColors.darkOrange,
                  fontSize: displayWidth(context) * FontSize.s006,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constants.helvetica),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? CustomColors.orangePeel
                      : CustomColors.darkOrange,
                  fontSize: displayWidth(context) * FontSize.s0045,
                  fontWeight: FontWeight.bold,
                  fontFamily: Constants.helvetica),
            ),
          ),
        ],
      ),
    );
  }
}
