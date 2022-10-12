import 'package:citymall/authscreens/forgotpasswordscreen.dart';
import 'package:citymall/authscreens/signupscreen.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/auth_controller.dart';
import 'package:citymall/controller/checkcontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/onboardingscreen/onboarding.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());
  final CheckController ontapcontroller = Get.put(CheckController());

  TextFormField textFormField(String hint, String preffixIcon) {
    return TextFormField(
      style: TextStyle(
        fontFamily: TextFontFamily.SEN_REGULAR,
        fontSize: 12,
        color: themeController.isLightTheme.value
            ? ColorResources.black2
            : ColorResources.white,
      ),
      cursorColor: ColorResources.blue1,
      //maxLines: 2,
      decoration: InputDecoration(
        fillColor: themeController.isLightTheme.value
            ? ColorResources.white
            : ColorResources.black1,
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 10, right: 18, bottom: 10),
          child: SvgPicture.asset(preffixIcon),
        ),
        hintText: hint,
        hintStyle: TextStyle(
            fontFamily: TextFontFamily.SEN_REGULAR,
            fontSize: 16,
            color: themeController.isLightTheme.value
                ? ColorResources.black3.withOpacity(0.3)
                : ColorResources.grey1),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: themeController.isLightTheme.value
                  ? ColorResources.grey2
                  : ColorResources.grey3,
              width: 0.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: themeController.isLightTheme.value
                  ? ColorResources.grey2
                  : ColorResources.grey3,
              width: 0.5),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
              color: themeController.isLightTheme.value
                  ? ColorResources.grey2
                  : ColorResources.grey3,
              width: 0.5),
        ),
      ),
    );
  }

  Container container(String image, color) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: themeController.isLightTheme.value
            ? ColorResources.white
            : ColorResources.white.withOpacity(0.1),
        border: Border.all(
          color: themeController.isLightTheme.value
              ? ColorResources.black3.withOpacity(0.1)
              : ColorResources.black3.withOpacity(0.05),
        ),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SvgPicture.asset(image, color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /* appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: InkWell(
            onTap: () {
              Get.off(() => OnBoardingScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                color: ColorResources.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 13,
                    color: ColorResources.blue1.withOpacity(0.3),
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: ColorResources.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ), */
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black1,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              themeController.isLightTheme.value
                  ? Images.onboardbacklight
                  : Images.onboardbackdark,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Let’s Get Started!",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_BOLD,
                      fontSize: 28,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      "Login with Social.",
                      style: TextStyle(
                        fontFamily: TextFontFamily.SEN_REGULAR,
                        fontSize: 12,
                        color: themeController.isLightTheme.value
                            ? ColorResources.black3.withOpacity(0.6)
                            : ColorResources.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () => authController.googleSingIn(),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: themeController.isLightTheme.value
                                  ? ColorResources.white
                                  : ColorResources.white.withOpacity(0.1),
                              border: Border.all(
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black3.withOpacity(0.1)
                                    : ColorResources.black3.withOpacity(0.05),
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(Images.googleicon),
                            ),
                          )),
                      const SizedBox(width: 15),
                      container(
                          Images.appleicon,
                          themeController.isLightTheme.value
                              ? ColorResources.black
                              : ColorResources.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                Get.off(() => OnBoardingScreen());
              },
              child: Container(
                height: 60,
                width: 170,
                decoration: BoxDecoration(
                  color: ColorResources.blue1,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(30)),
                ),
                child: Center(
                  child: Text(
                    "Back",
                    style: TextStyle(
                        fontFamily: TextFontFamily.SEN_BOLD,
                        fontSize: 18,
                        color: ColorResources.white1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
