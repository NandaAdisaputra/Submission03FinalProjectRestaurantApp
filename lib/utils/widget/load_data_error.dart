import 'package:flutter/material.dart';
import 'package:submission3nanda/data/const/constants.dart';
import 'package:submission3nanda/utils/resource_helper/assets.dart';
import 'package:submission3nanda/utils/resource_helper/colors.dart';
import 'package:submission3nanda/utils/resource_helper/sizes.dart';
import 'package:submission3nanda/utils/widget/button_submit_widget.dart';

class LoadDataError extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color bgColor;
  final Function()? onTap;

  const LoadDataError({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageAssets.imageNoInternetAccess,
                      height: displayWidth(context) * 0.3,
                      width: displayWidth(context) * 0.3,
                    ),
                    const SizedBox(child: AppSizes.hSizeBox20),
                    Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.deepOrange,
                          fontSize: displayWidth(context) * 0.05,
                        ),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: subtitle,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: CustomColors.blackColor,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(child: AppSizes.hSizeBox20),
                    onTap != null
                        ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      padding: const EdgeInsets.all(16),
                      child: ButtonSubmitWidget(
                        width: double.infinity,
                        title: Constants.tryAgain,
                        bgColor: Colors.deepOrange,
                        textColor: Colors.white,
                        onPressed: onTap ?? () {},
                        loading: false,
                        iconData: null,
                      ),
                    )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
