import 'package:flutter/material.dart';
import 'package:submission3nanda/data/const/constants.dart';

GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, {Object? arguments}) {
    navigatorKey!.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static back() => navigatorKey?.currentState?.pop();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: Constants.title,
      debugShowCheckedModeBanner: false,
    );
  }
}
