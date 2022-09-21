import 'package:citymall/categorybrandscreen/subcategory1.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CategoryBrandScreen extends StatelessWidget {
  CategoryBrandScreen({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());

  List<Map> categoryBrandList = [
    {
      "image": Images.nikesport,
      "text": "Nike Sport",
    },
    {
      "image": Images.sonytech,
      "text": "Sony Tech ",
    },
    {
      "image": Images.samsungtech,
      "text": "Samsung  Tech",
    },
    {
      "image": Images.supreme,
      "text": "Supreme",
    },
    {
      "image": Images.prada,
      "text": "Prada",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black4,
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoryBrandList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: () {
                      Get.off(SubCategoryScreen1());
                    },
                    child: Container(
                      height: 141,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(
                            categoryBrandList[index]["image"],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          categoryBrandList[index]["text"],
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: TextFontFamily.SEN_EXTRA_BOLD,
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
