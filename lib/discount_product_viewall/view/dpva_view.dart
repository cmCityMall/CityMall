import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/recomendedfavoritecontroller.dart';
import 'package:citymall/controller/recommend_screen_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/dialoguescreen/dialoguescreen.dart';
import 'package:citymall/discount_product_viewall/controller/dpva_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/productdetailsscreen/productdetailscreen.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/widgets/empty_widgt.dart';
import '../../utils/widgets/loading_widget.dart';

// ignore: must_be_immutable
class DPVAView extends StatelessWidget {
  DPVAView({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final RecomendedFavouriteController controller =
      Get.put(RecomendedFavouriteController());

  @override
  Widget build(BuildContext context) {
    final DPVAController dpvaController = Get.find();
    final DBDataController dbDataController = Get.find();
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
          "Discount Products",
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
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: themeController.isLightTheme.value
                ? ColorResources.white1
                : ColorResources.black1,
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Obx(() {
                    final mainData = dbDataController.discountProducts;
                    final dataList = mainData[dbDataController.mainId];
                    final isLoading = dbDataController
                        .discountProductsLoading[dbDataController.mainId];
                    if (!(isLoading == null) && isLoading == true) {
                      return const LoadingWidget();
                    }
                    if (dataList == null || dataList.isEmpty) {
                      return const EmptyWidget("No Discount Items yet.");
                    }
                    return GridView.builder(
                      itemCount: dataList.length,
                      controller: dpvaController.scrollController,
                      physics: const BouncingScrollPhysics(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 150,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          //color: ColorResources.white6,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                dataList[index].images.first,
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
                                              dataList[index]
                                                  .promotion
                                                  .toString(),
                                              style: TextStyle(
                                                color: ColorResources.white,
                                                fontSize: 12,
                                                fontFamily:
                                                    TextFontFamily.SEN_BOLD,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    dataList[index].name,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: TextFontFamily.SEN_BOLD,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dataList[index].price.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              TextFontFamily.SEN_EXTRA_BOLD,
                                          color: ColorResources.blue1,
                                        ),
                                      ),
                                      /* Obx(
                                              () => InkWell(
                                                onTap: () {
                                                  favorite.favourite1[index] =
                                                      !favorite
                                                          .favourite1[index];
                                                },
                                                child: favorite.favourite1[
                                                            index] ==
                                                        false
                                                    ? SvgPicture.asset(Images
                                                        .blankfavoriteicon)
                                                    : SvgPicture.asset(Images
                                                        .fillfavoriteicon),
                                              ),
                                            ), */
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          fontFamily:
                                              TextFontFamily.SEN_REGULAR,
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
                    );
                  }),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Obx(() => dpvaController.isLoading.value
                    ? AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                        height: 35,
                        width: 35,
                        child: const CircularProgressIndicator(),
                      )
                    : const SizedBox()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
