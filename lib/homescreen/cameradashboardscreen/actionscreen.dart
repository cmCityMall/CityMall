import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/action_screen_controller.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/controller/weekpromotionfavoritecontroller.dart';
import 'package:citymall/dialoguescreen/dialoguescreen.dart';
import 'package:citymall/homescreen/cameradashboardscreen/action_screen_controller.dart';
import 'package:citymall/homescreen/cameradashboardscreen/cameradeshboard.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/productdetailsscreen/productdetailscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constant/constant.dart';
import '../../model/favourite_item.dart';
import '../../productdetailsscreen/product_detail_binding.dart';

// ignore: must_be_immutable
class ActionScreen extends StatefulWidget {
  const ActionScreen({Key? key}) : super(key: key);

  @override
  State<ActionScreen> createState() => _ActionScreenState();
}

class _ActionScreenState extends State<ActionScreen> {
  final ThemeController themeController = Get.put(ThemeController());

  final WeekPromotionFavouriteController controller =
      Get.put(WeekPromotionFavouriteController());

  @override
  void initState() {
    Get.put(ActionScreenController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ActionScreenController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DBDataController dbDataController = Get.find();
    final ActionScreenController actionController = Get.find();
    final ActionController aController = Get.find();
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
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: themeController.isLightTheme.value
                ? ColorResources.white1
                : ColorResources.black1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Obx(() {
                    final mainData = dbDataController.products;
                    final dataList = aController.isSort.value
                        ? aController.dataList
                        : mainData[dbDataController.subId];
                    final isLoading = dbDataController
                        .productsLoading[dbDataController.subId];
                    if (aController.isSortLoading.value) {
                      return const Center(
                          child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ));
                    }
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
                      controller: actionController.scrollController,
                      itemCount: dataList.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio:
                            0.58, /* Get.width > 450
                            ? 1.58 / 2.1
                            : Get.width < 370
                                ? 1.62 / 2.68
                                : 1.8 / 2., */
                      ),
                      itemBuilder: (context, index) {
                        final product = dataList[index];
                        return InkWell(
                          onTap: () {
                            dbDataController
                                .setSelectedProduct(dataList[index]);
                            Get.to(
                              () => ProductDetailScreen(),
                              binding: ProductDetailBinding(),
                            );
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
                                                product.images.first,
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        child: Container(
                                          height: 22,
                                          width: 50,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(8),
                                            ),
                                            color: ColorResources.blue1,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${product.promotion ?? 0}%",
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
                                    product.name,
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
                                        product.price.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              TextFontFamily.SEN_EXTRA_BOLD,
                                          color: ColorResources.blue1,
                                        ),
                                      ),
                                      //Favourite Icon
                                      ValueListenableBuilder(
                                        valueListenable:
                                            Hive.box<FavouriteItem>(
                                                    favouriteBox)
                                                .listenable(),
                                        builder: (context,
                                            Box<FavouriteItem> box, widget) {
                                          final currentObj =
                                              box.get(product.id);

                                          if (!(currentObj == null)) {
                                            return IconButton(
                                                onPressed: () {
                                                  box.delete(currentObj.id);
                                                },
                                                icon: const Icon(
                                                  FontAwesomeIcons.solidHeart,
                                                  color: Colors.red,
                                                  size: 25,
                                                ));
                                          }
                                          return IconButton(
                                              onPressed: () {
                                                box.put(
                                                  product.id,
                                                  dbDataController
                                                      .changeProductToHive(
                                                    product,
                                                    normalProduct,
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.favorite_outline,
                                                color: Colors.red,
                                                size: 25,
                                              ));
                                        },
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
                                        initialRating:
                                            dataList[index].reviewCount + 0.0,
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
                                        "${dataList[index].reviewCount + 0.0}",
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
              Obx(() => actionController.isLoading.value
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      height: 35,
                      width: 35,
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
