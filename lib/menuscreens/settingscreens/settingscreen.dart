import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/switchcontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/menuscreens/settingscreens/saveaddressscreen.dart';
import 'package:citymall/menuscreens/settingscreens/carddetailscreen.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final SwitchController controller = Get.put(SwitchController());

  InkWell container(String text, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: themeController.isLightTheme.value
              ? ColorResources.white
              : ColorResources.black13,
        ),
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: TextFontFamily.SEN_REGULAR,
                fontSize: 18,
                color: themeController.isLightTheme.value
                    ? ColorResources.grey4
                    : ColorResources.white.withOpacity(0.6),
              ),
            ),
          ),
          trailing: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: themeController.isLightTheme.value
                  ? ColorResources.grey4
                  : ColorResources.white.withOpacity(0.6),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
                selectedIndex = 0;
                Navigator.of(context, rootNavigator: true)
                    .pushReplacement(MaterialPageRoute(
                  builder: (context) => NavigationBarBottom(),
                ));
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
            "Setting",
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
                      height: 50,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: themeController.isLightTheme.value
                            ? ColorResources.white
                            : ColorResources.black13,
                      ),
                      child: ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Dark Theme",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_BOLD,
                              fontSize: 18,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.black2
                                  : ColorResources.white,
                            ),
                          ),
                        ),
                        trailing: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Switch(
                            value: !themeController.isLightTheme.value,
                            onChanged: (val) {
                              print("Change THeme : $val}");
                              themeController.lightTheme();
                              // Get.changeThemeMode(ThemeMode.dark,
                              // );
                              themeController.saveThemeStatus();
                            },
                            activeColor: ColorResources.blue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    /* Text(
                      "Setting",
                      style: TextStyle(
                        fontFamily: TextFontFamily.SEN_BOLD,
                        fontSize: 20,
                        color: themeController.isLightTheme.value
                            ? ColorResources.black2
                            : ColorResources.white,
                      ),
                    ),
                    SizedBox(height: 14),
                    Container(
                      height: 50,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: themeController.isLightTheme.value
                            ? ColorResources.white
                            : ColorResources.black13,
                      ),
                      child: ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Order Notifications",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 18,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.grey4
                                  : ColorResources.white.withOpacity(0.6),
                            ),
                          ),
                        ),
                        trailing: Obx(
                          () => Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Switch(
                                activeColor: ColorResources.blue,
                                onChanged: (val) => controller.toggle(),
                                value: controller.on1.value),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: themeController.isLightTheme.value
                            ? ColorResources.white
                            : ColorResources.black13,
                      ),
                      child: ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Discount Notifications",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 18,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.grey4
                                  : ColorResources.white.withOpacity(0.6),
                            ),
                          ),
                        ),
                        trailing: Obx(
                          () => Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Switch(
                                activeColor: ColorResources.blue,
                                onChanged: (val) => controller.toggle2(),
                                value: controller.on2.value),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: themeController.isLightTheme.value
                            ? ColorResources.white
                            : ColorResources.black13,
                      ),
                      child: ListTile(
                        leading: Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Order Notifications",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 18,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.grey4
                                  : ColorResources.white.withOpacity(0.6),
                            ),
                          ),
                        ),
                        trailing: Obx(
                          () => Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Switch(
                                activeColor: ColorResources.blue,
                                onChanged: (val) => controller.toggle3(),
                                value: controller.on3.value),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20), */
                    Text(
                      "Account",
                      style: TextStyle(
                        fontFamily: TextFontFamily.SEN_BOLD,
                        fontSize: 20,
                        color: themeController.isLightTheme.value
                            ? ColorResources.black2
                            : ColorResources.white,
                      ),
                    ),
                    SizedBox(height: 14),
                    container("Address", () {
                      Get.to(() => SaveAddressScreen());
                    }),
                    /* SizedBox(height: 10),
                    container("Payment Method", () {
                      Get.off(CardDetailScreen());
                    }), */
                    SizedBox(height: 10),
                    container("Privacy policy", () {}),
                    SizedBox(height: 10),
                    container("Terms & conditions", () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
