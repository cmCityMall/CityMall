import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/menuscreens/profilescreen/profilechangepassword.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
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
              selectedIndex = 0;
              Navigator.of(context, rootNavigator: true)
                  .pushReplacement(MaterialPageRoute(
                builder: (context) => NavigationBarBottom(),
              ));
              //Get.off(DrawerPage());
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
          "My Profile",
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 22,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 115,
                              width: 115,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: AssetImage(Images.profileimage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorResources.blue1,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: SvgPicture.asset(
                                    Images.editicon,
                                    color: ColorResources.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      text("Full Name"),
                      SizedBox(height: 8),
                      textFormField("John Doe"),
                      SizedBox(height: 25),
                      text("Email Address"),
                      SizedBox(height: 8),
                      textFormField("JohnDoe20jd@gmail.com"),
                      SizedBox(height: 25),
                      text("Phone Number"),
                      SizedBox(height: 8),
                      textFormField("+91 12345 67890"),
                      SizedBox(height: 25),
                      text("Password"),
                      SizedBox(height: 8),
                      Container(
                        color: themeController.isLightTheme.value
                            ? ColorResources.white
                            : ColorResources.black4,
                        child: TextFormField(
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.black3
                                  : ColorResources.white1),
                          cursorColor: themeController.isLightTheme.value
                              ? ColorResources.black3
                              : ColorResources.white1,
                          decoration: InputDecoration(
                            suffixIcon: TextButton(
                              onPressed: () {
                                Get.off(ProfileChangePasswordScreen());
                              },
                              child: Text(
                                "Change",
                                style: TextStyle(
                                  fontFamily: TextFontFamily.SEN_REGULAR,
                                  fontSize: 14,
                                  color: ColorResources.blue1,
                                ),
                              ),
                            ),
                            fillColor: themeController.isLightTheme.value
                                ? ColorResources.white
                                : ColorResources.black4,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            hintText: "************",
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  color: ColorResources.blue1,
                ),
                child: Center(
                  child: Text(
                    "Update",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_BOLD,
                      fontSize: 20,
                      color: ColorResources.white,
                    ),
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
