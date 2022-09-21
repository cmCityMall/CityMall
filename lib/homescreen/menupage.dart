import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/homescreen/menuviewallscreen.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/menuscreens/aboutusscreen.dart';
import 'package:citymall/menuscreens/languegescreen.dart';
import 'package:citymall/menuscreens/profilescreen/profilescreen.dart';
import 'package:citymall/menuscreens/settingscreens/settingscreen.dart';
import 'package:citymall/myorderscreen/tabscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MenuPage extends GetView {
  MenuPage({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  InkWell inkwell(String image, String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: SvgPicture.asset(image),
        title: Text(
          text,
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_REGULAR,
            fontSize: 14,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white12
          : ColorResources.black1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Container(
                  height: 75,
                  width: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage(Images.profileimage),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(height: 12),
                Text(
                  "John Doe",
                  style: TextStyle(
                    fontFamily: TextFontFamily.SEN_BOLD,
                    fontSize: 16,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black2
                        : ColorResources.white,
                  ),
                ),
                Text(
                  "Johndoe@gmail.com",
                  style: TextStyle(
                    fontFamily: TextFontFamily.SEN_REGULAR,
                    fontSize: 14,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black2
                        : ColorResources.white,
                  ),
                ),
                SizedBox(height: 40),
                inkwell(Images.profileicon, "My profile", () {
                  Get.off(ProfileScreen());
                }),
                inkwell(Images.languegeicon, "Language", () {
                  Get.off(LangueageScreen());
                }),
                inkwell(Images.categoryicon, "All Categories", () {
                  Get.off(MenuViewAllScreen());
                }),
                inkwell(Images.myordericon, "My Order", () {
                  Get.off(MyOrderScreen());
                }),
                inkwell(Images.settingicon, "Settings", () {
                  Get.off(SettingScreen());
                }),
                inkwell(Images.aboutusicon, "About Us", () {
                  Get.off(AboutUsScreen());
                }),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorResources.blue1,
                  ),
                  child: Center(
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                        fontFamily: TextFontFamily.SEN_BOLD,
                        fontSize: 14,
                        color: ColorResources.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
