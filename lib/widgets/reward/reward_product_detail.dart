import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/clickcontroller.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/model/reward_product.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../authscreens/loginscreen.dart';
import '../../controller/auth_controller.dart';
import '../../controller/cart_controller.dart';
import '../other/cache_image.dart';
import '../other/cart_icon_widget.dart';

// ignore: must_be_immutable
class RewardProductDetailScreen extends StatelessWidget {
  final RewardProduct rewardProduct;
  RewardProductDetailScreen({
    Key? key,
    required this.rewardProduct,
  }) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final ColorClickController ontapColorController =
      Get.put(ColorClickController());
  final SizeClickController ontapSizeController =
      Get.put(SizeClickController());
  final ArrowClickController arrowClickController =
      Get.put(ArrowClickController());
  final AddressClickController1 addressClickController1 =
      Get.put(AddressClickController1());

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    final CartController cartController = Get.find();
    return Scaffold(
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white6
          : ColorResources.black4,
      appBar: AppBar(
        backgroundColor: themeController.isLightTheme.value
            ? ColorResources.white6
            : ColorResources.black4,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: InkWell(
            onTap: () {
              Get.back();
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
              child: const Center(
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
          "Product Detail",
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
                selectedIndex = 4;
                Navigator.of(context, rootNavigator: true)
                    .pushReplacement(MaterialPageRoute(
                  builder: (context) => NavigationBarBottom(),
                ));
              },
              child: CartIconWidget(
                themeController: themeController,
                color: ColorResources.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 240,
                    width: Get.width,
                    color: themeController.isLightTheme.value
                        ? ColorResources.white6
                        : ColorResources.black4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Container(
                            height: 240,
                            width: 210,
                            color: themeController.isLightTheme.value
                                ? ColorResources.white6
                                : ColorResources.black4,
                            child: CustomCacheNetworkImage(
                              //Proudct first image
                              imageUrl: rewardProduct.image,
                              boxFit: BoxFit.cover,
                            ),
                          ),
                        ),
                        //SizedBox(width: Get.width / 10.27),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(top: 50, right: 20),
                              child: Container(
                                height:
                                    arrowClickController.click.value == false
                                        ? 100
                                        : 200,
                                width: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.white
                                      : ColorResources.black1,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(
                                        () => InkWell(
                                          onTap: () {
                                            arrowClickController.click.value =
                                                !arrowClickController
                                                    .click.value;
                                          },
                                          child: SvgPicture.asset(
                                            arrowClickController.click.value ==
                                                    false
                                                ? Images.arrowup
                                                : Images.arrowdown,
                                            color: themeController
                                                    .isLightTheme.value
                                                ? ColorResources.grey8
                                                : ColorResources.white,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 0.6,
                                        color: ColorResources.grey6,
                                      ),
                                      //Images for Product to Choose
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Container(
                                              height: 42,
                                              width: 42,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                color: ColorResources.grey6,
                                              ),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child:
                                                      CustomCacheNetworkImage(
                                                    imageUrl:
                                                        rewardProduct.image,
                                                    boxFit: BoxFit.contain,
                                                  )),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    // height: Get.height,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: themeController.isLightTheme.value
                          ? ColorResources.white
                          : ColorResources.black1,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(100),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 34,
                          color: ColorResources.black.withOpacity(0.04),
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Product Name
                              Expanded(
                                child: Text(
                                  rewardProduct.name,
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    fontSize: 24,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Product Price
                              Text(
                                "${rewardProduct.requiredPoint} points",
                                style: const TextStyle(
                                  fontFamily: TextFontFamily.SEN_EXTRA_BOLD,
                                  fontSize: 25,
                                  color: ColorResources.blue1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 0.5,
                            color: themeController.isLightTheme.value
                                ? ColorResources.grey8
                                : ColorResources.white.withOpacity(0.2),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 175,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: themeController.isLightTheme.value
                                  ? ColorResources.white
                                  : ColorResources.black1,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color:
                                      ColorResources.black.withOpacity(0.018),
                                  spreadRadius: 0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    fontSize: 18,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                                SizedBox(height: 10),

                                ///Description.............///
                                Text(
                                  rewardProduct.description,
                                  maxLines: 5,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    height: 1.3,
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 13,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.grey5
                                        : ColorResources.white.withOpacity(0.6),
                                  ),
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    Get.bottomSheet(
                                      Container(
                                        //height: 250,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Description",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        TextFontFamily.SEN_BOLD,
                                                    fontSize: 18,
                                                    color: themeController
                                                            .isLightTheme.value
                                                        ? ColorResources.black2
                                                        : ColorResources.white,
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Text(
                                                  rewardProduct.description,
                                                  style: TextStyle(
                                                    height: 1.3,
                                                    fontFamily: TextFontFamily
                                                        .SEN_REGULAR,
                                                    fontSize: 13,
                                                    color: themeController
                                                            .isLightTheme.value
                                                        ? ColorResources.grey5
                                                        : ColorResources.white
                                                            .withOpacity(0.6),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      backgroundColor:
                                          themeController.isLightTheme.value
                                              ? ColorResources.white
                                              : ColorResources.black1,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25)),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        "View More",
                                        style: TextStyle(
                                          fontFamily: TextFontFamily.SEN_BOLD,
                                          fontSize: 15,
                                          color: ColorResources.blue1,
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: ColorResources.blue1,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Review Product",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: TextFontFamily.SEN_BOLD,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.black2
                                      : ColorResources.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 90,
                width: Get.width,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: themeController.isLightTheme.value
                      ? ColorResources.white
                      : ColorResources.black1,
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Row(
                    children: [
                      CartIconWidget(
                        themeController: themeController,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (authController.currentUser.value!.status! ==
                                0) {
                              Get.to(() => LoginScreen());
                              return;
                            }

                            cartController.addToRewardCart(RewardProduct(
                              id: rewardProduct.id,
                              name: rewardProduct.name,
                              image: rewardProduct.image,
                              description: rewardProduct.description,
                              requiredPoint: rewardProduct.requiredPoint,
                              count: 1,
                              totalQuantity: rewardProduct.totalQuantity,
                              remainQuantity: rewardProduct.remainQuantity,
                              dateTime: rewardProduct.dateTime,
                            ));
                          },
                          child: Container(
                            height: 50,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorResources.blue1,
                            ),
                            child: const Center(
                              child: Text(
                                "Add to cart",
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
