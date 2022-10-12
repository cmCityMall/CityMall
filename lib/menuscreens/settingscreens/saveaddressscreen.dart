import 'package:citymall/address_form_screen/view/addaddressscreen.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/menuscreens/settingscreens/settingaddaddressscreen.dart';
import 'package:citymall/menuscreens/settingscreens/settingscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../address_form_screen/bin/address_form_binding.dart';
import '../../constant/constant.dart';
import '../../model/hive_personal_address.dart';

class SaveAddressScreen extends StatelessWidget {
  SaveAddressScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
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
          "Saved Addresses",
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ValueListenableBuilder(
                  valueListenable:
                      Hive.box<HivePersonalAddress>(addressBox).listenable(),
                  builder: (context, Box<HivePersonalAddress> box, __) {
                    return ListView(
                      shrinkWrap: true,
                      children: box.values.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            height: 160,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: themeController.isLightTheme.value
                                  ? ColorResources.white
                                  : ColorResources.black6,
                              border: Border.all(
                                color: themeController.isLightTheme.value
                                    ? ColorResources.grey13
                                    : ColorResources.black5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            Images.homefill,
                                            color: themeController
                                                    .isLightTheme.value
                                                ? ColorResources.black2
                                                : ColorResources.white,
                                            height: 15,
                                            width: 15,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            e.addressType == 0
                                                ? "Home Address"
                                                : "Office Address",
                                            style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.SEN_BOLD,
                                              fontSize: 14,
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          dataController
                                              .setSelectedHivePersonalAddress(
                                                  e);
                                          Get.to(() => AddAddressScreen(),
                                              binding: AddressFormBinding());
                                        },
                                        child: SvgPicture.asset(
                                          Images.editicon,
                                          color: ColorResources.blue1,
                                          height: 22,
                                          width: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    e.fullName,
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_BOLD,
                                      fontSize: 14,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "${e.phoneNumber}",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 13,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    e.address,
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 13,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black9
                                          : ColorResources.white
                                              .withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  })),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dataController.setSelectedHivePersonalAddress(null);
          Get.to(
            () => AddAddressScreen(),
            binding: AddressFormBinding(),
          );
        },
        elevation: 0,
        backgroundColor: ColorResources.blue1,
        child: Icon(
          Icons.add,
          color: ColorResources.white,
          size: 35,
        ),
      ),
    );
  }
}
