import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/menuscreens/settingscreens/carddetailscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PaymentMethodAddCardScreen extends StatelessWidget {
  PaymentMethodAddCardScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  Text text(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: TextFontFamily.SEN_BOLD,
        fontSize: 14,
        color: themeController.isLightTheme.value
            ? ColorResources.black2
            : ColorResources.white,
      ),
    );
  }

  Container textFormField(String hint) {
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
          hintText: hint,
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
              Get.off(CardDetailScreen());
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
          "Add Card",
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 22,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: ColorResources.blue1,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(Images.card),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(Images.mastercard),
                          SizedBox(height: 20),
                          Text(
                            "* * * *  * * * *  * * * *  3947",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: ColorResources.white,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Card Holder Name",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: ColorResources.white,
                                    ),
                                  ),
                                  Text(
                                    "Jennyfer Doe",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: ColorResources.white,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expiry Date",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: ColorResources.white,
                                    ),
                                  ),
                                  Text(
                                    "05/23",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: ColorResources.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  text("Card Number"),
                  SizedBox(height: 10),
                  textFormField("1231 - 2312 - 3123 - 1231"),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text("Expiration Date"),
                            SizedBox(height: 10),
                            textFormField("12/12"),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text("Security Code"),
                            SizedBox(height: 10),
                            textFormField("1219"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  text("Card Holder"),
                  SizedBox(height: 10),
                  textFormField("John Doe"),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      Get.off(CardDetailScreen());
                    },
                    child: Container(
                      height: 50,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: ColorResources.blue1,
                      ),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            fontFamily: TextFontFamily.SEN_BOLD,
                            fontSize: 20,
                            color: ColorResources.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
