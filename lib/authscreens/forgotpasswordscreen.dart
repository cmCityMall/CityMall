import 'package:country_code_picker/country_code_picker.dart';
import 'package:citymall/authscreens/loginscreen.dart';
import 'package:citymall/authscreens/verificationscreen.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());
  TextEditingController phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black1,
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 25,
            right: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Get.off(LoginScreen());
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
                SizedBox(height: 45),
                Text(
                  "Forgot your password?",
                  style: TextStyle(
                    fontFamily: TextFontFamily.SEN_BOLD,
                    fontSize: 26,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black2
                        : ColorResources.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "If you need help resetting your password\n"
                  "we can help by sending you a link to reset it.",
                  style: TextStyle(
                    fontFamily: TextFontFamily.SEN_REGULAR,
                    fontSize: 12,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black3.withOpacity(0.6)
                        : ColorResources.white.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 60),
                TextFormField(
                  controller: phoneController,
                  cursorColor: themeController.isLightTheme.value
                      ? ColorResources.black3
                      : ColorResources.white,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 18),
                      fillColor: themeController.isLightTheme.value
                          ? ColorResources.white
                          : ColorResources.black1,
                      hintText: " Your Phone Number",
                      hintStyle: TextStyle(
                          fontFamily: TextFontFamily.SEN_REGULAR,
                          fontSize: 16,
                          color: themeController.isLightTheme.value
                              ? ColorResources.black3.withOpacity(0.3)
                              : ColorResources.grey1),
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountryCodePicker(
                            initialSelection: '+91',
                            favorite: ['+91', 'SN'],
                            textStyle: TextStyle(
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black3
                                    : ColorResources.white),
                            showFlag: true,
                          ),
                          Container(
                            height: 35,
                            child: const VerticalDivider(
                              color: ColorResources.grey6,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
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
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    color: themeController.isLightTheme.value
                        ? ColorResources.black2
                        : ColorResources.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 25,
            right: 25,
            child: MaterialButton(
              onPressed: () {
                Get.off(PhoneVerificationScreen());
              },
              child: Text(
                "Next",
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
    );
  }
}
