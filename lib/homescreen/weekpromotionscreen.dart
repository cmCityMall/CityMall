import 'package:citymall/controller/week_promotion_controller.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/controller/weekpromotionfavoritecontroller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class WeekPromotionScreen extends StatelessWidget {
  WeekPromotionScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  // WeekPromotionSearchController searchController =
  //     Get.put(WeekPromotionSearchController());
  final WeekPromotionFavouriteController controller =
      Get.put(WeekPromotionFavouriteController());

  @override
  Widget build(BuildContext context) {
    final WeekPromotionControllerUser weekPromotionController = Get.find();
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
          weekPromotionController.selectedWeekPromotion.value!.desc,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GetBuilder(
                //   init: searchController,
                //   builder: (search) =>
                TextFormField(
                  style: TextStyle(
                      fontFamily: TextFontFamily.SEN_REGULAR,
                      fontSize: 15,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white),
                  cursorColor: ColorResources.grey,
                  //maxLines: 2,
                  //onChanged: searchController.onSearchTextChanged,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: themeController.isLightTheme.value
                          ? ColorResources.navyblue
                          : ColorResources.white,
                    ),
                    filled: true,
                    fillColor: themeController.isLightTheme.value
                        ? ColorResources.white
                        : ColorResources.black4,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: "Search Product Name",
                    hintStyle: TextStyle(
                        fontFamily: TextFontFamily.SEN_REGULAR,
                        fontSize: 16,
                        color: ColorResources.grey5),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: themeController.isLightTheme.value
                            ? ColorResources.white8
                            : ColorResources.black5,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: themeController.isLightTheme.value
                            ? ColorResources.white8
                            : ColorResources.black5,
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: themeController.isLightTheme.value
                            ? ColorResources.white8
                            : ColorResources.black5,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: themeController.isLightTheme.value
                            ? ColorResources.white8
                            : ColorResources.black5,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Obx(() {
                      final mainData = weekPromotionController.products;
                      final dataList = mainData[weekPromotionController
                          .selectedWeekPromotion.value!.id];
                      final isLoading = weekPromotionController.productsLoading[
                          weekPromotionController
                              .selectedWeekPromotion.value!.id];
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
                        controller: weekPromotionController.scrollController,
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
                          final percentForTopBannerUI = weekPromotionController
                                  .selectedWeekPromotion.value!.isPercentage
                              ? "${weekPromotionController.selectedWeekPromotion.value!.percentage!}%"
                              : "${weekPromotionController.selectedWeekPromotion.value!.descountPrice!}MMK";
                          final product = p.copyWith(
                            promotion: weekPromotionController
                                    .selectedWeekPromotion.value!.isPercentage
                                ? ((p.price / 100) *
                                        weekPromotionController
                                            .selectedWeekPromotion
                                            .value!
                                            .percentage!)
                                    .round()
                                : weekPromotionController.selectedWeekPromotion
                                    .value!.descountPrice!,
                          );
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
                                                    product.images.first),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            height: 22,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomRight: Radius.circular(8),
                                              ),
                                              color: ColorResources.blue1,
                                            ),
                                            child: Center(
                                              child: Text(
                                                percentForTopBannerUI,
                                                style: const TextStyle(
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
                                      //"${searchController.searchlist[index]["text"]}",
                                      product.name,
                                      maxLines: 1,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${product.price}MMK",
                                          style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 14,
                                            fontFamily:
                                                TextFontFamily.SEN_EXTRA_BOLD,
                                            color: Color.fromARGB(
                                                255, 112, 123, 223),
                                          ),
                                        ),

                                        /* Obx(
                                      () => InkWell(
                                        onTap: () {
                                          controller.favourite[index] =
                                              !controller.favourite[index];
                                        },
                                        child:
                                            controller.favourite[index] == false
                                                ? SvgPicture.asset(
                                                    Images.blankfavoriteicon)
                                                : SvgPicture.asset(
                                                    Images.fillfavoriteicon),
                                      ),
                                    ), */
                                      ],
                                    ),
                                    weekPromotionController
                                            .selectedWeekPromotion
                                            .value!
                                            .isPercentage
                                        ? Text(
                                            "${product.promotion}MMK",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                                  TextFontFamily.SEN_EXTRA_BOLD,
                                              color: ColorResources.blue1,
                                            ),
                                          )
                                        : const SizedBox(),
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
                  child: Obx(() => weekPromotionController.isLoading.value
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
