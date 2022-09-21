import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: must_be_immutable
class NavigatorPage extends StatefulWidget {
  var navigatorKey;
  Widget child;

  @override
  _NavigatorPageState createState() => _NavigatorPageState();

  NavigatorPage({required this.navigatorKey, required this.child});
}

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(widget.navigatorKey),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          maintainState: false,
          fullscreenDialog: false,
          builder: (context) {
            return Scaffold(
              body: widget.child,
            );
          },
        );
      }, //
    );
  }
}
