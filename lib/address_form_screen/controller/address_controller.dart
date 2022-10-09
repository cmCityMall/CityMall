import 'package:citymall/constant/constant.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/model/hive_personal_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../model/hive_personal_address.dart';

class AddressController extends GetxController {
  final DBDataController dataController = Get.find();

  final addBox = Hive.box<HivePersonalAddress>(addressBox);
  //**For Form */
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  var selectedAddressType = 0.obs;
  //**End */

  void setSelectedAddressType(int value) => selectedAddressType.value = value;

  String? validator(String? value, String key) {
    if (value == null || value.isEmpty) {
      return "$key is required";
    } else {
      return null;
    }
  }

  @override
  void onInit() {
    final hivePerson = dataController.selectedHivePersonalAddress.value;
    if (!(hivePerson == null)) {
      fullNameController.text = hivePerson.fullName;
      phoneNumberController.text = hivePerson.phoneNumber.toString();
      addressController.text = hivePerson.address;
      countryController.text = hivePerson.country;
      cityController.text = hivePerson.city;
      zipCodeController.text = hivePerson.zipCode.toString();
      districtController.text = hivePerson.district;
      selectedAddressType.value = hivePerson.addressType;
    }
    super.onInit();
  }

  void saveIntoHive() {
    if (formState.currentState?.validate() == true) {
      final hivePerson = HivePersonalAddress(
        fullName: fullNameController.text,
        address: addressController.text,
        country: countryController.text,
        city: cityController.text,
        zipCode: int.tryParse(zipCodeController.text) ?? 0,
        district: districtController.text,
        addressType: selectedAddressType.value,
        id: dataController.selectedHivePersonalAddress.value == null
            ? Uuid().v1()
            : dataController.selectedHivePersonalAddress.value!.id,
        phoneNumber: int.tryParse(phoneNumberController.text) ?? 0,
      );

      addBox.put(hivePerson.id, hivePerson);
      clearAll();
    }
  }

  void clearAll() {
    fullNameController.clear();
    phoneNumberController.clear();
    addressController.clear();
    cityController.clear();
    countryController.clear();
    districtController.clear();
  }
}
