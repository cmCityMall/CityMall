import 'package:citymall/authscreens/loginscreen.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/checkcontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/onboardingscreen/onboarding.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

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
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        prefixIcon: Padding(
          padding: EdgeInsets.only(top: 10, right: 18, bottom: 10),
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black1,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 50),
              InkWell(
                onTap: () {
                  Get.off(OnBoardingScreen());
                },
                child: Container(
                  height: 35,
                  width: 35,
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
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let???s Get Started!",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_BOLD,
                      fontSize: 28,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white,
                    ),
                  ),
                  Text(
                    "Sign up with Social of fill the form to continue.",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_REGULAR,
                      fontSize: 12,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black3.withOpacity(0.6)
                          : ColorResources.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  textFormField(
                    "Name",
                    Images.user,
                  ),
                  SizedBox(height: 12),
                  textFormField(
                    "Phone",
                    Images.phone,
                  ),
                  SizedBox(height: 12),
                  textFormField(
                    "Email",
                    Images.mail,
                  ),
                  SizedBox(height: 12),
                  textFormField(
                    "Password",
                    Images.password,
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Obx(
                        () => InkWell(
                          onTap: () {
                            ontapcontroller.check1.value =
                                !ontapcontroller.check1.value;
                          },
                          child: CircleAvatar(
                            radius: 13,
                            backgroundColor: themeController.isLightTheme.value
                                ? ColorResources.black3.withOpacity(0.05)
                                : ColorResources.white.withOpacity(0.1),
                            child: ontapcontroller.check1.isTrue
                                ? Icon(
                                    Icons.check,
                                    color: ColorResources.blue,
                                    size: 18,
                                  )
                                : Text(""),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      RichText(
                        text: TextSpan(
                          text: "By Signing up, you agree to the",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: TextFontFamily.SEN_REGULAR,
                            color: themeController.isLightTheme.value
                                ? ColorResources.grey4
                                : ColorResources.grey5,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: " Terms of Service\n",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.blue,
                              ),
                            ),
                            TextSpan(
                              text: "and",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.grey4
                                    : ColorResources.grey5,
                              ),
                            ),
                            TextSpan(
                              text: " Privacy Policy",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      container(Images.googleicon, ColorResources.blue5),
                      const SizedBox(width: 15),
                      container(
                          Images.appleicon,
                          themeController.isLightTheme.value
                              ? ColorResources.black
                              : ColorResources.white),
                    ],
                  ),
                  const SizedBox(height: 42),
                  MaterialButton(
                    onPressed: () {
                      Get.off(NavigationBarBottom());
                    },
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: TextFontFamily.SEN_BOLD,
                        color: ColorResources.white,
                      ),
                    ),
                    height: 50,
                    minWidth: Get.width,
                    color: ColorResources.blue1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an Account?",
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: TextFontFamily.SEN_REGULAR,
                          color: themeController.isLightTheme.value
                              ? ColorResources.grey4
                              : ColorResources.grey5,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.off(LoginScreen());
                        },
                        child: Text(
                          " Login",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: TextFontFamily.SEN_BOLD,
                            color: ColorResources.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
