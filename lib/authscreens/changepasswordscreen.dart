import 'package:citymall/authscreens/loginscreen.dart';
import 'package:citymall/authscreens/verificationscreen.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  Text text(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontFamily: TextFontFamily.SEN_BOLD,
        color: themeController.isLightTheme.value
            ? ColorResources.black2
            : ColorResources.white,
      ),
    );
  }

  Container textFormField() {
    return Container(
      color: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black4,
      child: TextFormField(
        style: TextStyle(
            fontSize: 16,
            fontFamily: TextFontFamily.SEN_REGULAR,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white1),
        cursorColor: themeController.isLightTheme.value
            ? ColorResources.black3
            : ColorResources.white1,
        decoration: InputDecoration(
          fillColor: themeController.isLightTheme.value
              ? ColorResources.white
              : ColorResources.black4,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintText: "*********",
          hintStyle: TextStyle(
            fontFamily: TextFontFamily.SEN_REGULAR,
            fontSize: 14,
            color: themeController.isLightTheme.value
                ? ColorResources.grey7
                : ColorResources.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: themeController.isLightTheme.value
                  ? ColorResources.white2
                  : ColorResources.black5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: themeController.isLightTheme.value
                  ? ColorResources.white2
                  : ColorResources.black5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: themeController.isLightTheme.value
                  ? ColorResources.white2
                  : ColorResources.black5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: themeController.isLightTheme.value
                  ? ColorResources.white2
                  : ColorResources.black5,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black4,
      appBar: AppBar(
        backgroundColor: themeController.isLightTheme.value
            ? ColorResources.white
            : ColorResources.black4,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: InkWell(
            onTap: () {
              Get.off(PhoneVerificationScreen());
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
        title: Text(
          "Change Password",
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 18,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: themeController.isLightTheme.value
                ? ColorResources.white1
                : ColorResources.black1,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Password"),
                    SizedBox(height: 8),
                    textFormField(),
                    SizedBox(height: 25),
                    text("New Password"),
                    SizedBox(height: 8),
                    textFormField(),
                    SizedBox(height: 25),
                    text("Confirm Password"),
                    SizedBox(height: 8),
                    textFormField(),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 25,
                right: 25,
                child: MaterialButton(
                  onPressed: () {
                    Get.off(LoginScreen());
                  },
                  child: Text(
                    "Submit",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
