import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/searchscreen/search_controller.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:citymall/utils/widgets/empty_widgt.dart';
import 'package:citymall/utils/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constant/constant.dart';
import '../model/favourite_item.dart';
import '../productdetailsscreen/product_detail_binding.dart';
import '../productdetailsscreen/productdetailscreen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final SearchController searchController = Get.find();
    final DBDataController dbDataController = Get.find();
    final size = MediaQuery.of(context).size;
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
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: themeController.isLightTheme.value
                ? ColorResources.white1
                : ColorResources.black1,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                //Searching Loading
                Obx(() {
                  final list = searchController.searchResultMap;
                  if (searchController.isSearching.value) {
                    return const Align(
                      alignment: Alignment.center,
                      child: LoadingWidget(),
                    );
                  }
                  if (searchController.searchResultMap
                          .containsKey(searchController.searchValue.value) &&
                      searchController
                          .searchResultMap[searchController.searchValue.value]!
                          .isEmpty) {
                    return const Align(
                        alignment: Alignment.center,
                        child: EmptyWidget("No products found."));
                  }
                  if (!searchController.searchResultMap
                      .containsKey(searchController.searchValue.value)) {
                    return const Align(
                        alignment: Alignment.center,
                        child: EmptyWidget("Let's search..."));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 70,
                    ),
                    child: GridView.builder(
                      itemCount:
                          list[searchController.searchValue.value]!.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.55,
                      ),
                      itemBuilder: (context, index) {
                        final product =
                            list[searchController.searchValue.value]![index];
                        return InkWell(
                          onTap: () {
                            dbDataController.setSelectedProduct(product);
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
                                      height: 160,
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
                                                  FavouriteItem(
                                                    id: product.id,
                                                    name: product.name,
                                                    image: product.images.first,
                                                    price: product.price,
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
                                            size: 10,
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
                    ),
                  );
                }),
                //Search Text Form Field
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      onFieldSubmitted: (value) async {
                        if (value.isNotEmpty &&
                            value.removeAllWhitespace.isNotEmpty) {
                          await searchController.search(value);
                        } else {
                          //Set empty to not show no product found.
                          searchController.searchValue.value = "";
                        }
                      },
                      focusNode: searchController.focusNode,
                      style: TextStyle(
                          fontFamily: TextFontFamily.SEN_REGULAR,
                          fontSize: 15,
                          color: themeController.isLightTheme.value
                              ? ColorResources.black2
                              : ColorResources.white),
                      cursorColor: ColorResources.grey,
                      //maxLines: 2,
                      // onChanged: searchController.onSearchTextChanged,
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Search Product Name",
                        hintStyle: const TextStyle(
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
                  ),
                ),
                //SearchHistory
                Obx(() {
                  if (!searchController.isFocus.value) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 70,
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        width: size.width,
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "RECENT",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.grey9
                                    : ColorResources.white.withOpacity(0.6),
                              ),
                            ),
                            //Search History
                            ValueListenableBuilder(
                              valueListenable:
                                  Hive.box<String>(searchHistoryBox)
                                      .listenable(),
                              builder: (context, Box<String> box, __) {
                                return ListView(
                                  shrinkWrap: true,
                                  primary: false,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: box.values.map((e) {
                                    return ListTile(
                                        onTap: () => searchController.search(e),
                                        contentPadding: EdgeInsets.zero,
                                        leading: SvgPicture.asset(Images.clock),
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                e,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: TextFontFamily
                                                      .SEN_REGULAR,
                                                  color: themeController
                                                          .isLightTheme.value
                                                      ? ColorResources.black
                                                      : ColorResources.white,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                onPressed: () =>
                                                    searchController
                                                        .removeFromHistoryBox(
                                                            e),
                                                icon: Icon(
                                                  Icons.close,
                                                  color: themeController
                                                          .isLightTheme.value
                                                      ? ColorResources.black
                                                      : ColorResources.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  }).toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
