import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/clickcontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/productdetailsscreen/productdetailscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/address_controller.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final AddressClickController ontapAddressController =
      Get.put(AddressClickController());

  Text text(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: TextFontFamily.SEN_BOLD,
        fontSize: 14,
        color: themeController.isLightTheme.value
            ? ColorResources.black2
            : ColorResources.white,
      ),
    );
  }

  Container textFormField(
      String hint,
      String key,
      TextEditingController controller,
      String? Function(String? value, String key) validator,
      {TextInputType? textInputType}) {
    return Container(
      color: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black4,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        validator: (value) => validator(value, key),
        style: TextStyle(
            fontSize: 16,
            fontFamily: TextFontFamily.SEN_REGULAR,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white1),
        cursorColor: themeController.isLightTheme.value
            ? ColorResources.black3
            : ColorResources.white1,
        decoration: InputDecoration(
          fillColor: themeController.isLightTheme.value
              ? ColorResources.white
              : ColorResources.black4,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: TextFontFamily.SEN_REGULAR,
            fontSize: 14,
            color: themeController.isLightTheme.value
                ? ColorResources.grey7
                : ColorResources.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: themeController.isLightTheme.value
                  ? ColorResources.white2
                  : ColorResources.black5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: themeController.isLightTheme.value
                  ? ColorResources.white2
                  : ColorResources.black5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: themeController.isLightTheme.value
                  ? ColorResources.white2
                  : ColorResources.black5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: themeController.isLightTheme.value
                  ? ColorResources.white2
                  : ColorResources.black5,
            ),
          ),
        ),
      ),
    );
  }

  Container textFormField1(String hint) {
    return Container(
      color: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black4,
      child: TextFormField(
        style: TextStyle(
            fontSize: 16,
            fontFamily: TextFontFamily.SEN_REGULAR,
            color: themeController.isLightTheme.value
                ? ColorResources.black3
                : ColorResources.white1),
        cursorColor: themeController.isLightTheme.value
            ? ColorResources.black3
            : ColorResources.white1,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.arrow_drop_down_outlined,
            color: themeController.isLightTheme.value
                ? ColorResources.black4
                : ColorResources.white,
          ),
          fillColor: themeController.isLightTheme.value
              ? ColorResources.white
              : ColorResources.black4,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: TextFontFamily.SEN_REGULAR,
            fontSize: 14,
            color: themeController.isLightTheme.value
                ? ColorResources.grey7
                : ColorResources.white,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: themeController.isLightTheme.value
                  ? ColorResources.white2
                  : ColorResources.black5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: themeController.isLightTheme.value
                  ? ColorResources.white2
                  : ColorResources.black5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: themeController.isLightTheme.value
                  ? ColorResources.white2
                  : ColorResources.black5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: themeController.isLightTheme.value
                  ? ColorResources.white2
                  : ColorResources.black5,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.find();
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
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
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
          "Add Address",
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
            child: SingleChildScrollView(
              child: Form(
                key: addressController.formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text("Full Name"),
                    SizedBox(height: 10),
                    textFormField(
                        "John Doe",
                        "full name",
                        addressController.fullNameController,
                        addressController.validator),
                    SizedBox(height: 15),
                    text("Phone Number"),
                    SizedBox(height: 10),
                    textFormField(
                      "09912345678",
                      "phone number",
                      addressController.phoneNumberController,
                      addressController.validator,
                      textInputType: TextInputType.phone,
                    ),
                    SizedBox(height: 15),
                    text("Address"),
                    SizedBox(height: 10),
                    textFormField(
                      "78th Main Road, 100ft Road, Inditangar,..",
                      "address",
                      addressController.addressController,
                      addressController.validator,
                    ),
                    /*  SizedBox(height: 15),
                    text("Zipcode"),
                    SizedBox(height: 10),
                    textFormField("395006"), */
                    SizedBox(height: 15),
                    text("Country"),
                    SizedBox(height: 10),
                    textFormField(
                      "Myanmar",
                      "country",
                      addressController.countryController,
                      addressController.validator,
                    ),
                    SizedBox(height: 15),
                    text("City"),
                    SizedBox(height: 10),
                    textFormField(
                      "Mandalay",
                      "city",
                      addressController.cityController,
                      addressController.validator,
                    ),
                    SizedBox(height: 15),
                    text("District"),
                    SizedBox(height: 10),
                    textFormField(
                      "Chan Mya Thar Si",
                      "district",
                      addressController.districtController,
                      addressController.validator,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => InkWell(
                              onTap: () {
                                addressController.setSelectedAddressType(0);
                              },
                              child: Container(
                                height: 45,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.white
                                      : ColorResources.black4,
                                  border: Border.all(
                                      width: 1,
                                      color: addressController
                                                  .selectedAddressType.value ==
                                              0
                                          ? ColorResources.blue1
                                          : ColorResources.grey10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      Images.homefill,
                                      height: 15,
                                      width: 15,
                                      color: themeController.isLightTheme.value
                                          ? addressController
                                                      .selectedAddressType
                                                      .value ==
                                                  0
                                              ? ColorResources.blue1
                                              : ColorResources.black1
                                          : addressController
                                                      .selectedAddressType
                                                      .value ==
                                                  0
                                              ? ColorResources.blue1
                                              : ColorResources.white,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Home Address",
                                      style: TextStyle(
                                        fontFamily: TextFontFamily.SEN_BOLD,
                                        fontSize: 14,
                                        color:
                                            themeController.isLightTheme.value
                                                ? addressController
                                                            .selectedAddressType
                                                            .value ==
                                                        0
                                                    ? ColorResources.blue1
                                                    : ColorResources.black1
                                                : addressController
                                                            .selectedAddressType
                                                            .value ==
                                                        0
                                                    ? ColorResources.blue1
                                                    : ColorResources.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Obx(
                            () => InkWell(
                              onTap: () {
                                addressController.setSelectedAddressType(1);
                              },
                              child: Container(
                                height: 45,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.white
                                      : ColorResources.black4,
                                  border: Border.all(
                                      width: 1,
                                      color: addressController
                                                  .selectedAddressType.value ==
                                              1
                                          ? ColorResources.blue1
                                          : ColorResources.grey10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      Images.office,
                                      height: 15,
                                      width: 15,
                                      color: themeController.isLightTheme.value
                                          ? addressController
                                                      .selectedAddressType
                                                      .value ==
                                                  1
                                              ? ColorResources.blue1
                                              : ColorResources.black1
                                          : addressController
                                                      .selectedAddressType
                                                      .value ==
                                                  1
                                              ? ColorResources.blue1
                                              : ColorResources.white,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Office Address",
                                      style: TextStyle(
                                        fontFamily: TextFontFamily.SEN_BOLD,
                                        fontSize: 14,
                                        color:
                                            themeController.isLightTheme.value
                                                ? addressController
                                                            .selectedAddressType
                                                            .value ==
                                                        1
                                                    ? ColorResources.blue1
                                                    : ColorResources.black1
                                                : addressController
                                                            .selectedAddressType
                                                            .value ==
                                                        1
                                                    ? ColorResources.blue1
                                                    : ColorResources.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        addressController.saveIntoHive();
                      },
                      child: Container(
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: ColorResources.blue1,
                        ),
                        child: const Center(
                          child: Text(
                            "Save Address",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_BOLD,
                              fontSize: 20,
                              color: ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
