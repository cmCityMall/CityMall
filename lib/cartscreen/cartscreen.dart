import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/cartcontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  CartCounterController controller = Get.put(CartCounterController());

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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 140),
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: 115,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: themeController.isLightTheme.value
                              ? ColorResources.white
                              : ColorResources.black6,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: ColorResources.blue1.withOpacity(0.05),
                              spreadRadius: 0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 85,
                                width: 85,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: ColorResources.white6,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Image.asset(Images.cartphoneimage),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Samsung Galaxy Note\n9 Pro...",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: TextFontFamily.SEN_BOLD,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
                                  ),
                                  Text(
                                    "Internal 1 TB:",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.white7
                                          : ColorResources.white
                                              .withOpacity(0.6),
                                    ),
                                  ),
                                  Text(
                                    "\$950,00",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontWeight: FontWeight.w800,
                                      color: ColorResources.blue1,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                    backgroundColor: ColorResources.white,
                                    barrierDismissible: true,
                                    title: "",
                                    titlePadding: EdgeInsets.all(0),
                                    contentPadding: EdgeInsets.all(0),
                                    content: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GetBuilder(
                                          init: controller,
                                          builder: (_) => InkWell(
                                            onTap: () {
                                              controller.increment(index);
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorResources.grey9,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color: ColorResources.white,
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 25),
                                        Obx(
                                          () => Text(
                                            "${controller.count[index]}",
                                            style: TextStyle(
                                              fontSize: 36,
                                              fontFamily:
                                                  TextFontFamily.SEN_BOLD,
                                              color: ColorResources.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 25),
                                        GetBuilder(
                                          init: controller,
                                          builder: (_) => InkWell(
                                            onTap: () {
                                              controller.decrement(index);
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ColorResources.grey9,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.remove,
                                                  color: ColorResources.white,
                                                  size: 22,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 25),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "Add to Cart",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily:
                                                    TextFontFamily.SEN_BOLD,
                                                color: ColorResources.white,
                                              ),
                                            ),
                                            height: 50,
                                            minWidth: 155,
                                            color: ColorResources.blue1,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorResources.blue1,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: ColorResources.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 70,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal:",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: TextFontFamily.SEN_REGULAR,
                            color: themeController.isLightTheme.value
                                ? ColorResources.black2.withOpacity(0.6)
                                : ColorResources.white.withOpacity(0.6),
                          ),
                        ),
                        Text(
                          "\$2,850.00",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: TextFontFamily.SEN_BOLD,
                            color: themeController.isLightTheme.value
                                ? ColorResources.black2
                                : ColorResources.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Taxes:",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: TextFontFamily.SEN_REGULAR,
                            color: themeController.isLightTheme.value
                                ? ColorResources.black2.withOpacity(0.6)
                                : ColorResources.white.withOpacity(0.6),
                          ),
                        ),
                        Text(
                          "\$40",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: TextFontFamily.SEN_BOLD,
                            color: themeController.isLightTheme.value
                                ? ColorResources.black2
                                : ColorResources.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                        color: themeController.isLightTheme.value
                            ? ColorResources.white
                            : ColorResources.black4,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: ColorResources.black.withOpacity(0.05),
                            spreadRadius: 0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$2,890.00",
                              style: TextStyle(
                                fontSize: 28,
                                fontFamily: TextFontFamily.SEN_EXTRA_BOLD,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.white,
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                color: ColorResources.blue1,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Text(
                                  "PAY",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    color: ColorResources.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
