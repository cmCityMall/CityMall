import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/notificationscreen/notificationscreen.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SubSearchScreen extends StatelessWidget {
  SubSearchScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  //SearchController searchController = Get.put(SearchController());
  final List<Map> searchList = [
    {"text": "Action Camera"},
    {"text": "Cable"},
    {"text": "Macbook"},
  ];

  @override
  Widget build(BuildContext context) {
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
              // Get.back();
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
          "Search",
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
            padding: const EdgeInsets.only(right: 25),
            child: InkWell(
              onTap: () {
                Get.off(NotificationScreen());
              },
              child: SvgPicture.asset(
                Images.notification,
                color: themeController.isLightTheme.value
                    ? ColorResources.white3
                    : ColorResources.white.withOpacity(0.6),
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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: themeController.isLightTheme.value
                ? ColorResources.white1
                : ColorResources.black1,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    // onChanged: searchController.onSearchTextChanged,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: themeController.isLightTheme.value
                            ? ColorResources.navyblue
                            : ColorResources.white,
                      ),
                      //isDense: true,
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
                  //),
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
                  Container(
                    height: 300,
                    width: Get.width,
                    child:
                        //Obx(() =>
                        ListView.builder(
                            //itemCount: searchController.searchlist.length,
                            itemCount: searchList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: SvgPicture.asset(Images.clock),
                                    title: Text(
                                      // " ${searchController
                                      //     .searchlist[index]["text"]}",
                                      searchList[index]["text"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: TextFontFamily.SEN_REGULAR,
                                        color:
                                            themeController.isLightTheme.value
                                                ? ColorResources.black
                                                : ColorResources.white,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.close,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black
                                          : ColorResources.white,
                                    )),
                              );
                            }),
                    // ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
