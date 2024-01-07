import 'package:flutter/material.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';

class NoDataWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const NoDataWidget({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 100,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  ImageAssets.imageNewPlaceHolder,
                  fit: BoxFit.fill,
                  // color: iconColor ?? MyColors.appPrimaryColor.withAlpha(200),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: CustomColors.darkOrange),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              subTitle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
