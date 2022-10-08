import 'package:citymall/controller/auth_controller.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/flash_sale_controller.dart';
import 'package:citymall/controller/recommend_screen_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/model/favourite_item.dart';
import 'package:citymall/splashscreen/splash.dart';
import 'package:citymall/theme/dark_theme.dart';
import 'package:citymall/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constant/constant.dart';
import 'controller/week_promotion_controller.dart';
import 'model/hive_purchase.dart';
import 'model/hive_purchase_item.dart';
import 'rout_screens/rout_1.dart';
//import 'package:get/get.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter<FavouriteItem>(FavouriteItemAdapter());
  Hive.registerAdapter<HivePurchase>(HivePurchaseAdapter());
  Hive.registerAdapter<HivePurchaseItem>(HivePurchaseItemAdapter());
  await Hive.openBox<FavouriteItem>(favouriteBox);
  await Hive.openBox<HivePurchase>(purchaseBox);
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
    Get.put(WeekPromotionControllerUser());
    Get.put(FlashSaleController());
    Get.put(RecommendScreenController());
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
