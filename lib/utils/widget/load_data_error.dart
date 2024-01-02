import 'package:flutter/material.dart';
import 'package:submission3nanda/utils/widget/button_submit_widget.dart';

class LoadDataError extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color bgColor;
  final Function()? onTap;

  const LoadDataError(
      {Key? key,
        required this.title,
        required this.subtitle,
        required this.bgColor,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor: bgColor,
                child: const Text(':('),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            Text.rich(
              TextSpan(
                text: subtitle,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            onTap != null
                ? ButtonSubmitWidget(
              width: double.infinity,
              title: "Coba Lagi",
              bgColor: Colors.deepOrange,
              textColor: Colors.white,
              onPressed: onTap ?? () {},
              loading: false,
              iconData: null,
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}