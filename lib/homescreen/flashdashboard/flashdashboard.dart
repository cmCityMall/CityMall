import 'package:carousel_slider/carousel_slider.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/flash_sale_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/controller/weekpromotionfavoritecontroller.dart';
import 'package:citymall/homescreen/cameradashboardscreen/cameradetailscreen.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

// ignore: must_be_immutable
class FlashSaleScreen extends StatelessWidget {
  FlashSaleScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final WeekPromotionFavouriteController controller =
      Get.put(WeekPromotionFavouriteController());

  @override
  Widget build(BuildContext context) {
    final FlashSaleController flashController = Get.find();
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
          flashController.selectedFlash.value!.desc ?? "",
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "End in",
                      style: TextStyle(
                        fontFamily: TextFontFamily.SEN_BOLD,
                        fontSize: 16,
                        color: themeController.isLightTheme.value
                            ? ColorResources.black2
                            : ColorResources.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      DateFormat.yMEd()
                          .add_jms()
                          .format(flashController.selectedFlash.value!.endDate),
                      style: TextStyle(
                        fontFamily: TextFontFamily.SEN_BOLD,
                        fontSize: 16,
                        color: ColorResources.blue1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CarouselSlider.builder(
                  itemCount: 1,
                  itemBuilder:
                      (BuildContext context, index, int pageViewIndex) => Stack(
                    children: [
                      Container(
                        height: 115,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                                flashController.selectedFlash.value!.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        child: Row(
                          children: List.generate(
                            1,
                            (position) => Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Container(
                                width: 62,
                                height: 2,
                                decoration: BoxDecoration(
                                  //shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(
                                      index == position ? 7 : 2.5),
                                  color: ColorResources.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  options: CarouselOptions(
                    height: 115,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    initialPage: 3,
                    viewportFraction: 0.99,
                    //aspectRatio: 3.0,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Obx(() {
                      final mainData = flashController.products;
                      final dataList =
                          mainData[flashController.selectedFlash.value!.id];
                      final isLoading = flashController.productsLoading[
                          flashController.selectedFlash.value!.id];
                      if (!(isLoading == null) && isLoading == true) {
                        return const Center(
                            child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(),
                        ));
                      }
                      if (dataList == null || dataList.isEmpty) {
                        return const Center(child: Text("No product found!"));
                      }
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: flashController.scrollController,
                        itemCount: dataList.length,
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
                          final p = dataList[index];
                          final percentForTopBannerUI =
                              "${flashController.selectedFlash.value!.percentage!}%";
                          final product = p.copyWith(
                            promotion: ((p.price / 100) *
                                    flashController
                                        .selectedFlash.value!.percentage!)
                                .round(),
                          );
                          return InkWell(
                            onTap: () {
                              Get.off(CameraDetailScreen());
                            },
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
                                    horizontal: 8, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        //color: ColorResources.white6,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              product.images.first,
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Text(
                                      product.name,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: TextFontFamily.SEN_BOLD,
                                        color:
                                            themeController.isLightTheme.value
                                                ? ColorResources.black2
                                                : ColorResources.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${product.promotion ?? 0}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily:
                                                TextFontFamily.SEN_EXTRA_BOLD,
                                            color: ColorResources.blue1,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "${product.price}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily:
                                                TextFontFamily.SEN_REGULAR,
                                            color: ColorResources.white3,
                                          ),
                                        ),
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
                                        /*  Obx(
                                      () => InkWell(
                                        onTap: () {
                                          controller.favourite3[index] =
                                              !controller.favourite3[index];
                                        },
                                        child: controller.favourite3[index] ==
                                                false
                                            ? SvgPicture.asset(
                                                Images.blankfavoriteicon)
                                            : SvgPicture.asset(
                                                Images.fillfavoriteicon),
                                      ),
                                    ), */
                                      ],
                                    ),
                                    Text(
                                      "${product.remainQuantity}",
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontFamily: TextFontFamily.SEN_REGULAR,
                                        color:
                                            themeController.isLightTheme.value
                                                ? ColorResources.black2
                                                : ColorResources.white,
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      lineHeight: 3,
                                      percent: (product.remainQuantity /
                                          product.totalQuantity),
                                      padding: EdgeInsets.zero,
                                      backgroundColor: ColorResources.blue4,
                                      progressColor: ColorResources.green2,
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
                  child: Obx(() => flashController.isLoading.value
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
      ),
    );
  }
}
