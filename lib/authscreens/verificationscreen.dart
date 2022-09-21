import 'package:citymall/authscreens/changepasswordscreen.dart';
import 'package:citymall/authscreens/forgotpasswordscreen.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class PhoneVerificationScreen extends StatelessWidget {
  PhoneVerificationScreen({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(30),
    );
  }

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
                    Get.off(ForgotPasswordScreen());
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
                  "Phone Verification",
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
                  "Please enter the 4-digit code send to you at",
                  style: TextStyle(
                    fontFamily: TextFontFamily.SEN_REGULAR,
                    fontSize: 12,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black3.withOpacity(0.6)
                        : ColorResources.white.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "+91  12345 67890",
                  style: TextStyle(
                    fontFamily: TextFontFamily.SEN_BOLD,
                    fontSize: 12,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black2
                        : ColorResources.white,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Resend Code",
                  style: TextStyle(
                    fontFamily: TextFontFamily.SEN_REGULAR,
                    fontSize: 12,
                    color: ColorResources.blue1,
                  ),
                ),
                SizedBox(height: 50),
                Builder(
                  builder: (context) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                color: themeController.isLightTheme.value
                                    ? ColorResources.white
                                    : ColorResources.black1,
                                child: Pinput(
                                  length: 4,
                                  defaultPinTheme: PinTheme(
                                    textStyle: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 20,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black3
                                          : ColorResources.white,
                                    ),
                                    /*  cursorColor:
                                      themeController.isLightTheme.value
                                          ? ColorResources.blue1
                                          : ColorResources.grey6, */
                                    height: 55,
                                    width: 55,
                                    decoration: _pinPutDecoration.copyWith(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color:
                                            themeController.isLightTheme.value
                                                ? ColorResources.blue1
                                                : ColorResources.grey6,
                                      ),
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.white
                                          : ColorResources.black1,
                                    ),
                                  ),
                                  focusNode: _pinPutFocusNode,
                                  controller: _pinPutController,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
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
                Get.off(ChangePasswordScreen());
              },
              child: Text(
                "Reset password",
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
          )
        ],
      ),
    );
  }
}
