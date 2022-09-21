import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/homescreen/cameradashboardscreen/cameradeshboard.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/notificationscreen/notificationscreen.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MenuViewAllScreen extends StatelessWidget {
  MenuViewAllScreen({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());
  List<Map> menuGridList = [
    {
      "image": Images.camera,
      "text": "Camera",
    },
    {
      "image": Images.food,
      "text": "Food ",
    },
    {
      "image": Images.handphone,
      "text": "Hand\nphone",
    },
    {
      "image": Images.gamming,
      "text": "Gamming",
    },
    {
      "image": Images.fashionicon,
      "text": "Fashion",
    },
    {
      "image": Images.healthcareicon,
      "text": "Health\nCare",
    },
    {
      "image": Images.computericon,
      "text": "Computer",
    },
    {
      "image": Images.equipmenticon,
      "text": "Equipment",
    },
    {
      "image": Images.otomotificon,
      "text": "Otomotif",
    },
    {
      "image": Images.sporticon,
      "text": "Sport",
    },
    {
      "image": Images.ticketicon,
      "text": "Ticket\nCinema",
    },
    {
      "image": Images.bookicon,
      "text": "Book",
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
              selectedIndex = 0;
              Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => NavigationBarBottom(),
                ),
              );
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
          "Menu",
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 22,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: InkWell(
              onTap: () {
                Get.off(NotificationScreen());
              },
              child: SvgPicture.asset(
                Images.notification,
                color: themeController.isLightTheme.value
                    ? ColorResources.white3
                    : ColorResources.white.withOpacity(0.6),
              ),
            ),
          ),
        ],
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
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                //crossAxisSpacing: 2,
                mainAxisSpacing: 5,
                childAspectRatio: 0.78,
              ),
              itemCount: menuGridList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.off(CameraDeshBoard());
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Container(
                      height: 100,
                      width: 80,
                      decoration: BoxDecoration(
                        color: themeController.isLightTheme.value
                            ? ColorResources.white1
                            : ColorResources.black1,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: ColorResources.blue2),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: themeController.isLightTheme.value
                                ? ColorResources.white4
                                : ColorResources.white.withOpacity(0.05),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(menuGridList[index]["image"]),
                              SizedBox(height: 8),
                              Text(
                                menuGridList[index]["text"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: TextFontFamily.SEN_REGULAR,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.black2
                                      : ColorResources.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
