import 'package:carousel_slider/carousel_slider.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/constant/mock.dart';
import 'package:citymall/controller/camerahomefavoritecontroller.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/discount_product_viewall/bin/dpva_binding.dart';
import 'package:citymall/discount_product_viewall/view/dpva_view.dart';
import 'package:citymall/homescreen/cameradashboardscreen/action_screen_binding.dart';
import 'package:citymall/homescreen/cameradashboardscreen/actionscreen.dart';
import 'package:citymall/homescreen/subcategoryview_all/bin/scva_binding.dart';
import 'package:citymall/homescreen/subcategoryview_all/view/subcategory_view_all.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/searchscreen/subsearchscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constant/constant.dart';
import '../../model/favourite_item.dart';
import '../../new_products_viewall/bin/npva_binding.dart';
import '../../new_products_viewall/view/npva_view.dart';
import '../../popular_produts_viewall/bin/ppva_binding.dart';
import '../../popular_produts_viewall/view/ppva_view.dart';
import '../../productdetailsscreen/product_detail_binding.dart';
import '../../productdetailsscreen/productdetailscreen.dart';
import '../../utils/widgets/empty_widgt.dart';
import '../../utils/widgets/loading_widget.dart';

// ignore: must_be_immutable
class CameraDeshBoard extends StatelessWidget {
  CameraDeshBoard({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final CameraHomeFavouriteController favorite =
      Get.put(CameraHomeFavouriteController());

  @override
  Widget build(BuildContext context) {
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
          dbDataController.mainName,
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 22,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
        /*  actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: InkWell(
              onTap: () {
                Get.to(() => SubSearchScreen());
              },
              child: SvgPicture.asset(
                Images.search,
                color: themeController.isLightTheme.value
                    ? ColorResources.white3
                    : ColorResources.white.withOpacity(0.6),
              ),
            ),
          ),
        ], */
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
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    final mainData = dbDataController.sliderProducts;
                    final dataList = mainData[dbDataController.mainId];
                    final isLoading = dbDataController
                        .sliderProductsLoading[dbDataController.mainId];

                    if (!(isLoading == null) && isLoading == true) {
                      return const LoadingWidget();
                    }
                    if (dataList == null || dataList.isEmpty) {
                      return const SizedBox();
                    }
                    return CarouselSlider.builder(
                      itemCount: dataList.length,
                      itemBuilder:
                          (BuildContext context, index, int pageViewIndex) =>
                              Stack(
                        children: [
                          Container(
                            height: 200,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image:
                                    NetworkImage(dataList[index].images.first),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                Images.cameracanvas,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                dbDataController.mainName,
                                style: TextStyle(
                                  fontFamily: TextFontFamily.SEN_BOLD,
                                  fontSize: 18,
                                  color: ColorResources.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        initialPage: 3,
                        viewportFraction: 0.8,
                        //aspectRatio: 3.0,
                      ),
                    );
                  }),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sub Category",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: TextFontFamily.SEN_BOLD,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                dbDataController.getMoreSubCategories(
                                  dbDataController.mainId,
                                  20,
                                );
                                Get.to(
                                  () => SubCategoryViewAll(),
                                  binding: SCVABinding(),
                                );
                                /* Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CameraSubCategoryViewAllScreen(),
                                    )); */
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View all  ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      color: ColorResources.blue1,
                                    ),
                                  ),
                                  SvgPicture.asset(Images.viewallarrow),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: Get.height > 805 ? 140 : 115,
                          width: Get.width,
                          color: themeController.isLightTheme.value
                              ? ColorResources.white1
                              : ColorResources.black1,
                          child: Obx(() {
                            final mainData = dbDataController.subCategories;
                            final dataList = mainData[dbDataController.mainId];
                            final isLoading = dbDataController
                                .subCategoriesLoading[dbDataController.mainId];
                            if (!(isLoading == null) && isLoading == true) {
                              return const LoadingWidget();
                            }
                            if (dataList == null || dataList.isEmpty) {
                              return const EmptyWidget("No SubCategory found");
                            }
                            return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.2,
                              ),
                              itemCount: dataList.length,
                              itemBuilder: (context, index) {
                                final subCategory = dbDataController
                                        .subCategories[dbDataController.mainId]
                                    ?[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, right: 5),
                                  child: InkWell(
                                    onTap: () {
                                      dbDataController.setSelectedSub(
                                        subCategory!.id,
                                        subCategory.name,
                                      );
                                      dbDataController
                                          .getInitialProducts(subCategory.id);
                                      Get.to(
                                        () => const ActionScreen(),
                                        binding: ActionScreenBinding(),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              subCategory?.image ??
                                                  mockSubImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Colors.black.withOpacity(0.3),
                                        ),
                                        child: Center(
                                          child: Text(
                                            subCategory?.name ?? "Null",
                                            style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.SEN_BOLD,
                                              fontSize: 14,
                                              color: ColorResources.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                        SizedBox(height: 20),
                        /* Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Item Discount",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: TextFontFamily.SEN_BOLD,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => DPVAView(),
                                    binding: DPVABinding());
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View all  ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      color: ColorResources.blue1,
                                    ),
                                  ),
                                  SvgPicture.asset(Images.viewallarrow),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Obx(() {
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
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                        color:
                                            themeController.isLightTheme.value
                                                ? ColorResources.blue1
                                                    .withOpacity(0.05)
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                      dataList[index]
                                                          .images
                                                          .first,
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                  color: ColorResources.blue1,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    dataList[index]
                                                        .promotion
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          ColorResources.white,
                                                      fontSize: 12,
                                                      fontFamily: TextFontFamily
                                                          .SEN_BOLD,
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
                                            color: themeController
                                                    .isLightTheme.value
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
                                                fontFamily: TextFontFamily
                                                    .SEN_EXTRA_BOLD,
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
                        SizedBox(height: 20), */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Item Popular",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: TextFontFamily.SEN_BOLD,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => PPVAView(),
                                    binding: PPVABinding());
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View all  ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      color: ColorResources.blue1,
                                    ),
                                  ),
                                  SvgPicture.asset(Images.viewallarrow),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Obx(() {
                          final mainData = dbDataController.popularProducts;
                          final dataList = mainData[dbDataController.mainId];
                          final isLoading = dbDataController
                              .popularProductsLoading[dbDataController.mainId];
                          if (!(isLoading == null) && isLoading == true) {
                            return const LoadingWidget();
                          }
                          if (dataList == null || dataList.isEmpty) {
                            return const EmptyWidget(
                                "No Popular Products yet.");
                          }
                          return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: dataList.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.58,
                            ),
                            itemBuilder: (context, index) {
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
                                        color:
                                            themeController.isLightTheme.value
                                                ? ColorResources.blue1
                                                    .withOpacity(0.05)
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                      dataList[index]
                                                          .images
                                                          .first,
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                  color: ColorResources.blue1,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    dataList[index]
                                                        .promotion
                                                        .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          ColorResources.white,
                                                      fontSize: 12,
                                                      fontFamily: TextFontFamily
                                                          .SEN_BOLD,
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
                                            color: themeController
                                                    .isLightTheme.value
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
                                                fontFamily: TextFontFamily
                                                    .SEN_EXTRA_BOLD,
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
                                                  Box<FavouriteItem> box,
                                                  widget) {
                                                final currentObj =
                                                    box.get(dataList[index].id);

                                                if (!(currentObj == null)) {
                                                  return IconButton(
                                                      onPressed: () {
                                                        box.delete(
                                                            currentObj.id);
                                                      },
                                                      icon: const Icon(
                                                        FontAwesomeIcons
                                                            .solidHeart,
                                                        color: Colors.red,
                                                        size: 25,
                                                      ));
                                                }
                                                return IconButton(
                                                    onPressed: () {
                                                      box.put(
                                                          dataList[index].id,
                                                          dbDataController
                                                              .changeProductToHive(
                                                            dataList[index],
                                                            normalProduct,
                                                          ));
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
                                                  dataList[index].reviewCount +
                                                      0.0,
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
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "New Item",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: TextFontFamily.SEN_BOLD,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(
                                  () => NPVAView(),
                                  binding: NPVABinding(),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View all  ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      color: ColorResources.blue1,
                                    ),
                                  ),
                                  SvgPicture.asset(Images.viewallarrow),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Obx(() {
                          final mainData = dbDataController.newProducts;
                          final dataList = mainData[dbDataController.mainId];
                          final isLoading = dbDataController
                              .newProductsLoading[dbDataController.mainId];
                          if (!(isLoading == null) && isLoading == true) {
                            return const LoadingWidget();
                          }
                          if (dataList == null || dataList.isEmpty) {
                            return const EmptyWidget("No new products yet.");
                          }
                          return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: dataList.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                        color:
                                            themeController.isLightTheme.value
                                                ? ColorResources.blue1
                                                    .withOpacity(0.05)
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                      dataList[index]
                                                          .images
                                                          .first,
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                  ),
                                                  color: ColorResources.blue1,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    dataList[index].promotion ==
                                                            null
                                                        ? "NEW"
                                                        : dataList[index]
                                                            .promotion
                                                            .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          ColorResources.white,
                                                      fontSize: 12,
                                                      fontFamily: TextFontFamily
                                                          .SEN_BOLD,
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
                                            color: themeController
                                                    .isLightTheme.value
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
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: TextFontFamily
                                                    .SEN_EXTRA_BOLD,
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
                                                  Box<FavouriteItem> box,
                                                  widget) {
                                                final currentObj =
                                                    box.get(dataList[index].id);

                                                if (!(currentObj == null)) {
                                                  return IconButton(
                                                      onPressed: () {
                                                        box.delete(
                                                            currentObj.id);
                                                      },
                                                      icon: const Icon(
                                                        FontAwesomeIcons
                                                            .solidHeart,
                                                        color: Colors.red,
                                                        size: 25,
                                                      ));
                                                }
                                                return IconButton(
                                                    onPressed: () {
                                                      box.put(
                                                          dataList[index].id,
                                                          dbDataController
                                                              .changeProductToHive(
                                                            dataList[index],
                                                            normalProduct,
                                                          ));
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
                                                  dataList[index].reviewCount +
                                                      0.0,
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
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
