import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  Text text(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13.5,
        fontFamily: TextFontFamily.SEN_REGULAR,
        color: themeController.isLightTheme.value
            ? ColorResources.grey12
            : ColorResources.white.withOpacity(0.6),
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
          "About Us",
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text("Lorem Ipsum is simply dummy text of the printing"
                      "and typesetting industry. Lorem Ipsum has been the"
                      "indu stry's standard dummy text ever since the"
                      "1500s, whe an unknown printer took a galley of type"
                      "and sc rambled it to make a type"),
                  SizedBox(height: 15),
                  text("Ipsum has been the indu stry's standard dummy"
                      "text ever since the 1500s, whe an unknown printerto"
                      "ok a galley of type and sc rambled it to"
                      "make a type"),
                  SizedBox(height: 15),
                  text("Lorem Ipsum is simply dummy text of the printing"
                      "and typesetting industry. Lorem Ipsum has been the"
                      "indu stry's standard dummy text ever since the"
                      "1500s, whe an unknown printer took a galley of type"
                      "and sc rambled it to make a type"),
                  SizedBox(height: 15),
                  text("Lorem Ipsum is simply dummy text of the printing"
                      "and typesetting industry. Lorem Ipsum has been the"
                      "indu stry's standard dummy text ever since the"
                      "1500s, whe an unknown printer took a galley of type"
                      "and sc rambled it to make a type"),
                  SizedBox(height: 15),
                  text("Ipsum has been the indu stry's standard dummy"
                      "text ever since the 1500s, whe an unknown printerto"
                      "ok a galley of type and sc rambled it to"
                      "make a type"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
