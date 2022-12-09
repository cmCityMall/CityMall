import 'dart:developer';

import 'package:citymall/controller/auth_controller.dart';
import 'package:citymall/controller/category_brand_controller.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/flash_sale_controller.dart';
import 'package:citymall/controller/recommend_screen_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/model/favourite_item.dart';
import 'package:citymall/model/hive_personal_address.dart';
import 'package:citymall/splashscreen/splash.dart';
import 'package:citymall/theme/dark_theme.dart';
import 'package:citymall/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constant/constant.dart';
import 'controller/cart_controller.dart';
import 'controller/week_promotion_controller.dart';
import 'rout_screens/rout_1.dart';
import 'searchscreen/search_controller.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Hive.initFlutter();
  Hive.registerAdapter<FavouriteItem>(FavouriteItemAdapter());
  Hive.registerAdapter<HivePersonalAddress>(HivePersonalAddressAdapter());
  await Hive.openBox<HivePersonalAddress>(addressBox);
  await Hive.openBox<FavouriteItem>(favouriteBox);
  await Hive.openBox<String>(searchHistoryBox);
  await Hive.openBox<List<String>>(addressKeyValueBox);
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
    Get.put(CartController());
    Get.put(SearchController());
    Get.put(CategoryBrandController());
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
