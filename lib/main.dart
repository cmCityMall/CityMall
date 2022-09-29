import 'package:citymall/controller/auth_controller.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/splashscreen/splash.dart';
import 'package:citymall/theme/dark_theme.dart';
import 'package:citymall/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'rout_screens/rout_1.dart';
//import 'package:get/get.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Get.put(AuthController());
  Get.put(DBDataController());
  runApp(CityMall());
}

class CityMall extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  CityMall({Key? key}) : super(key: key);

  //final navigatorkey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: themeController.isLightTheme.value ? light : dark,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const RedirectWidget(),
    );
  }
}

class RedirectWidget extends StatelessWidget {
  const RedirectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Obx(() => authController.currentUser.value!.status! > 0
        ? NavigationBarBottom()
        : SplashScreen());
  }
}
