import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/onboardingscreen/onboarding.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    print("height#####${MediaQuery.of(context).size.height}");
    print("width#####${MediaQuery.of(context).size.width}");
    return Scaffold(
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black1,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: themeController.isLightTheme.value
                ? AssetImage(Images.splashlight)
                : AssetImage(Images.splashdark),
            fit: BoxFit.fill,
          ),
          color: themeController.isLightTheme.value
              ? ColorResources.white
              : ColorResources.black1,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                "Get Everything\nat Your \nDoorstep",
                style: TextStyle(
                  color: themeController.isLightTheme.value
                      ? ColorResources.black2
                      : ColorResources.white,
                  fontSize: 33,
                  fontWeight: FontWeight.w800,
                  fontFamily: TextFontFamily.SEN_REGULAR,
                ),
              ),
              SizedBox(height: 30),
              FloatingActionButton(
                onPressed: () {
                  Get.off(OnBoardingScreen());
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: ColorResources.blue,
                child: Icon(
                  Icons.arrow_forward,
                  color: ColorResources.white,
                ),
                elevation: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
