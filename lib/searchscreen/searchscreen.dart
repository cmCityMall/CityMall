import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/searchscreen/search_controller.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:citymall/utils/widgets/empty_widgt.dart';
import 'package:citymall/utils/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constant/constant.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final SearchController searchController = Get.find();
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Stack(
              children: [
                //Searching Loading
                Obx(() {
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
                  return const Center(child: Text("Product found"));
                }),
                //Search Text Form Field
                Align(
                  alignment: Alignment.topCenter,
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        searchController.search(value);
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

                // ),
                //SearchHistory
                Obx(() {
                  if (!searchController.isFocus.value) {
                    return const SizedBox();
                  }
                  return AnimatedPositioned(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    top: 75,
                    child: SizedBox(
                      height: size.height,
                      width: size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width,
                              color: Colors.white,
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "RECENT",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: TextFontFamily.SEN_REGULAR,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.grey9
                                      : ColorResources.white.withOpacity(0.6),
                                ),
                              ),
                            ),
                            //Search History
                            ValueListenableBuilder(
                              valueListenable:
                                  Hive.box<String>(searchHistoryBox)
                                      .listenable(),
                              builder: (context, Box<String> box, __) {
                                return Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.all(10),
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    children: box.values.map((e) {
                                      return ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading:
                                              SvgPicture.asset(Images.clock),
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
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
