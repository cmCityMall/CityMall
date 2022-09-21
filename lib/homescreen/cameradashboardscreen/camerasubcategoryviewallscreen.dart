import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/homescreen/cameradashboardscreen/actionscreen.dart';
import 'package:citymall/homescreen/cameradashboardscreen/cameradeshboard.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CameraSubCategoryViewAllScreen extends StatelessWidget {
  CameraSubCategoryViewAllScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  List<Map> subCategoryGridList = [
    {
      "image": Images.action,
      "text": "Action",
    },
    {
      "image": Images.digital,
      "text": "Digital",
    },
    {
      "image": Images.analog,
      "text": "Analog",
    },
    {
      "image": Images.drone,
      "text": "Drone",
    },
    {
      "image": Images.handycam,
      "text": "Handycam",
    },
    {
      "image": Images.cctv,
      "text": "CCTV",
    },
    {
      "image": Images.action2,
      "text": "Action",
    },
    {"image": Images.digital2, "text": "Digital"},
    {
      "image": Images.analog2,
      "text": "Analog",
    },
    {
      "image": Images.drone2,
      "text": "Drone",
    },
    {
      "image": Images.handycam2,
      "text": "Handycam",
    },
    {
      "image": Images.cctv2,
      "text": "CCTV",
    },
  ];

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
              Get.off(CameraDeshBoard());
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
          "Sub Category",
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
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 10, bottom: 20),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.2,
              ),
              itemCount: subCategoryGridList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      Get.off(ActionScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        image: DecorationImage(
                          image:
                              AssetImage(subCategoryGridList[index]["image"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          subCategoryGridList[index]["text"],
                          style: TextStyle(
                            fontFamily: TextFontFamily.SEN_BOLD,
                            fontSize: 14,
                            color: ColorResources.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
