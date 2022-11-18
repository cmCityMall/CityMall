import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/recomendedfavoritecontroller.dart';
import 'package:citymall/controller/recommend_screen_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/dialoguescreen/dialoguescreen.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/productdetailsscreen/productdetailscreen.dart';
import 'package:citymall/productdetailsscreen/recommend_dialog.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:citymall/utils/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constant/constant.dart';
import '../model/favourite_item.dart';
import '../productdetailsscreen/product_detail_binding.dart';

// ignore: must_be_immutable
class RecomendedScreen extends StatelessWidget {
  RecomendedScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final RecomendedFavouriteController controller =
      Get.put(RecomendedFavouriteController());

  @override
  Widget build(BuildContext context) {
    final RecommendScreenController recoController = Get.find();
    final DBDataController dataController = Get.find();
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
              /* selectedIndex = 0;
              Navigator.of(context, rootNavigator: true)
                  .pushReplacement(MaterialPageRoute(
                builder: (context) => NavigationBarBottom(),
              )); */
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
          "Popular Products",
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
                    return RecommendDialog();
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
                    final dataList = recoController.isSort.value
                        ? recoController.dataList
                        : dataController.homePopularProducts;
                    if (recoController.isSortLoading.value) {
                      return const LoadingWidget();
                    }
                    return GridView.builder(
                      itemCount: dataList.length,
                      shrinkWrap: true,
                      controller: recoController.scrollController,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio:
                            0.58 /* Get.width > 450
                            ? 1.58 / 2.1
                            : Get.width < 370
                                ? 1.62 / 2.68
                                : 1.8 / 2.5 */
                        ,
                      ),
                      itemBuilder: (context, index) {
                        final product = dataList[index];
                        return InkWell(
                          onTap: () {
                            dataController.setSelectedProduct(
                                dataController.brandProducts[dataController
                                    .selectedBrand.value!.id]![index]);
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
                                  InkWell(
                                    onTap: () {
                                      Get.defaultDialog(
                                        backgroundColor: ColorResources.white6,
                                        contentPadding: EdgeInsets.zero,
                                        title: "",
                                        titlePadding: EdgeInsets.zero,
                                        content: Center(
                                          child: Image.network(
                                            product.images.first,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 150,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: ColorResources.white6,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Image.network(
                                          product.images.first,
                                        ),
                                      ),
                                    ),
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
                                        "${product.price}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              TextFontFamily.SEN_EXTRA_BOLD,
                                          fontWeight: FontWeight.w800,
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
                                                  dataController
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
                                            product.reviewCount + 0.0,
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
                                        "${product.reviewCount + 0.0}",
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
                child: Obx(() => recoController.isLoading.value
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
