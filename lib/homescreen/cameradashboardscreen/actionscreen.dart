import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/controller/weekpromotionfavoritecontroller.dart';
import 'package:citymall/dialoguescreen/dialoguescreen.dart';
import 'package:citymall/homescreen/cameradashboardscreen/cameradeshboard.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ActionScreen extends StatelessWidget {
  ActionScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final WeekPromotionFavouriteController controller =
      Get.put(WeekPromotionFavouriteController());

  List<Map> actionGridList = [
    {
      "image": Images.weekc1,
      "text": "Action Camera\nHDR",
      "text1": "10%",
      "price": "\$200,43",
    },
    {
      "image": Images.weekc2,
      "text": "Compact Camera\nHigh...",
      "text1": "30%",
      "price": "\$299,43",
    },
    {
      "image": Images.weekc3,
      "text": "Action Camera\nHDR",
      "text1": "10%",
      "price": "\$200,00",
    },
    {
      "image": Images.weekc4,
      "text": "Compact Camera\nHigh...",
      "text1": "30%",
      "price": "\$299,43",
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
          "Action",
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
            padding: const EdgeInsets.only(top: 8, bottom: 8, right: 25),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogueScreen();
                  },
                );
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: themeController.isLightTheme.value
                      ? ColorResources.white1
                      : ColorResources.black6,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    Images.filtericon,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black2
                        : ColorResources.white,
                  ),
                ),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: GridView.builder(
              itemCount: actionGridList.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: Get.width > 450
                    ? 1.58 / 2.1
                    : Get.width < 370
                        ? 1.62 / 2.68
                        : 1.8 / 2.5,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeController.isLightTheme.value
                          ? ColorResources.white
                          : ColorResources.black5,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: themeController.isLightTheme.value
                              ? ColorResources.blue1.withOpacity(0.05)
                              : ColorResources.black1,
                          spreadRadius: 0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 150,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  //color: ColorResources.white6,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        actionGridList[index]["image"],
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                child: Container(
                                  height: 22,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    color: ColorResources.blue1,
                                  ),
                                  child: Center(
                                    child: Text(
                                      actionGridList[index]["text1"],
                                      style: TextStyle(
                                        color: ColorResources.white,
                                        fontSize: 12,
                                        fontFamily: TextFontFamily.SEN_BOLD,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            actionGridList[index]["text"],
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: TextFontFamily.SEN_BOLD,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.black2
                                  : ColorResources.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                actionGridList[index]["price"],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: TextFontFamily.SEN_EXTRA_BOLD,
                                  color: ColorResources.blue1,
                                ),
                              ),
                              Obx(
                                () => InkWell(
                                  onTap: () {
                                    controller.favourite1[index] =
                                        !controller.favourite1[index];
                                  },
                                  child: controller.favourite1[index] == false
                                      ? SvgPicture.asset(
                                          Images.blankfavoriteicon)
                                      : SvgPicture.asset(
                                          Images.fillfavoriteicon),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBar(
                                itemSize: 16,
                                maxRating: 5,
                                initialRating: 4,
                                itemCount: 5,
                                direction: Axis.horizontal,
                                ratingWidget: RatingWidget(
                                  full: Icon(
                                    Icons.star,
                                    color: ColorResources.yellow,
                                  ),
                                  empty: Icon(
                                    Icons.star,
                                    color: ColorResources.white2,
                                  ),
                                  half: Icon(Icons.star),
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              Text(
                                "932 Sale",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: TextFontFamily.SEN_REGULAR,
                                  color: ColorResources.white3,
                                ),
                              ),
                            ],
                          ),
                        ],
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
